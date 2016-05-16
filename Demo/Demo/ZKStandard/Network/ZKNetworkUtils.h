//
//  ZKNetworkUtils.h
//  ZKStandard
//
//  Created by Jack on 12/30/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, ZKServerAddressType)
{
    ZKServerAddressDev  = 0,    /* 开发环境 */
    ZKServerAddressDis,         /* 生产环境 */
};

@interface ZKNetworkUtils : NSObject

+ (NSString *)baseSchema;

+ (NSString *)baseAddress:(ZKServerAddressType)type;

+ (NSString *)basePath;

+ (NSString *)fullPath:(NSString *)subPath;

+ (NSTimeInterval)timeoutInterval;

@end
