//
//  MBProgressHUD+ZKExtension.m
//  ZKStandard
//
//  Created by Jack on 3/2/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "MBProgressHUD+ZKExtension.h"

#define MBHUD_IMAGEVIEW(bundleName, imageName) [[UIImageView alloc]initWithImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", (bundleName),(imageName)]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]]

static NSString *kBundleName        = @"MBProgressHUD+ZKExtension.bundle";
static NSString *kSuccessImageName  = @"Success";
static NSString *kErrorImageName    = @"Error";
static NSString *kWarningImageName  = @"Warning";

static float kOpacity = 0.5f;

@implementation MBProgressHUD (ZKExtension)

#pragma mark - Show Tips (ModeText)
+ (void)showTips:(NSString *)tips
{
    [self showTips:tips detail:nil customView:nil interval:ZK_TIPS_TIME_INTERVAL_SHORT];
}

+ (void)showTips:(NSString *)tips detail:(NSString *)detail
{
    [self showTips:tips detail:detail customView:nil interval:ZK_TIPS_TIME_INTERVAL_LONG];
}

#pragma mark - Show Tips (ModeCustomView)
// tips
+ (void)showSuccessTips:(NSString *)tips
{
    [self showTips:tips detail:nil customView:MBHUD_IMAGEVIEW(kBundleName, kSuccessImageName) interval:ZK_TIPS_TIME_INTERVAL_SHORT];
}

+ (void)showErrorTips:(NSString *)tips
{
    [self showTips:tips detail:nil customView:MBHUD_IMAGEVIEW(kBundleName, kErrorImageName) interval:ZK_TIPS_TIME_INTERVAL_LONG];
}

+ (void)showWarningTips:(NSString *)tips
{
    [self showTips:tips detail:nil customView:MBHUD_IMAGEVIEW(kBundleName, kWarningImageName) interval:ZK_TIPS_TIME_INTERVAL_LONG];
}

// tips & detail
+ (void)showSuccessTips:(NSString *)tips detail:(NSString *)detail
{
    [self showTips:tips detail:detail customView:MBHUD_IMAGEVIEW(kBundleName, kSuccessImageName) interval:ZK_TIPS_TIME_INTERVAL_SHORT];
}

+ (void)showErrorTips:(NSString *)tips detail:(NSString *)detail
{
    [self showTips:tips detail:detail customView:MBHUD_IMAGEVIEW(kBundleName, kErrorImageName) interval:ZK_TIPS_TIME_INTERVAL_LONG];
}

+ (void)showWarningTips:(NSString *)tips detail:(NSString *)detail
{
    [self showTips:tips detail:detail customView:MBHUD_IMAGEVIEW(kBundleName, kWarningImageName) interval:ZK_TIPS_TIME_INTERVAL_LONG];
}

+ (void)showTips:(NSString *)tips detail:(NSString *)detail customView:(UIView *)view interval:(NSTimeInterval)interval
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.opacity = kOpacity;
        hud.labelText = tips;
        hud.detailsLabelText = detail;
        hud.customView = view;
        [hud hide:YES afterDelay:interval];
    });
}

#pragma mark - Show HUD (ModeIndeterminate)
+ (void)showHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.opacity = kOpacity;
    });
}

+ (void)showHUDWithTitle:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.labelText = title;
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.opacity = kOpacity;
    });
}

+ (void)HideHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideHUDForView:[self sharedView] animated:YES];
    });
}

+ (void)showHUDDuring:(OperationBlock)operation
{
    [self showHUDWithTitle:nil during:operation];
}

+ (void)showHUDWithTitle:(NSString *)title during:(OperationBlock)operation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.opacity = kOpacity;
        hud.labelText = title;
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            operation();
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
            });
        });
    });
}

#pragma mark - Show Progress (ModeDeterminate)
+ (void)showProgress:(float)progress
{
    [self showProgress:progress title:nil];
}

+ (void)showProgress:(float)progress title:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:[self sharedView]];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        }
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = title;
        hud.progress = progress;
    });
}

+ (void)hideProgress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[self sharedView] animated:YES];
    });
}

#pragma mark - Private Method
+ (UIView *)sharedView
{
    static dispatch_once_t once;
    static UIView *sharedView;
    dispatch_once(&once, ^{
        sharedView = [UIApplication sharedApplication].keyWindow;
    });
    
    return sharedView;
}

@end
