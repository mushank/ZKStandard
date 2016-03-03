//
//  MBProgressHUD+ZKExtension.m
//  ZKStandard
//
//  Created by Jack on 3/2/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "MBProgressHUD+ZKExtension.h"

#define MBHUD_IMAGEVIEW(bundleName, imageName) [[UIImageView alloc]initWithImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", bundleName,imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]]

static NSString *kBundleName        = @"MBProgressHUD+ZKExtension.bundle";
static NSString *kSuccessImageName  = @"Success";
static NSString *kErrorImageName    = @"Error";
static NSString *kWarningImageName  = @"Error";

static NSTimeInterval kTimeIntervalForTips = 1.5f;

@implementation MBProgressHUD (ZKExtension)

#pragma mark - Show Tips
+ (void)showTips:(NSString *)tips
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = tips;
        [hud hide:YES afterDelay:kTimeIntervalForTips];
    });
}

+ (void)showSuccessTips:(NSString *)tips
{
    [self showTips:tips withCustomView:MBHUD_IMAGEVIEW(kBundleName, kSuccessImageName)];
}

+ (void)showErrorTips:(NSString *)tips
{
    [self showTips:tips withCustomView:MBHUD_IMAGEVIEW(kBundleName, kErrorImageName)];
}

+ (void)showWarningTips:(NSString *)tips
{
    [self showTips:tips withCustomView:MBHUD_IMAGEVIEW(kBundleName, kWarningImageName)];
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

+ (void)showTips:(NSString *)tips withCustomView:(UIView *)customView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self sharedView] animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = tips;
        hud.customView = customView;
        hud.square = YES;
        [hud hide:YES afterDelay:kTimeIntervalForTips];
    });
}



@end
