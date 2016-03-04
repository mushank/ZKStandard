//
//  ZKNetworkManager.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class ZKResponseEntity;

typedef void (^ZKBusinessSuccessBlock) (ZKResponseEntity *bizSuccessEntity);   /* 业务成功 */
typedef void (^ZKBusinessFailureBlock) (ZKResponseEntity *bizFailureEntity);   /* 业务失败 */
typedef void (^ZKRequestFailureBlock) (ZKResponseEntity *reqFailureEntity);   /* 网络请求失败 */
typedef void (^ZKEternalExecuteBlock) ();   /* 无论业务成功与否，都会执行的Block */

@interface ZKNetworkManager : AFHTTPSessionManager

/**
 *  @method             sharedManager
 *  @abstract           get networkManager Singleton
 *  @discussion         Do not use shareInstance
 *  @param              NULL
 *  @param result       return networkManager Singleton
 */
+ (instancetype)sharedManager;

#pragma mark - Invisible Get & Invisible Post
- (void)getRequestInvisiblyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

- (void)postRequestInvisiblyWithSubPath:(NSString *)subPath
                             parameters:(id)parameters
                        businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

#pragma mark - Terse Get & Terse Post
- (void)getRequestTerselyWithSubPath:(NSString *)subPath
                          parameters:(id)parameters
                     businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

- (void)postRequestTerselyWithSubPath:(NSString *)subPath
                           parameters:(id)parameters
                      businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock;

#pragma mark - Normal Get & Normal Post
- (void)getRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
              businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
              businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
               requestFailure:(ZKRequestFailureBlock)reqFailureBlock
               eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;

- (void)postRequestWithSubPath:(NSString *)subPath
                    parameters:(id)parameters
               businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
               businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;



@end
