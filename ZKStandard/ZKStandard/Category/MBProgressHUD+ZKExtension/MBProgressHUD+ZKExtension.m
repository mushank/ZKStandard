//
//  MBProgressHUD+ZKExtension.m
//  ZKStandard
//
//  Created by Jack on 3/2/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "MBProgressHUD+ZKExtension.h"

#define MBHUD_IMAGEVIEW(bundleName, imageName) [[UIImageView alloc]initWithImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", (bundleName),(imageName)]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]]

static NSString *kBundleName        = @"MBProgressHUD+ZKExtension.bundle";
static NSString *kSuccessImageName  = @"Success";
static NSString *kErrorImageName    = @"Error";
static NSString *kWarningImageName  = @"Warning";

static float          kOpacity                      = 0.5f;
static NSTimeInterval kTimeIntervalForTips          = 1.5f;
static NSTimeInterval kTimeIntervalForDetailTips    = 3.0f;

@implementation MBProgressHUD (ZKExtension)

#pragma mark - Show Tips (ModeText)
+ (void)showTips:(NSString *)tips
{
    [self showTips:tips detail:nil];
}

+ (void)showTips:(NSString *)tips detail:(NSString *)detail
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.opacity = kOpacity;
        hud.labelText = tips;
        hud.detailsLabelText = detail;
        [hud hide:YES afterDelay:kTimeIntervalForDetailTips];
    });
}

#pragma mark - Show Tips (ModeCustomView)
+ (void)showSuccessTips:(NSString *)tips
{
    [self showTips:tips customView:MBHUD_IMAGEVIEW(kBundleName, kSuccessImageName)];
}

+ (void)showErrorTips:(NSString *)tips
{
    [self showTips:tips customView:MBHUD_IMAGEVIEW(kBundleName, kErrorImageName)];
}

+ (void)showWarningTips:(NSString *)tips
{
    [self showTips:tips customView:MBHUD_IMAGEVIEW(kBundleName, kWarningImageName)];
}

+ (void)showTips:(NSString *)tips customView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.opacity = kOpacity;
        hud.square = YES;
        hud.labelText = tips;
        hud.customView = view;
        [hud hide:YES afterDelay:kTimeIntervalForTips];
    });
}

#pragma mark - Show HUD (ModeIndeterminate)
+ (void)showHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.opacity = kOpacity;
        hud.square = YES;
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
