//
//  ZKMacros.h
//  ZKStandard
//
//  Created by Jack on 12/26/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#ifndef ZKMacros_h
#define ZKMacros_h


#endif /* ZKMacros_h */


// ==================== ZKLog ====================
#ifndef __OPTIMIZE__
#define ZKLog(fmt, ...) NSLog((@"%s [Line %d]" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZKLog(...) do{ }while(0)
#endif


// ==================== Common Define ====================
#define ZK_IS_NULL(string)          (!string || [string isEqual: @""])


// ==================== Device Info ====================
#define ZK_SCREEN_WIDTH             UIScreen.mainScreen.bounds.size.width
#define ZK_SCREEN_HEIGHT            UIScreen.mainScreen.bounds.size.height
#define ZK_VERSION                  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
#define ZK_IS_IPHONE                [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ZK_IOS7_OR_LATER            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define ZK_IOS8_OR_LATER            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define ZK_IOS9_OR_LATER            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)