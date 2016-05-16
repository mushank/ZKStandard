//
//  ZKNetworkUtils.m
//  ZKStandard
//
//  Created by Jack on 12/30/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKNetworkUtils.h"


@implementation ZKNetworkUtils

static NSString *const kConfig  = ZK_CONFIG_FILENAME;   /* 配置文件名 */
static NSString *const kPlist   = ZK_CONFIG_FILETYPE;   /* 配置文件类型 */

static NSString *const kBaseServerSchema        = @"Base Server Schema";        /* Schema */
static NSString *const kBaseServerAddressDev    = @"Base Server Address Dev";   /* 开发环境地址 */
static NSString *const kBaseServerAddressDis    = @"Base Server Address Dis";   /* 生产环境地址 */
static NSString *const kTimeoutInterval         = @"Timeout Interval";          /* 网络访问时限 */


+ (NSString *)baseSchema
{
    NSString *baseSchema = [self readConfigObjectForKey:kBaseServerSchema];
    
    return baseSchema;
}

+ (NSString *)baseAddress:(ZKServerAddressType)type
{
    NSString *baseAddress;
    switch (type) {
        case ZKServerAddressDev:
            baseAddress = [self readConfigObjectForKey:kBaseServerAddressDev];
            break;
        case ZKServerAddressDis:
            baseAddress = [self readConfigObjectForKey:kBaseServerAddressDis];
            break;
        default:
            break;
    }
    
    return baseAddress;
}

+ (NSString *)basePath
{
#if DEBUG
    ZKServerAddressType type = ZKServerAddressDev;
#else
    ZKServerAddressType type = ZKServerAddressDis;
#endif
    
    NSString *baseSchema = [self baseSchema];
    NSString *baseAddress = [self baseAddress:type];
    NSString *basePath = [NSString stringWithFormat:@"%@%@",baseSchema, baseAddress];
    
    return basePath;
}

+ (NSString *)fullPath:(NSString *)subPath
{
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",[self basePath], subPath];
    
    return fullPath;
}


+ (NSTimeInterval)timeoutInterval
{
    NSTimeInterval timeoutInterval = [[self readConfigObjectForKey:kTimeoutInterval] doubleValue];
    
    return timeoutInterval;
}

#pragma mark - Private Method
+ (id)readConfigObjectForKey:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle]pathForResource:kConfig ofType:kPlist];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    id value = [dic objectForKey:key];
    
    return value;
}


@end
