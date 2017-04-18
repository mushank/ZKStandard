//
//  ZKLocationManager.h
//  ZKStandard
//
//  Created by Jack on 10/21/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kZKLocationUpdateTimeKey;
extern NSString *const kZKLocationLatitudeKey;
extern NSString *const kZKLocationLongitudeKey;

typedef void(^UpdateLocationCompletion)(CGFloat latitude, CGFloat longitude);

@interface ZKLocationManager : NSObject

@property (nonatomic, assign, readonly) CGFloat longitude;
@property (nonatomic, assign, readonly) CGFloat latitude;
@property (nonatomic, strong, readonly) NSDate *timestamp;

+ (instancetype)shareInstance;

- (void)startUpdatingLocation;
- (void)startUpdatingLocationWithCompletion:(UpdateLocationCompletion)completion;

- (void)stopUpdatingLocation;

@end
