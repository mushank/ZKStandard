//
//  ZKAPIConstants.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#ifndef ZKAPIConstants_h
#define ZKAPIConstants_h


static NSString *const ZKNETWORK_CODE = @"code";    /* return code string */
static NSString *const ZKNETWORK_DATA = @"data";    /* return data string*/
static NSString *const ZKNETWORK_MSG  = @"message"; /* return message string*/

typedef NS_ENUM (NSInteger, ZKResponseStatus)
{
    ZKResponseStatusSuccess          = 0, /* 业务成功 */
    ZKResponseStatusFailure          = 1, /* 业务失败 */
    ZKResponseStatusSessionExpired   = 2, /* Session过期 */
};

/**
 * 说明：APP中所有API地址请于下方定义
 * 注意：所有API请打上备注
 */
static NSString *const GET_LOGIN = @"api/ChatWeb/Login"; /* 登录 */



#endif /* ZKAPIConstants_h */
