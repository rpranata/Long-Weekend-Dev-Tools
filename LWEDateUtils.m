//
//  LWEDateUtils
//  phone
//
//  Created by Mark Makdad on 12/7/10.
//  Copyright 2010 Long Weekend LLC. All rights reserved.
//

#import "LWEDateUtils.h"

@implementation LWEDateUtils

/**
 * This method exists in NSDateFormatter in iOS4 but not before that,
 * so this convenience method helps us cut down on extra code w/o requiring
 * iOS4.
 */
+ (NSString*) localizedStringFromDate:(NSDate*)inputDate dateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle useRelative:(BOOL)relative
{
  NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
  [tmpFormatter setDateStyle:dateStyle];
  [tmpFormatter setTimeStyle:timeStyle];
  [tmpFormatter setDoesRelativeDateFormatting:relative];
  return [tmpFormatter stringFromDate:inputDate];
}

/**
 * This method exists in NSDateFormatter in iOS4 but not before that,
 * so this convenience method helps us cut down on extra code w/o requiring
 * iOS4.
 */
+ (NSString*) localizedStringFromDate:(NSDate*)inputDate dateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
  return [LWEDateUtils localizedStringFromDate:inputDate dateStyle:dateStyle timeStyle:timeStyle useRelative:NO];
}

@end
