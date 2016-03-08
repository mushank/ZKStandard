//
//  ZKUtils.m
//  ZKStandard
//
//  Created by Jack on 3/1/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "ZKUtils.h"

static NSString *kGMTTimeZoneString = @"GMT";
static NSString *kDefaultDateFormatString = @"yyyy-MM-dd HH:mm:ss";

@implementation ZKUtils

#pragma mark - Cast string to date
+ (NSDate *)dateFromString:(NSString *)string
{
    return [self dateFromString:string format:nil timeZone:nil];
}


+ (NSDate *)dateInGMTZoneFromString:(NSString *)string
{
    return [self dateFromString:string format:nil timeZone:kGMTTimeZoneString];
}

+ (NSDate *)dateInGMTZoneFromString:(NSString *)string format:(NSString *)format
{
    return [self dateFromString:string format:format timeZone:kGMTTimeZoneString];
}

+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format timeZone:(NSString *)timeZone
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:(format ? format : kDefaultDateFormatString)];
    if (timeZone) {
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:timeZone];
    }
    
    return [dateFormatter dateFromString:string];
}

#pragma mark - Cast date to string
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:kDefaultDateFormatString];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringFromDateInGMTZone:(NSDate *)date
{
    return [self stringFromDate:date format:nil timeZone:nil];
}

+ (NSString *)stringFromDateInGMTZone:(NSDate *)date format:(NSString *)format
{
    return  [self stringFromDate:date format:format timeZone:nil];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format timeZone:(NSString *)timeZone
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:(format ? format : kDefaultDateFormatString)];
    if (timeZone) {
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:timeZone];
    }
    
    return [dateFormatter stringFromDate:date];
}

@end
