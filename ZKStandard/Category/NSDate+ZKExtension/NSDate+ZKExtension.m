//
//  NSDate+ZKExtension.m
//  HTMF
//
//  Created by Jack on 4/21/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "NSDate+ZKExtension.h"

#define ZK_DATE_COMPONENTS [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self]

@implementation NSDate (ZKExtension)

#pragma mark - Cast to String
- (NSString *)ZKStringInFormatter:(ZKDateFormatterType)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[ZKUtils dateFormatterString:type]];
    
    return [dateFormatter stringFromDate:self];
}

#pragma mark - Extension for Calender
- (NSDate *)ZKFirstDayInCurrentMonth
{
    NSDate *firstDay = nil;
    BOOL isOk = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:self];
    NSAssert(isOk, @"Failed to calculate the first day of current month based on %@", self);
    
    return firstDay;
}

- (NSDate *)ZKFirstDayInNextMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:self];
    dateComponents.day = 1;
    dateComponents.month++;
    NSDate *firstDay =[calendar dateFromComponents:dateComponents];
    
    return firstDay;
}

- (NSDate *)ZKFirstDayInPreviousMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:self];
    dateComponents.day = 1;
    dateComponents.month--;
    NSDate *firstDay =[calendar dateFromComponents:dateComponents];
    
    return firstDay;
}

- (NSUInteger)ZKNumberOfDaysInMonth
{
    NSUInteger number = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    
    return number;
}

-(NSUInteger)ZKWeekday
{
    NSUInteger weekday = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
    
    return weekday;
}

-(NSUInteger)ZKYear
{
    NSUInteger year = ZK_DATE_COMPONENTS.year;
    
    return year;
}

-(NSUInteger)ZKMonth
{
    NSUInteger month = ZK_DATE_COMPONENTS.month;
    
    return month;
}

-(NSUInteger)ZKDay
{    NSUInteger day = ZK_DATE_COMPONENTS.day;
    
    return day;
}

-(NSUInteger)ZKHour
{
    NSUInteger hour = ZK_DATE_COMPONENTS.hour;
    
    return hour;
}

-(NSUInteger)ZKMinute
{
    NSUInteger minute = ZK_DATE_COMPONENTS.minute;
    
    return minute;
}

-(NSUInteger)ZKSecond
{
    NSUInteger second = ZK_DATE_COMPONENTS.second;
    
    return second;
}

@end
