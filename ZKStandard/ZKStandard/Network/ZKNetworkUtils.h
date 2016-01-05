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
    ZKServerAddressTypeDev  = 0, /* 开发环境 */
    ZKServerAddressTypeTest = 1, /* 测试环境 */
    ZKServerAddressTypeDis  = 2, /* 生产环境 */
};

@interface ZKNetworkUtils : NSObject

/**
 *  @method             baseServerSchema
 *  @abstract           get baseServerSchema
 *  @discussion
 *  @param              NULL
 *  @param result       return baseServerSchema String
 */
+ (NSString *)baseServerSchema;

/**
 *  @method             baseServerAddressWithType
 *  @abstract           get baseServerAddress
 *  @discussion
 *  @param type         server address type
 *  @param result       return baseServerAddress String
 */
+ (NSString *)baseServerAddressWithType:(ZKServerAddressType)type;

/**
 *  @method             baseServerPath
 *  @abstract           get baseServerPath
 *  @discussion
 *  @param              NULL
 *  @param result       return baseServerPath String
 */
+ (NSString *)baseServerPath;

/**
 *  @method             urlWithSubPath
 *  @abstract           append baseServerPath with subPath
 *  @discussion
 *  @param              NULL
 *  @param result       return url
 */
+ (NSURL *)urlWithSubPath:(NSString *)subPath;

/**
 *  @method             timeOutInterval
 *  @abstract           get timeOutInterval
 *  @discussion
 *  @param              NULL
 *  @param result       return timeOutInterval doubleValue
 */
+ (NSTimeInterval)timeOutInterval;


@end
