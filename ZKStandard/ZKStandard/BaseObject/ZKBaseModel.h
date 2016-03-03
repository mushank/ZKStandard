//
//  ZKBaseModel.h
//  ZKStandard
//
//  Created by Jack on 12/27/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKAPIConstants.h"
#import "ZKNetworkManager.h"

@interface ZKBaseModel : NSObject

@property (strong, nonatomic) ZKNetworkManager *networkManager;

@end
