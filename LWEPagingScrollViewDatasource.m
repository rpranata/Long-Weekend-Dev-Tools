// LWEPagingScrollViewDatasource.m
//
// Copyright (c) 2011 Long Weekend LLC
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

#import "LWEPagingScrollViewDatasource.h"

@implementation LWEPagingScrollViewDatasource

@synthesize dataPages;

- (id) init
{
  [NSException raise:@"Invalid Initializer" format:@"Use initWithDataPages instead"];
  
  return self;
}

- (id) initWithDataPages:(NSArray*)data
{
  if((self == [super init]))
  {
    self.dataPages = data;
  }
  
  return self;
}

//! returns the number of pages in the datasource
- (NSInteger)numDataPages
{
	return [dataPages count];
}

//! Returns the dictionary of data for a given page
- (NSDictionary *)dataForPage:(NSInteger)pageIndex
{
	return [dataPages objectAtIndex:pageIndex];
}

@end
