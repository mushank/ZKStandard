//
//  UIViewController+DismissKeyboard.m
//  ZKStandard
//
//  Created by Jack on 3/7/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "UIViewController+DismissKeyboard.h"

@implementation UIViewController (DismissKeyboard)

- (void)setTapGestureForDismissKeyboard
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToDismissKeyboard:)];
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    __weak UIViewController *weakSelf = self;
    
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification *noti){
        [weakSelf.view addGestureRecognizer:tapGesture];
    }];
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQueue usingBlock:^(NSNotification *noti){
        [weakSelf.view removeGestureRecognizer:tapGesture];
    }];
}

- (void)tapToDismissKeyboard:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
}

@end
