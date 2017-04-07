//
//  ZKAPIManager.m
//  ZKStandard
//
//  Created by Jack on 10/21/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "ZKAPIManager.h"
#import <AFNetworking/AFNetworking.h>

@interface ZKAPIManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, copy) NSString *baseURLString;

@end

@implementation ZKAPIManager

+ (ZKAPIManager *)shareInstance
{
    static ZKAPIManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ZKAPIManager alloc] initWithBaseURL:ZKAPIBaseURLString];
    });
    return shareInstance;
}

#pragma mark - Init
- (instancetype)initWithBaseURL:(NSString *)baseURLString
{
    self = [super init];
    if (self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = 15.f;
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", nil];
        self.baseURLString = baseURLString;
    }
    return self;
}

- (void)updateBaseURL:(NSString *)baseURLString
{
    if (![self.baseURLString isEqualToString:baseURLString]) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = 15.f;
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", nil];
        self.baseURLString = baseURLString;
    }
}

#pragma mark - Network Monitor
- (void)startNetworkMonitoring {
    ZK_WEAKSELF(weakSelf);
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        weakSelf.reachabilityStatus = (ZKAPIManagerReachabilityStatus)status;
    }];
}

- (void)checkNetworkStatus:(NetworkStatusBlock)block {
    ZK_WEAKSELF(weakSelf);
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        weakSelf.reachabilityStatus = (ZKAPIManagerReachabilityStatus)status;
        block((ZKAPIManagerReachabilityStatus)status);
    }];
}

- (BOOL)isReachableNetwork {
    return ([AFNetworkReachabilityManager sharedManager].isReachable) || ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown ? YES : NO);
}

- (BOOL)isReachableViaWiFi {
    return self.reachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

#pragma mark - Request Methods
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure
                       notice:(NoticeBlock)notice
{
    return [self.sessionManager GET:URLString
                         parameters:parameters
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                [self handleSuccessWithTask:task responseObject:responseObject success:success];
                            }
                            failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                [self handleFailureWithTask:task error:error failure:failure notice:notice];
                            }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(SuccessBlock)success
                       failure:(FailureBlock)failure
                        notice:(NoticeBlock)notice
{
    return [self.sessionManager POST:URLString
                          parameters:parameters
                            progress:nil
                             success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                 [self handleSuccessWithTask:task responseObject:responseObject success:success];
                             }
                             failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                 [self handleFailureWithTask:task error:error failure:failure notice:notice];
                             }];
}

- (NSURLSessionDataTask *)upload:(NSString *)URLString
                      parameters:(id)parameters
                         fileDic:(NSDictionary *)fileDic
                        progress:(UploadProgressBlock)progress
                         success:(SuccessBlock)success
                         failure:(FailureBlock)failure
                          notice:(NoticeBlock)notice
{
    return [self.sessionManager POST:URLString
                          parameters:parameters
           constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
               [formData appendPartWithFileData:fileDic[@"data"]
                                           name:fileDic[@"name"]
                                       fileName:fileDic[@"fileName"]
                                       mimeType:fileDic[@"mimeType"]];
           }
                            progress:^(NSProgress * _Nonnull uploadProgress) {
                                progress(uploadProgress);
                            }
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 [self handleSuccessWithTask:task responseObject:responseObject success:success];
                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 [self handleFailureWithTask:task error:error failure:failure notice:notice];
                             }];
}

- (NSURLSessionDataTask *)download:(NSString *)URLString
                        parameters:(id)parameters
                          progress:(DownloadProgressBlock)progress
                           success:(SuccessBlock)success
                           failure:(FailureBlock)failure
                            notice:(NoticeBlock)notice
{
    return [self.sessionManager GET:URLString
                         parameters:parameters
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               progress(downloadProgress);
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                [self handleSuccessWithTask:task responseObject:responseObject success:success];
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [self handleFailureWithTask:task error:error failure:failure notice:notice];
                            }];
}

#pragma mark - Private
- (void)handleSuccessWithTask:(NSURLSessionDataTask *)task
               responseObject:(id)responseObject
                      success:(SuccessBlock)success
{
    success(task, responseObject);
}

- (void)handleFailureWithTask:(NSURLSessionDataTask *)task
                        error:(NSError *)error
                      failure:(FailureBlock)failure
                       notice:(NoticeBlock)notice
{
    id responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (responseData && [responseData isKindOfClass:[NSData class]]) {
        id response = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        if (response && [response isKindOfClass:[NSDictionary class]]) {
            if (notice) {
                notice(task, response);
                id errCode = response[@"err_code"];
                if (errCode && [errCode isKindOfClass:[NSNumber class]]) {
                    if ([errCode integerValue] == 403) {
                        // TODO user auth
                    }
                }
            }
            return;
        }
    }
    if (failure) {
        failure(task, error);
    }
}

@end
