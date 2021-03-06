// LWEPagingScrollViewController.m
//
// Based on Original Version
// Created by Matt Gallagher on 24/01/09.
// Copyright 2009 Matt Gallagher. All rights reserved.
//
// Original License Terms:
// Permission is given to use this source code file, free of charge, in any
// project, commercial or otherwise, entirely at your risk, with the condition
// that any redistribution (in part or whole) of source code must retain
// this copyright and permission notice. Attribution in compiled projects is
// appreciated but not required.
// 
// Updates & Additions
// Copyright (c) 2010, 2011, 2012 Long Weekend LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "LWEPagingScrollViewController.h"

@interface LWEPagingScrollViewController ()
//! These methods call out to the delegate if set, otherwise they have default implementation
- (id<LWEPageViewControllerProtocol>) setupCurrentPage;
- (id<LWEPageViewControllerProtocol>) setupNextPage;
@end

@implementation LWEPagingScrollViewController

@synthesize datasource, delegate, currentPage, nextPage, scrollView, pageControl;

- (void)applyNewIndex:(NSInteger)newIndex pageController:(id<LWEPageViewControllerProtocol>)pageController
{
	NSInteger pageCount = [self.datasource numDataPages];
	BOOL outOfBounds = newIndex >= pageCount || newIndex < 0;

	if (!outOfBounds)
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = 0;
		pageFrame.origin.x = self.scrollView.frame.size.width * newIndex;
		pageController.view.frame = pageFrame;
	}
	else
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = self.scrollView.frame.size.height;
		pageController.view.frame = pageFrame;
	}

	pageController.pageIndex = newIndex;
  
  // Tell the page controller it needs an update now
  if ([pageController respondsToSelector:@selector(setNeedsUpdate)])
  {
    [pageController setNeedsUpdate];
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
	self.currentPage = [self setupCurrentPage];
	self.nextPage = [self setupNextPage];
  
	[self.scrollView addSubview:self.currentPage.view];
	[self.scrollView addSubview:self.nextPage.view];
  [self.scrollView bringSubviewToFront:self.pageControl];

	NSInteger widthCount = [self.datasource numDataPages];
	if (widthCount == 0)
	{
		widthCount = 1;
	}
	
  self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * widthCount, self.scrollView.frame.size.height);
	self.scrollView.contentOffset = CGPointMake(0, 0);
	self.pageControl.numberOfPages = [self.datasource numDataPages];
  
  LWE_LOG(@"The current page index is: %i", pageControl.currentPage);
	
	[self applyNewIndex:0 pageController:self.currentPage];
	[self applyNewIndex:1 pageController:self.nextPage];
  
  [self changePageAnimated:NO]; // go to the current page
}

#pragma mark - Delegate Implementation

- (id<LWEPageViewControllerProtocol>) setupCurrentPage
{
  if (self.delegate && ([self.delegate respondsToSelector:@selector(setupCurrentPage:)]))
  {
    id<LWEPageViewControllerProtocol> tmpVC = [self.delegate setupCurrentPage:self];
    tmpVC.dataSource = self;
    return tmpVC;
  }
  else
  {
    return nil;
  }
}

- (id<LWEPageViewControllerProtocol>) setupNextPage
{
  if (self.delegate && ([self.delegate respondsToSelector:@selector(setupNextPage:)]))
  {
    id<LWEPageViewControllerProtocol> tmpVC = [self.delegate setupNextPage:self];
    tmpVC.dataSource = self;
    return tmpVC;
  }
  else
  {
    return nil;
  }
}

#pragma mark - LWEPageViewControllerDatasource Implementation

//! A page will ask for it's data, and this is the default implementation. Override to do something different
- (id) dataForPage:(NSInteger)pageIndex
{
  if (pageIndex > [[self datasource] numDataPages] - 1 || pageIndex < 0) // ignore out of range requests. The pages are dumb
  {
    return nil;
  }
  else
  {
    return [[[self datasource] dataPages] objectAtIndex:pageIndex];
  }
}

#pragma mark - UIScrollViewDelegate Support

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
  CGFloat pageWidth = self.scrollView.frame.size.width;
  CGFloat fractionalPage = self.scrollView.contentOffset.x / pageWidth;
	
	NSInteger lowerNumber = floor(fractionalPage);
	NSInteger upperNumber = lowerNumber + 1;
	
	if (lowerNumber == self.currentPage.pageIndex)
	{
		if (upperNumber != self.nextPage.pageIndex)
		{
			[self applyNewIndex:upperNumber pageController:self.nextPage];
		}
	}
	else if (upperNumber == self.currentPage.pageIndex)
	{
		if (lowerNumber != self.nextPage.pageIndex)
		{
			[self applyNewIndex:lowerNumber pageController:self.nextPage];
		}
	}
	else
	{
		if (lowerNumber == self.nextPage.pageIndex)
		{
			[self applyNewIndex:upperNumber pageController:self.currentPage];
		}
		else if (upperNumber == self.nextPage.pageIndex)
		{
			[self applyNewIndex:lowerNumber pageController:self.currentPage];
		}
		else
		{
			[self applyNewIndex:lowerNumber pageController:self.currentPage];
			[self applyNewIndex:upperNumber pageController:self.nextPage];
		}
	}
	
  [self.currentPage updateViews:NO];
	[self.nextPage updateViews:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)newScrollView
{
  CGFloat pageWidth = self.scrollView.frame.size.width;
  float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
	NSInteger nearestNumber = lround(fractionalPage);

	if (self.currentPage.pageIndex != nearestNumber)
	{
		id<LWEPageViewControllerProtocol> swapController = [self.currentPage retain];
		self.currentPage = self.nextPage;
		self.nextPage = swapController;
    [swapController release];
	}

  // defeats the race condition where the user can "beat" you to an un updated view
	[self.currentPage updateViews:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)newScrollView
{
	[self scrollViewDidEndScrollingAnimation:newScrollView];
	self.pageControl.currentPage = self.currentPage.pageIndex;
}

- (void)changePageAnimated:(BOOL)animated
{
  NSInteger pageIndex = self.pageControl.currentPage;

	// update the scroll view to the appropriate page
  CGRect frame = self.scrollView.frame;
  frame.origin.x = frame.size.width * pageIndex;
  frame.origin.y = 0;
  [self.scrollView scrollRectToVisible:frame animated:animated];
}

- (IBAction)changePage:(id)sender
{
	[self changePageAnimated:YES];
}

- (void) viewDidUnload
{
 	self.currentPage = nil;
	self.nextPage = nil;
  self.scrollView = nil;
  self.pageControl = nil;
  
  [super viewDidUnload];
}

- (void)dealloc
{
  self.datasource = nil;
	self.currentPage = nil;
	self.nextPage = nil;
  self.scrollView = nil;
  self.pageControl = nil;
	
	[super dealloc];
}

@end
