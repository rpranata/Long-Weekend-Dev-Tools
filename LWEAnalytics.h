// LWEGoogleAnalyticsHelper.h
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


// Uncomment the following lines to enable various analytics trackers
#define LWE_USE_FLURRY 1
//#define LWE_USE_GAN 1

#import <Foundation/Foundation.h>

@interface LWEAnalytics : NSObject

//================= FLURRY METHODS =============

#if defined(LWE_USE_FLURRY)
/**
 * Logs a non-timed Flurry event with parameters
 */
+ (void) logEvent:(NSString*)eventName parameters:(NSDictionary*)userInfo;
#endif

//================= GOOGLE ANALYTICS METHODS =============

#if defined(LWE_USE_GAN)
/*
 start session, attempt to send saved sessions to server 
 */
+ (void)startSession:(NSString *)apiKey;

/*
 log events or errors after session has started
 */
+ (void)logEvent:(NSString *)eventName;
+ (void)logEvent:(NSString *)eventName withAction:(NSString*)actionString withLabel:(NSString*)label andValue:(NSInteger)intValue;
+ (void)setVariableAtIndex:(NSInteger)index withName:(NSString*)name andValue:(NSString*)valueString;

/* 
 wrapper for calling the stop tracker method
 */
+ (void) stopTracker;
#endif

@end