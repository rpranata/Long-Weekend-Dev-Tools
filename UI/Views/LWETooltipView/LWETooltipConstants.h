//
//  LWETooltipConstants.h
//  LocationBasedMessaging
//
//  Created by Mark Makdad on 7/15/10.
//  Copyright 2010 Long Weekend Inc. All rights reserved.
//

enum
{
  LWETooltipCalloutPositionTop,
  LWETooltipCalloutPositionBottom,
  LWETooltipCalloutPositionLeft,
  LWETooltipCalloutPositionRight
};
typedef NSUInteger LWETooltipCalloutPosition;

enum
{
  LWETooltipCalloutDirectionLeftToRight,
  LWETooltipCalloutDirectionRightToLeft,
  LWETooltipCalloutDirectionStraight
};
typedef NSUInteger LWETooltipCalloutDirection;

enum
{
  LWETooltipCalloutOffsetNone,
  LWETooltipCalloutOffsetLeft,
  LWETooltipCalloutOffsetRight
};
typedef NSUInteger LWETooltipCalloutOffset;

enum 
{
  LWETooltipCloseButtonPositionTopLeft,
  LWETooltipCloseButtonPositionTopRight,
  LWETooltipCloseButtonPositionBottomLeft,  
  LWETooltipCloseButtonPositionBottomRight
};
typedef NSUInteger LWETooltipCloseButtonPosition;

#define kDefaultStrokeColor         [UIColor clearColor]
#define kDefaultBackgroundColor			[UIColor clearColor]
#define kDefaultRectColor           [UIColor blueColor]
#define kDefaultStrokeWidth         1.0f
#define kDefaultCornerRadius        20.0
#define kDefaultShadowBlur          2.5