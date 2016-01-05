//
//  ZKNetworkUtils.m
//  ZKStandard
//
//  Created by Jack on 12/30/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKNetworkUtils.h"
#import "ZKFileManager.h"

static NSString *const Config = @"ZKConfig";
static NSString *const Plist = @"plist";

@implementation ZKNetworkUtils

static NSString *const kBaseServerAddressDev    = @"Base Server Address Dev";   /* <ZKConfig.plish> 开发环境键值 */
static NSString *const kBaseServerAddressTest   = @"Base Server Address Test";  /* <ZKConfig.plish> 测试环境键值 */
static NSString *const kBaseServerAddressDis    = @"Base Server Address Dis";   /* <ZKConfig.plish> 生产环境键值 */

static NSString *const kBaseServerSchema        = @"Base Server Schema";    /* <ZKConfig.plish> 服务器Schema键值 */
static NSString *const kTimeOutInterval         = @"Time Out Interval";     /* <ZKConfig.plish> 网络访问时限键值 */


+ (NSString *)baseServerSchema
{
    NSMutableDictionary *dic = [[ZKFileManager sharedInstance]readFromBundleFile:Config withType:Plist];
    NSString *baseServierSchema = [dic objectForKey:kBaseServerSchema];
    return baseServierSchema;

}

+ (NSString *)baseServerAddressWithType:(ZKServerAddressType)type
{
    NSMutableDictionary *dic = [[ZKFileManager sharedInstance]readFromBundleFile:Config withType:Plist];
    NSString *baseServerAddress;

    switch (type) {
        case ZKServerAddressTypeDev:
            baseServerAddress = [dic objectForKey:kBaseServerAddressDev];
            break;
        case ZKServerAddressTypeTest:
            baseServerAddress = [dic objectForKey:kBaseServerAddressTest];
            break;
        case ZKServerAddressTypeDis:
            baseServerAddress = [dic objectForKey:kBaseServerAddressDis];
            break;
        default:
            break;
    }
    
    return baseServerAddress;
}

+ (NSString *)baseServerPath
{
#if DEBUG
    ZKServerAddressType type = ZKServerAddressTypeDev;
#else
    ZKServerAddressType type = ZKServerAddressTypeDis;
#endif
    
    NSString *baseServerSchema = [self baseServerSchema];
    NSString *baseServerAddress = [self baseServerAddressWithType:type];
    NSString *baseServerPath = [NSString stringWithFormat:@"%@%@",baseServerSchema,baseServerAddress];
    
    return baseServerPath;
}

+ (NSURL *)urlWithSubPath:(NSString *)subPath
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",self.baseServerPath, subPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return url;
}


+ (NSTimeInterval)timeOutInterval
{
    NSMutableDictionary *dic = [[ZKFileManager sharedInstance]readFromBundleFile:Config withType:Plist];
    NSTimeInterval timeOutInterval = [[dic objectForKey:kTimeOutInterval] doubleValue];
    
    return timeOutInterval;
}

@end
