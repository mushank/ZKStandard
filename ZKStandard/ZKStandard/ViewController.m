//
//  ViewController.m
//  ZKStandard
//
//  Created by Jack on 12/26/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ViewController.h"
#import "ZKUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Code Test
    self.view.backgroundColor = ZK_COLOR_FROM_RGB(0x520000);
    
    NSLog(@"%@",[ZKUtils dateFromString:@"2016-03-07 18:23:22"]);
    NSLog(@"%@",[ZKUtils dateInGMTZoneFromString:@"2016-03-07 18:23:22"]);
    
    NSLog(@"%@",[ZKUtils stringFromDate:[NSDate date]]);
    NSLog(@"%@",[ZKUtils stringFromDateInGMTZone:[NSDate date]]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
