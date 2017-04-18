//
//  ZKMacros.h
//  ZKStandard
//
//  Created by Jack on 10/21/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#ifndef ZKMacros_h
#define ZKMacros_h

// ==================== NSLog ====================
#ifndef __OPTIMIZE__
#define NSLog(fmt, ...) NSLog((@"%s [Line %d]" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...) do{ }while(0)
#endif /* __OPTIMIZE__ */

// ==================== Function Define ====================
#define ZK_WEAKSELF(weakSelf)   __weak __typeof(&*self)(weakSelf) = self
#define ZK_RGB(RGB)             [UIColor colorWithRed:((float)(((RGB) & 0xFF0000) >> 16)) / 255.0 green:((float)(((RGB) & 0xFF00) >> 8)) / 255.0 blue:((float)((RGB) & 0xFF)) / 255.0 alpha:1.0]
#define ZK_RGBA(RGB, A)         [UIColor colorWithRed:((float)(((RGB) & 0xFF0000) >> 16)) / 255.0 green:((float)(((RGB) & 0xFF00) >> 8)) / 255.0 blue:((float)((RGB) & 0xFF)) / 255.0 alpha:A]

// ==================== Device Info ====================
#define ZK_SCREEN_WIDTH     UIScreen.mainScreen.bounds.size.width
#define ZK_SCREEN_HEIGHT    UIScreen.mainScreen.bounds.size.height

#endif /* ZKMacros_h */
