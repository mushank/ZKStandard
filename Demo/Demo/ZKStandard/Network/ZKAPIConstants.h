//
//  ZKAPIConstants.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#ifndef ZKAPIConstants_h
#define ZKAPIConstants_h


static NSString *const ZKResponseStatusKey  = @"status";    /* response status key */
static NSString *const ZKResponseMessageKey = @"message";   /* response message key */
static NSString *const ZKResponseDataKey    = @"data";      /* response data key */

typedef NS_ENUM (NSInteger, ZKResponseStatus)
{
    ZKResponseStatusSuccess = 0,    /* 业务成功 */
    ZKResponseStatusFailure,        /* 业务失败 */
    ZKResponseStatusTokenExpired,   /* 授权失效 */
};

/**
 * 注意：工程中所有API地址请于下方声明，所有API请打上备注
 */
#pragma mark - API For HTMF, begin with "ZK"
// HTMF设备验证，获取Token接口，POST
static NSString *const ZK_AUTH = @"/services/auth/device/getToken";

#pragma mark - API For MIS, begin with "MIS"
// MIS用户验证，获取Token接口，POST
static NSString *const MIS_AUTH = @"/services/mis/api/v1/auth";

#pragma mark - API For TastTracking, begin with "TT"
// TT首页数据接口，GET
static NSString *const TT_PAGE_INFO = @"/services/mis/api/v1/pageinfo";


#endif /* ZKAPIConstants_h */
