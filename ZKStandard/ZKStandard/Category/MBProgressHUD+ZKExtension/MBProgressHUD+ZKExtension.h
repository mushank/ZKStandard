//
//  MBProgressHUD+ZKExtension.h
//  ZKStandard
//
//  Created by Jack on 3/2/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ZKExtension)

#pragma mark - Show Tips
+ (void)showTips:(NSString *)tips;

+ (void)showSuccessTips:(NSString *)tips;

+ (void)showErrorTips:(NSString *)tips;

+ (void)showWarningTips:(NSString *)tips;

//#pragma mark - Show HUD
//+ (void)showHUDWithTitle:(NSString *)title;
//
//+ (void)showHUDAndDisableUserInteractionWithTitle:(NSString *)title;
//
//+ (void)hideHUD;


@end
