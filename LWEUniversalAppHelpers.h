//
//  LWEUniversalAppHelpers.h
//  Rikai
//
//  Created by Ross on 10/11/10.
//  Copyright 2010 Long Weekend LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// There can only be X device types where X = (number of bits - 4) in an int on this platform.  Since that's
// usually 32-bits for compatibility, we have 28 device classes.
typedef enum
{
  kLWEDeviceClassUnknown,
  kLWEDeviceClassSimulator,
  kLWEDeviceClassIPhone,
  kLWEDeviceClassIPodTouch,
  kLWEDeviceClassIPad,
  kLWEDeviceClassCount
} kLWEDeviceClass;

typedef enum
{
  // Device class keys - least significant bits, use kLWEDeviceClass
  // Device "ranking" flags - more significant bits
  kLWEDeviceTypeUnknown    = (0 << kLWEDeviceClassCount) | kLWEDeviceClassUnknown,
  kLWEDeviceTypeIPhone     = (0 << kLWEDeviceClassCount) | kLWEDeviceClassIPhone,
  kLWEDeviceTypeIPodTouch1 = (0 << kLWEDeviceClassCount) | kLWEDeviceClassIPodTouch,
  kLWEDeviceTypeIPhone3G   = (1 << kLWEDeviceClassCount) | kLWEDeviceClassIPhone,
  kLWEDeviceTypeIPodTouch2 = (1 << kLWEDeviceClassCount) | kLWEDeviceClassIPodTouch,
  kLWEDeviceTypeIPhone3GS  = (2 << kLWEDeviceClassCount) | kLWEDeviceClassIPhone,
  kLWEDeviceTypeIPodTouch3 = (2 << kLWEDeviceClassCount) | kLWEDeviceClassIPodTouch,
  kLWEDeviceTypeIPhone4    = (3 << kLWEDeviceClassCount) | kLWEDeviceClassIPhone,
  kLWEDeviceTypeIPodTouch4 = (3 << kLWEDeviceClassCount) | kLWEDeviceClassIPodTouch,
  kLWEDeviceTypeIPad       = (4 << kLWEDeviceClassCount) | kLWEDeviceClassIPad,
  kLWEDeviceTypeIPhone5    = (5 << kLWEDeviceClassCount) | kLWEDeviceClassIPhone,
  kLWEDeviceTypeIPad2      = (5 << kLWEDeviceClassCount) | kLWEDeviceClassIPad,
  kLWEDeviceTypeSimulator  = (6 << kLWEDeviceClassCount) | kLWEDeviceClassSimulator,
} kLWEDeviceType;

/**
 * This class helps applications be universal: work on any iOS device (iPhone, iPod Touch, iPad)
 * This includes device identification helper methods, filename selector methods (e.g. using 
 * HD file extensions for iPad-specific resources).
 * 
 * Note that this class is RELATED to LWERetinaUtils, which is responsible for device resolution/display
 * universality issues, but the roles of each class are distinct.  An iPad could theoretically also be
 * Retina someday; this class should/would not care about that at that point.
 */
@interface LWEUniversalAppHelpers : NSObject
{
}
//! Determines if the device is an iPad or not. Works with pre 3.2 iOS versions as well
+(BOOL)isAnIPad;

//! Determines if the device is an iPhone or not. Works with pre 3.2 iOS versions as well
+(BOOL)isAnIPhone;

/**
 * \brief Returns the name of this device, e.g. "iPhone 2,1" for an iPhone 3GS.
 * This method returns the string by making a C system call asking the system to identify its
 * hardware.
 */
+ (NSString*)deviceModelString;

/**
 * Converts a device string (retrieved likely from the hardware via a call to -deviceModelString)
 * into a kLWEDeviceType enum value that identifies the device.
 * \param deviceString Should be a string from -deviceModelString -- something of the format "iPhone 2,1"
 * \return The device type, as a member of enum kLWEDeviceType
 */
+ (kLWEDeviceType)deviceTypeWithString:(NSString*)deviceString;

/**
 * Helper method that calls +deviceTypeWithString: with the return val of +deviceModelString as the param
 */
+ (kLWEDeviceType)deviceType;

/**
 * Returns the filename passed to it, UNLESS the device is an iPad AND the same filename + "@HD" exists.  (ala @2x)
 */
+ (NSString*) fileNamed:(NSString*)fileName;
+ (NSString*) fileNamed:(NSString *)fileName useRetinaIfMissing:(BOOL)useRetina;

/**
 * Returns an appropriate filename based on the filename given, making considerations for whether the device is an iPad or not, and whether the device is Retina or not.
 * \param fileName The name of the file to Retina-icize or iPadHD-icize
 * \param useRetina If the device is an iPad, and no iPad HD file is found for the given fileName, setting this param to YES will return the retina filename instead.
 * \return Returns a filename based on the input fileName -- e.g. foo.png => foo@HD.png or foo@2x.png ... or maybe just foo.png.
 */
+ (NSString*) fileNamed:(NSString *)fileName useRetinaIfMissing:(BOOL)useRetina;


@end
