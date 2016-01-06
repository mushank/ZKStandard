//
//  ZKNetworkManager.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class ZKResponseEntity;

typedef void (^ZKNetworkSuccessBlock) (ZKResponseEntity *responseEntity);
typedef void (^ZKNetworkFailureBlock) (ZKResponseEntity *responseEntity);

@interface ZKNetworkManager : AFHTTPSessionManager

/**
 *  @method             sharedInstance
 *  @abstract           get networkManager Singleton
 *  @discussion
 *  @param              NULL
 *  @param result       return networkManager Singleton
 */
+ (instancetype)sharedInstance;


- (void)getRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
                      succees:(ZKNetworkSuccessBlock)successBlock
                      failure:(ZKNetworkFailureBlock)failureBlock;


- (void)postRequestWithSubPath:(NSString *)subPath
                    parameters:(id)parameters
                       success:(ZKNetworkSuccessBlock)successBlock
                       failure:(ZKNetworkFailureBlock)failureBlock;



@end
