//
//  ZKNetworkManager.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 Insigma HengTian Software Ltd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define NETWORK_NOTREACHABLE_MSG @"无网络连接"
#define NETWORK_REQUESTFAILURE_MSG @"网络不给力"

@class ZKResponseEntity;

typedef void (^ZKBusinessSuccessBlock) (ZKResponseEntity *bizSuccessEntity);   /* 业务成功 */
typedef void (^ZKBusinessFailureBlock) (ZKResponseEntity *bizFailureEntity);   /* 业务失败 */
typedef void (^ZKRequestFailureBlock) (ZKResponseEntity *reqFailureEntity);   /* 网络请求失败 */
typedef void (^ZKEternalExecuteBlock) (id object);   /* 无论业务成功与否，都会执行的Block */

@interface ZKNetworkManager : AFHTTPSessionManager

/**
 *  @method             sharedManager
 *  @abstract           get networkManager Singleton
 *  @discussion         Do not use shareInstance
 *  @param              NULL
 *  @param result       return networkManager Singleton
 */
+ (instancetype)sharedManager;

#pragma mark - Invisible Get / Post / Put
- (void)getRequestInvisiblyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

- (void)postRequestInvisiblyWithSubPath:(NSString *)subPath
                             parameters:(id)parameters
                        businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

- (void)putRequestInvisiblyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

- (void)deleteRequestInvisiblyWithSubPath:(NSString *)subPath
                               parameters:(id)parameters
                          businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

#pragma mark - Normal Get / Post / Put
- (void)getRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
              businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
              businessFailure:(ZKBusinessFailureBlock)bizFailureBlock;

- (void)postRequestWithSubPath:(NSString *)subPath
                    parameters:(id)parameters
               businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
               businessFailure:(ZKBusinessFailureBlock)bizFailureBlock;

- (void)putRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
              businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
              businessFailure:(ZKBusinessFailureBlock)bizFailureBlock;

- (void)deleteRequestWithSubPath:(NSString *)subPath
                      parameters:(id)parameters
                 businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                 businessFailure:(ZKBusinessFailureBlock)bizFailureBlock;

#pragma mark - Entire Get / Post / Put
- (void)getRequestEntirelyWithSubPath:(NSString *)subPath
                           parameters:(id)parameters
                      businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                      businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                       requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                       eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;

- (void)postRequestEntirelyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                       businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                        requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                        eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;

- (void)putRequestEntirelyWithSubPath:(NSString *)subPath
                           parameters:(id)parameters
                      businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                      businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                       requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                       eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;

- (void)deleteRequestEntirelyWithSubPath:(NSString *)subPath
                              parameters:(id)parameters
                         businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                         businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                          requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                          eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;

#pragma mark - isReachable
- (BOOL)isReachable;

@end
