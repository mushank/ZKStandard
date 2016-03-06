//
//  MBProgressHUD+ZKExtension.h
//  ZKStandard
//
//  Created by Jack on 3/2/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef void (^OperationBlock)();

@interface MBProgressHUD (ZKExtension)

#pragma mark - Show Tips (ModeText)
+ (void)showTips:(NSString *)tips;

+ (void)showTips:(NSString *)tips detail:(NSString *)detail;

#pragma mark - Show Tips (ModeCustomView)
+ (void)showSuccessTips:(NSString *)tips;

+ (void)showErrorTips:(NSString *)tips;

+ (void)showWarningTips:(NSString *)tips;

+ (void)showTips:(NSString *)tips customView:(UIView *)view;

#pragma mark - Show HUD (ModeIndeterminate)
+ (void)showHUD;

+ (void)HideHUD;

+ (void)showHUDDuring:(OperationBlock)operation;

+ (void)showHUDWithTitle:(NSString *)title during:(OperationBlock)operation;

#pragma mark - Show Progress (ModeDeterminate)
+ (void)showProgress:(float)progress;

+ (void)showProgress:(float)progress title:(NSString *)title;

+ (void)hideProgress;

@end
