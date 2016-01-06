//
//  ZKNetworkManager.m
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKNetworkManager.h"
#import "ZKNetworkUtils.h"
#import "ZKResponseEntity.h"

static ZKNetworkManager *networkManager = nil;

@implementation ZKNetworkManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseUrlString = [ZKNetworkUtils baseServerPath];
        NSURL *baseUrl = [NSURL URLWithString:baseUrlString];
        networkManager = [[ZKNetworkManager alloc]initWithBaseURL:baseUrl];
    });
    
    return networkManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer.timeoutInterval = [ZKNetworkUtils timeoutInterval];
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)getWithSubPath:(NSString *)subPath
            parameters:(id)parameters
               succees:(ZKNetworkSuccessBlock)successBlock
               failure:(ZKNetworkFailureBlock)failureBlock
{

    [self GET:subPath
   parameters:parameters
     progress:nil
      success:^(NSURLSessionDataTask *tast, id responseObject){
         ZKLog(@"Received:%@", [responseObject description]);
         ZKResponseEntity *response = [[ZKResponseEntity alloc]initWithResponseDictionary:responseObject];
         
     } failure:^(NSURLSessionDataTask *task, NSError *error){
         ZKLog(@"Error:%@", [error localizedDescription]);
         
     }];

}

- (void)postRequestWithSubPath:(NSString *)subPath
                    parameters:(id)parameters
                       success:(ZKNetworkSuccessBlock)successBlock
                       failure:(ZKNetworkFailureBlock)failureBlock
{
    [self POST:subPath
    parameters:parameters
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject){
          ZKLog(@"Received:%@", [responseObject description]);
           ZKResponseEntity *response = [[ZKResponseEntity alloc]initWithResponseDictionary:responseObject];
           
      } failure:^(NSURLSessionDataTask *task, NSError *error){
          ZKLog(@"Error:%@", [error localizedDescription]);

      }];
}

@end







