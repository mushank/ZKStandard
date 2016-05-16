//
//  ZKTableView.m
//  HTMF
//
//  Created by Jack on 4/7/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "ZKTableView.h"

@implementation ZKTableView

#pragma mark - Custom Method
- (void)setExtraCellSeparatorLineHidden:(BOOL)isHidden
{
    if (isHidden) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
    }else{
        [self setTableFooterView:nil];
    }
}

@end
