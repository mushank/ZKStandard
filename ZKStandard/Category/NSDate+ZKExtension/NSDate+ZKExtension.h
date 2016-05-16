//
//  NSDate+ZKExtension.h
//  HTMF
//
//  Created by Jack on 4/21/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKUtils.h"

@interface NSDate (ZKExtension)

#pragma mark - Cast to String
- (NSString *)ZKStringInFormatter:(ZKDateFormatterType)type;


#pragma mark - Extension for Calender
- (NSDate *)ZKFirstDayInCurrentMonth;
- (NSDate *)ZKFirstDayInNextMonth;
- (NSDate *)ZKFirstDayInPreviousMonth;

- (NSUInteger)ZKNumberOfDaysInMonth;

/**
 *  @return Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Thursday:5, Friday:6, Saturday:7
 */
-(NSUInteger)ZKWeekday;
-(NSUInteger)ZKYear;
-(NSUInteger)ZKMonth;
-(NSUInteger)ZKDay;
-(NSUInteger)ZKHour;
-(NSUInteger)ZKMinute;
-(NSUInteger)ZKSecond;

@end
