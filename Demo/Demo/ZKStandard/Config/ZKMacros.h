//
//  ZKMacros.h
//  ZKStandard
//
//  Created by Jack on 12/26/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#ifndef ZKMacros_h
#define ZKMacros_h


// ==================== ZKLog ====================
#ifndef __OPTIMIZE__
#define ZKLog(fmt, ...) NSLog((@"%s [Line %d]" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZKLog(...) do{ }while(0)
#endif /* __OPTIMIZE__ */

// ==================== Device Info ====================
#define ZK_MODEL                    [[UIDevice currentDevice] model]
#define ZK_SYSTEM_VERSION           ([[UIDevice currentDevice] systemVersion])

#define ZK_IOS7_OR_LATER            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define ZK_IOS8_OR_LATER            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define ZK_IOS9_OR_LATER            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define ZK_SCREEN_WIDTH             UIScreen.mainScreen.bounds.size.width
#define ZK_SCREEN_HEIGHT            UIScreen.mainScreen.bounds.size.height
#define ZK_STATUS_BAR_HEIGHT        20.0
#define ZK_NAV_BAR_HEIGTH           44.0
#define ZK_TAB_BAR_HEIGHT           49.0
#define ZK_STATUS_NAV_BAR_HEIGHT    64.0

// ==================== App Info ====================
#define ZK_APP_BUNDLEID             [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"]
#define ZK_APP_VERSION              [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

// ==================== Network Define ====================
#define ZK_NOTI_NETWORK_REQUEST_FAILURE     @"ZK_NOTI_NETWORK_REQUEST_FAILURE"
#define ZK_NOTI_NETWORK_BUSINESS_FAILURE    @"ZK_NOTI_NETWORK_BUSINESS_FAILURE"
#define ZK_NOTI_NETWORK_TOKEN_EXPIRED       @"ZK_NOTI_NETWORK_TOKEN_EXPIRED"

#define ZK_TOKEN                [[NSUserDefaults standardUserDefaults] objectForKey:(ZK_TOKEN_IDENTIFIER)]
#define ZK_TOKEN_IDENTIFIER     @"ZK_TOKEN_IDENTIFIER"

// ==================== Function Define ====================
#define ZK_WEAKSELF(weakSelf)           __weak __typeof(&*self)(weakSelf) = self
#define ZK_STRING_IS_EMPTY(string)      (!(string) || [(string) isEqualToString: @""])
#define ZK_COLOR_FROM_RGB(RGBValue)     [UIColor colorWithRed:((float)(((RGBValue) & 0xFF0000) >> 16)) / 255.0 green:((float)(((RGBValue) & 0xFF00) >> 8)) / 255.0 blue:((float)((RGBValue) & 0xFF)) / 255.0 alpha:1.0]

// ==================== Config Define ====================
#define ZK_CONFIG_FILENAME  @"ZKConfig"
#define ZK_CONFIG_FILETYPE  @"plist"

// ==================== UI Define ====================
#define ZK_TIPS_TIME_INTERVAL_SHORT 0.5f
#define ZK_TIPS_TIME_INTERVAL_LONG  1.5f

#define ZK_TIPS_NETWORK_NO_CONNECTION   @"No Connection!"
#define ZK_TIPS_NETWORK_POOR_CONNECTION @"Poor Connection!"

#endif /* ZKMacros_h */
