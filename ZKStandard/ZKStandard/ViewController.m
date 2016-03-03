//
//  ViewController.m
//  ZKStandard
//
//  Created by Jack on 12/26/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+ZKExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTapped
{
    [MBProgressHUD showWarningTips:@"Tips"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
