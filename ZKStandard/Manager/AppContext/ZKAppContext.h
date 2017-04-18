//
//  ZKAppContext.h
//  ZKStandard
//
//  Created by Jack on 09/02/2017.
//  Copyright © 2017 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKAppContext : NSObject

+ (instancetype)shareInstance;

/* 除去声明为readonly的Property，都需要外部进行赋值 */
#pragma mark - Device Info
@property (nonatomic, copy, readonly) NSString *deviceName;
@property (nonatomic, copy, readonly) NSString *deviceModel;
@property (nonatomic, copy, readonly) NSString *deviceID;
@property (nonatomic, copy, readonly) NSString *systemName;
@property (nonatomic, copy, readonly) NSString *systemVersion;

#pragma mark - App Info
@property (nonatomic, copy, readonly) NSString *bundleID;
@property (nonatomic, copy, readonly) NSString *appVersion;
@property (nonatomic, copy, readonly) NSString *devVersion;

#pragma mark - Token Info
@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *refreshToken;
@property (nonatomic, strong, readonly) NSDate *tokenTimestamp;

- (void)updateAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken;

#pragma mark - User Info
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, readonly) BOOL isLoggedIn;

- (void)clearUserInfo;

#pragma mark - APNs Info
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSData *deviceTokenData;

@end
