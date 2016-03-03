//
//  ZKAPIConstants.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#ifndef ZKAPIConstants_h
#define ZKAPIConstants_h


static NSString *const ZKNETWORK_CODE = @"code";    /* return code key */
static NSString *const ZKNETWORK_DATA = @"data";    /* return data key */
static NSString *const ZKNETWORK_MSG  = @"message"; /* return message key */

typedef NS_ENUM (NSInteger, ZKResponseStatus)
{
    ZKResponseStatusSuccess          = 0, /* 业务成功 */
    ZKResponseStatusFailure          = 1, /* 业务失败 */
    ZKResponseStatusSessionExpired   = 2, /* Session过期 */
    ZKResponseStatusTokenExpired     = 3, /* Token过期 */
};

/**
 * 说明：工程中所有API地址请于下方声明
 * 注意：所有API请打上备注
 */
static NSString *const GET_LOGIN = @"api/WeChat/Login";     /* 登录 */
static NSString *const GET_TOKEN = @"api/WeChat/GetToken";  /* 获取Token值 */



#endif /* ZKAPIConstants_h */
