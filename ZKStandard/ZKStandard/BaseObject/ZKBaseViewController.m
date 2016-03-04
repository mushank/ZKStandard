//
//  ZKBaseViewController.m
//  ZKStandard
//
//  Created by Jack on 12/27/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKBaseViewController.h"

@interface ZKBaseViewController ()

@end

@implementation ZKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNetworkFailureNotificationObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Public Method
- (void)addBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 20.0, 44.0)];
    [button setImage:[UIImage imageNamed:@"BackButtonImage"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark - Target Method
- (void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:ZK_NOTI_NETWORK_REQUEST_FAILURE] ||
        [notification.name isEqualToString:ZK_NOTI_NETWORK_BUSINESS_FAILURE]) {
        [MBProgressHUD showErrorTips:notification.object];
    }
}

#pragma mark - ZKModelCallbackDelegate
- (void)callbackBizSuccessWithRequestName:(NSString *)name object:(id)object
{
    
}

- (void)callbackBizFailureWithRequestName:(NSString *)name object:(id)object
{
    
}

- (void)callbackReqFailureWithRequestName:(NSString *)name object:(id)object
{
    
}

#pragma mark - Private Method
- (void)addNetworkFailureNotificationObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveNotification:) name:ZK_NOTI_NETWORK_REQUEST_FAILURE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveNotification:) name:ZK_NOTI_NETWORK_BUSINESS_FAILURE object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
