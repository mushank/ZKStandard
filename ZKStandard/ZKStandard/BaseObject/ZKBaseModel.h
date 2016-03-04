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

typedef NS_ENUM(NSInteger, CallBackStatus){
    CallbackBizSuccessStatus = 0,
    CallbackBizFailureStatus = 1,
    CallbackreqFailureStatus = 2,
};

@protocol ZKModelCallbackDelegate <NSObject>

@optional
- (void)callbackBizSuccessWithRequestName:(NSString *)name object:(id)object;

- (void)callbackBizFailureWithRequestName:(NSString *)name object:(id)object;

- (void)callbackReqFailureWithRequestName:(NSString *)name object:(id)object;

@end

@interface ZKBaseModel : NSObject<ZKModelCallbackDelegate>

@property (strong, nonatomic) ZKNetworkManager *networkManager;

@end
