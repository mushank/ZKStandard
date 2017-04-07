//
//  ZKAppContext.m
//  ZKStandard
//
//  Created by Jack on 09/02/2017.
//  Copyright © 2017 mushank. All rights reserved.
//

#import "ZKAppContext.h"
#import <UIKit/UIKit.h>

NSString *const kAccessTokenKey   = @"ZKAppContext_AccessTokenKey";
NSString *const kRefreshTokenKey  = @"ZKAppContext_RefreshTokenKey";

NSString *const kUserInfoKey      = @"ZKAppContext_UserInfoKey";
NSString *const kUserIDKey        = @"ZKAppContext_UserIDKey";

@interface ZKAppContext ()

@property (nonatomic, copy, readwrite) NSString *accessToken;
@property (nonatomic, copy, readwrite) NSString *refreshToken;
@property (nonatomic, strong, readwrite) NSDate *tokenTimestamp;

@end

@implementation ZKAppContext

@synthesize userInfo = _userInfo;
@synthesize userID = _userID;

+ (instancetype)shareInstance
{
    static ZKAppContext *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ZKAppContext alloc] init];
    });
    return shareInstance;
}

#pragma mark - Device Info
- (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

- (NSString *)deviceModel
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)deviceID
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)systemName
{
    return [[UIDevice currentDevice] systemName];
}

- (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - App Info
- (NSString *)bundleID
{
   return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)devVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

#pragma mark - Token Info
- (NSString *)accessToken
{
    if (_accessToken == nil) {
        _accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:kAccessTokenKey];
    }
    return _accessToken;
}

- (NSString *)refreshToken
{
    if (_refreshToken == nil) {
        _refreshToken = [[NSUserDefaults standardUserDefaults] stringForKey:kRefreshTokenKey];
    }
    return _refreshToken;
}

- (void)updateAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken
{
    self.accessToken = accessToken;
    self.refreshToken = refreshToken;
    self.tokenTimestamp = [NSDate date];
    
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:kRefreshTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - User Info
- (NSDictionary *)userInfo
{
    if (_userInfo == nil) {
        _userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoKey];
    }
    return _userInfo;
}

- (void)setUserInfo:(NSDictionary *)userInfo
{
    _userInfo = [userInfo copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userInfo forKey:kUserInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userID
{
    if (_userID == nil) {
        _userID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserIDKey];
    }
    return _userID;
}

- (void)setUserID:(NSString *)userID
{
    _userID = [userID copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:kUserIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLoggedIn
{
    return (self.userID.length != 0);
}

- (void)clearUserInfo
{
    self.accessToken = nil;
    self.refreshToken = nil;
    self.tokenTimestamp = nil;
    
    self.userInfo = nil;
    self.userID = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kRefreshTokenKey];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfoKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
