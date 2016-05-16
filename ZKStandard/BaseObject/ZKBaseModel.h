//
//  ZKBaseModel.h
//  ZKStandard
//
//  Created by Jack on 12/27/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKRequestManager.h"

typedef NS_ENUM(NSInteger, ZKCallBackStatusType){
    ZKCallbackStatusBizSuccess = 0,
    ZKCallbackStatusBizFailure = 1,
    ZKCallbackStatusreqFailure = 2,
};

@protocol ZKModelCallbackDelegate <NSObject>

@optional
- (void)callbackBizSuccessWithRequestName:(NSString *)name object:(id)object;

- (void)callbackBizFailureWithRequestName:(NSString *)name object:(id)object;

- (void)callbackReqFailureWithRequestName:(NSString *)name object:(id)object;

@end

@interface ZKBaseModel : NSObject<ZKModelCallbackDelegate>

@property (nonatomic, strong) ZKRequestManager *requestManager;

- (instancetype)initWithCallbackDelegate:(id<ZKModelCallbackDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (void)pushCallbackSuccessWithRequestName:(NSString *)name object:(id)object;

- (void)pushCallbackStatus:(ZKCallBackStatusType)status requestName:(NSString *)name object:(id)object;

@end
