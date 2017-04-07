//
//  ZKAPIManager.h
//  ZKStandard
//
//  Created by Jack on 10/21/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZKAPIManagerReachabilityStatus) {
    ZKAPIManagerReachabilityStatusUnknown           = -1,
    ZKAPIManagerReachabilityStatusNotReachable      = 0,
    ZKAPIManagerReachabilityStatusReachableViaWWAN  = 1,
    ZKAPIManagerReachabilityStatusReachableViaWiFi  = 2,
};

typedef void (^NetworkStatusBlock)(ZKAPIManagerReachabilityStatus status);

typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^NoticeBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^DownloadProgressBlock)(NSProgress *downloadProgress);
typedef void (^UploadProgressBlock)(NSProgress *uploadProgress);


@interface ZKAPIManager : NSObject

@property (nonatomic, assign) ZKAPIManagerReachabilityStatus reachabilityStatus;
@property (nonatomic, assign, readonly, getter = isReachableNetwork) BOOL reachableNetwork;
@property (nonatomic, assign, readonly, getter = isReachableViaWiFi) BOOL reachableViaWiFi;


+ (ZKAPIManager *)shareInstance;

#pragma mark - Network Monitor
- (void)startNetworkMonitoring;
- (void)checkNetworkStatus:(NetworkStatusBlock)block;

#pragma mark - Request Methods
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure
                       notice:(NoticeBlock)notice;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(SuccessBlock)success
                       failure:(FailureBlock)failure
                        notice:(NoticeBlock)notice;

- (NSURLSessionDataTask *)upload:(NSString *)URLString
                      parameters:(id)parameters
                         fileDic:(NSDictionary *)fileDic
                        progress:(UploadProgressBlock)progress
                         success:(SuccessBlock)success
                         failure:(FailureBlock)failure
                          notice:(NoticeBlock)notice;

- (NSURLSessionDataTask *)download:(NSString *)URLString
                        parameters:(id)parameters
                          progress:(DownloadProgressBlock)progress
                           success:(SuccessBlock)success
                           failure:(FailureBlock)failure
                            notice:(NoticeBlock)notice;


@end
