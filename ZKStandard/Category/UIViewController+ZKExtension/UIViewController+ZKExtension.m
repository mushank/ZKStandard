//
//  UIViewController+ZKExtension.m
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "UIViewController+ZKExtension.h"

@implementation UIViewController (ZKExtension)

- (void)ZKTapWhiteSpaceToDismissKeyboard
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whiteSpaceTapped:)];
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    __weak UIViewController *weakSelf = self;
    
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification *noti){
        [weakSelf.view addGestureRecognizer:tapGesture];
    }];
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQueue usingBlock:^(NSNotification *noti){
        [weakSelf.view removeGestureRecognizer:tapGesture];
    }];
}


#pragma mark - Private Methods
- (void)whiteSpaceTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
}

@end
