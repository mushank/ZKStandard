//
//  ZKUtils.m
//  ZKStandard
//
//  Created by Jack on 3/1/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "ZKUtils.h"
#import "CommonCrypto/CommonDigest.h"   // For MD5

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

/**
 * Temp

#pragma mark - String
+ (NSString *)CHNStringFromUnicodeString:(NSString *)unicodeString {
    
    if (!ZK_IS_NULL(unicodeString)){
        return nil;
    }else{
        NSString *tempStr1 = [unicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
        NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
        NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
        NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
        return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    }
}

+ (NSString *)md5:(NSString *)string
{
    const char *cString = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cString, (CC_LONG)strlen(cString), digest );
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    
    return resultString;
}

+ (NSString *)stringWithoutLastChar:(NSString *)string;
{
    if (ZK_IS_NULL(string))
    {
        return nil;
    }
    NSString *resultString = [string substringWithRange:NSMakeRange(0, [string length] - 1)];
    
    return resultString;
}


+ (NSString *)stringWithDistance:(double)distance
{
    NSString *disString = (distance  > 1000)
    ? ([NSString stringWithFormat:@"距离 %.1lfkm",distance / 1000])
    : ([NSString stringWithFormat:@"距离 %dm",(int)distance]);
    return disString;
}

+ (NSString *)displayIntervalStringWithDate:(NSDate *)date;
{
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟前";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f 分钟前", timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f 小时前", timeInterval / 3600];
    } else if (timeInterval < 604800) { // 7天内
        return [NSString stringWithFormat:@"%.f 天前", timeInterval / 86400];
    } else if (timeInterval < 31536000) {   // 1年内
        return [self stringFromDate:date format:@"MM-dd" timeZone:nil];
    } else {
        return [NSString stringWithFormat:@"%.f 年前", timeInterval / 31536000];
    }
}

+ (NSAttributedString *)deleteLineStyleString:(NSString *)string
{
    NSUInteger length = [string length];
    NSRange allRange = NSMakeRange(0, length);
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:allRange];
    [attri addAttribute:NSStrikethroughColorAttributeName value:ZK_COLOR_FROM_RGB(0x999999) range:allRange];
    [attri addAttribute:NSForegroundColorAttributeName value:ZK_COLOR_FROM_RGB(0x999999) range:allRange];
    
    return attri;
}

#pragma mark - Others
+ (void)callPhoneNumber:(NSString *)phoneNumber
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
}

+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber
{
    NSString *regex = @"^1([38]\\d{2}|4[57]\\d{1}|5[0-35-9]\\d{1}|70[059])\\d{7}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [pred evaluateWithObject:phoneNumber];
    return isValid;
}

 */
@end
