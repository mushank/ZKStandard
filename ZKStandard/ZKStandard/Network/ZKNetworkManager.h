//
//  ZKNetworkManager.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class ZKResponseEntity;

typedef void (^ZKBusinessSuccessBlock) (ZKResponseEntity *businessSuccessEntity);   /* 业务成功 */
typedef void (^ZKBusinessFailureBlock) (ZKResponseEntity *businessFailureEntity);   /* 业务失败 */
typedef void (^ZKRequestFailureBlock) (ZKResponseEntity *requestFailureEntity);   /* 网络请求失败 */
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
                       businessSuccess:(ZKBusinessSuccessBlock)businessSuccessBlock;

- (void)postRequestInvisiblyWithSubPath:(NSString *)subPath
                             parameters:(id)parameters
                        businessSuccess:(ZKBusinessSuccessBlock)businessSuccessBlock;

#pragma mark - Terse Get & Terse Post
- (void)getRequestTerselyWithSubPath:(NSString *)subPath
                          parameters:(id)parameters
                     businessSuccess:(ZKBusinessSuccessBlock)businessSuccessBlock;

- (void)postRequestTerselyWithSubPath:(NSString *)subPath
                           parameters:(id)parameters
                      businessSuccess:(ZKBusinessSuccessBlock)businessSuccessBlock;

#pragma mark - Normal Get & Normal Post
- (void)getRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
              businessSuccess:(ZKBusinessSuccessBlock)businessSuccessBlock
              businessFailure:(ZKBusinessFailureBlock)businessFailureBlock
               requestFailure:(ZKRequestFailureBlock)requestFailureBlock
               eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;

- (void)postRequestWithSubPath:(NSString *)subPath
                    parameters:(id)parameters
               businessSuccess:(ZKBusinessSuccessBlock)businessSuccessBlock
               businessFailure:(ZKBusinessFailureBlock)businessFailureBlock
                requestFailure:(ZKRequestFailureBlock)requestFailureBlock
                eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock;



@end
