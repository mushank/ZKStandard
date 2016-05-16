//
//  ZKRequestManager.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 Insigma HengTian Software Ltd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "ZKResponseEntity.h"
#import "ZKNetworkUtils.h"

typedef NS_ENUM(NSInteger , ZKRequestMethodType) {
    ZKRequestMethodGet = 0, /* Get */
    ZKRequestMethodPost,    /* Post */
    ZKRequestMethodPut,     /* Put */
    ZKRequestMethodDelete,  /* Delete */
};

typedef void (^ZKBusinessSuccessBlock) (ZKResponseEntity *bizSuccessEntity);    /* 业务成功 */
typedef void (^ZKBusinessFailureBlock) (ZKResponseEntity *bizFailureEntity);    /* 业务失败 */
typedef void (^ZKRequestFailureBlock) (ZKResponseEntity *reqFailureEntity);     /* 请求失败 */
typedef void (^ZKEternalExecuteBlock) (id object);  /* 无论结果，必定执行的Block */

@interface ZKRequestManager : AFHTTPSessionManager

+ (instancetype)sharedInstance;

#pragma mark - Invisible Request
- (void)requestInvisiblyWithType:(ZKRequestMethodType)methodType
                         SubPath:(NSString *)subPath
                      parameters:(id)parameters
                 businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

#pragma mark - Normal Reqeust
- (void)requestWithType:(ZKRequestMethodType)methodType
                SubPath:(NSString *)subPath
             parameters:(id)parameters
        businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
        businessFailure:(ZKBusinessFailureBlock)bizFailureBlock;

#pragma mark - Entire Reqeust
- (void)requestEntirelyWithType:(ZKRequestMethodType)methodType
                        SubPath:(NSString *)subPath
                     parameters:(id)parameters
                businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                 requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                 eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;

@end
