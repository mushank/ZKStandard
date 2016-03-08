//
//  ZKUtils.h
//  ZKStandard
//
//  Created by Jack on 3/1/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKUtils : NSObject

#pragma mark - Cast string to date
// Cast string to date in default formatter @"yyyy-MM-dd HH:mm:ss" at local timezone
+ (NSDate *)dateFromString:(NSString *)string;

// Cast string to date in default formatter @"yyyy-MM-dd HH:mm:ss", TimeZone is @"GMT"
+ (NSDate *)dateInGMTZoneFromString:(NSString *)string;

// Cast string to date in specified formatter,  TimeZone is @"GMT"
+ (NSDate *)dateInGMTZoneFromString:(NSString *)string format:(NSString *)format;

// Cast string to date in specified formatter, specified timezone
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format timeZone:(NSString *)timeZone;

#pragma mark - Cast date to string
// Cast date to string in default formatter @"yyyy-MM-dd HH:mm:ss" at local timezone
+ (NSString *)stringFromDate:(NSDate *)date;

// Cast date to string in default formatter @"yyyy-MM-dd HH:mm:ss", TimeZone is @"GMT"
+ (NSString *)stringFromDateInGMTZone:(NSDate *)date;

// Cast date to string in specified formatter,  TimeZone is @"GMT"
+ (NSString *)stringFromDateInGMTZone:(NSDate *)date format:(NSString *)format;

// Cast date to string in specified formatter, specified timezone
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format timeZone:(NSString *)timeZone;

@end
