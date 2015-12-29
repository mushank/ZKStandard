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
    ZKServerAddressTypeDevelopment  = 0, /* 开发环境服务器地址 */
    ZKServerAddressTypeTest         = 1, /* 测试环境服务器地址 */
    ZKServerAddressTypeDistribution = 2, /* 生产环境服务器地址 */
};

@interface ZKNetworkUtils : NSObject

@end
