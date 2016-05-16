//
//  MBProgressHUD+ZKExtension.h
//  ZKStandard
//
//  Created by Jack on 3/2/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

#define ZK_TIPS_TIME_INTERVAL_SHORT 0.5f
#define ZK_TIPS_TIME_INTERVAL_LONG  1.5f

typedef void (^OperationBlock)();

@interface MBProgressHUD (ZKExtension)

#pragma mark - Show Tips (ModeText)
+ (void)showTips:(NSString *)tips;

+ (void)showTips:(NSString *)tips detail:(NSString *)detail;

#pragma mark - Show Tips (ModeCustomView)
+ (void)showSuccessTips:(NSString *)tips;
+ (void)showErrorTips:(NSString *)tips;
+ (void)showWarningTips:(NSString *)tips;

+ (void)showSuccessTips:(NSString *)tips detail:(NSString *)detail;
+ (void)showErrorTips:(NSString *)tips detail:(NSString *)detail;
+ (void)showWarningTips:(NSString *)tips detail:(NSString *)detail;

+ (void)showTips:(NSString *)tips detail:(NSString *)detail customView:(UIView *)view interval:(NSTimeInterval)interval;

#pragma mark - Show HUD (ModeIndeterminate)
+ (void)showHUD;

+ (void)showHUDWithTitle:(NSString *)title;

+ (void)HideHUD;

+ (void)showHUDDuring:(OperationBlock)operation;

+ (void)showHUDWithTitle:(NSString *)title during:(OperationBlock)operation;

#pragma mark - Show Progress (ModeDeterminate)
+ (void)showProgress:(float)progress;

+ (void)showProgress:(float)progress title:(NSString *)title;

+ (void)hideProgress;

@end
