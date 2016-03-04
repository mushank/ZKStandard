//
//  ZKBaseViewController.h
//  ZKStandard
//
//  Created by Jack on 12/27/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKBaseModel.h"

@interface ZKBaseViewController : UIViewController<ZKModelCallbackDelegate>

/**
 *  Add back button on the left side of navgation bar
 */
- (void)addBackButton;

@end
