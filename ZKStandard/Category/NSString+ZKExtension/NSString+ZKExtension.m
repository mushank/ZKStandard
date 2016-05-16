//
//  NSString+ZKExtension.m
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "NSString+ZKExtension.h"

@implementation NSString (ZKExtension)

#pragma mark - Cast to date
- (NSDate *)ZKDateFromFormatter:(ZKDateFormatterType)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[ZKUtils dateFormatterString:type]];
    
    return [dateFormatter dateFromString:self];
}

#pragma mark - Utils
- (NSString *)ZKRemoveWhiteSpaceCharacter
{
    NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return string;
}

@end
