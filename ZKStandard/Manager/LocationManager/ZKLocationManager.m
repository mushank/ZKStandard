//
//  ZKLocationManager.m
//  ZKStandard
//
//  Created by Jack on 10/21/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "ZKLocationManager.h"
#import <CoreLocation/CoreLocation.h>

NSString *const kZKLocationUpdateTimeKey    = @"ZKLocationManager_TimestampKey";
NSString *const kZKLocationLatitudeKey      = @"ZKLocationManager_LatitudeKey";
NSString *const kZKLocationLongitudeKey     = @"ZKLocationManager_LongitudeKey";

@interface ZKLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) UpdateLocationCompletion completion;

@property (nonatomic, assign, readwrite) CGFloat longitude;
@property (nonatomic, assign, readwrite) CGFloat latitude;
@property (nonatomic, strong, readwrite) NSDate *timestamp;

@end

@implementation ZKLocationManager

+ (instancetype)shareInstance
{
    static ZKLocationManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ZKLocationManager alloc] init];
    });
    return shareInstance;
}


#pragma mark - Public
- (void)startUpdatingLocation
{
    [self stopUpdatingLocation];
    [self.locationManager startUpdatingLocation];
}

- (void)startUpdatingLocationWithCompletion:(UpdateLocationCompletion) completion
{
    [self startUpdatingLocation];
    self.completion = completion;
}

- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    _longitude = location.coordinate.longitude;
    _latitude = location.coordinate.latitude;
    _timestamp = location.timestamp;
    
    if (self.completion) {
        self.completion(_latitude, _longitude);
    }
    
    [self performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:60.0 * 60.0];
    [self stopUpdatingLocation];
    
    [[NSUserDefaults standardUserDefaults] setDouble:_longitude forKey:kZKLocationLongitudeKey];
    [[NSUserDefaults standardUserDefaults] setDouble:_latitude forKey:kZKLocationLatitudeKey];
    [[NSUserDefaults standardUserDefaults] setObject:_timestamp forKey:kZKLocationUpdateTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Properties
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

- (CGFloat)longitude
{
    if (!_longitude) {
        _longitude = [[NSUserDefaults standardUserDefaults] doubleForKey:kZKLocationLongitudeKey];
    }
    return _longitude;
}

- (CGFloat)latitude
{
    if (!_latitude) {
        _latitude = [[NSUserDefaults standardUserDefaults] doubleForKey:kZKLocationLatitudeKey];
    }
    return _latitude;
}

- (NSDate *)timestamp
{
    if (!_timestamp) {
        _timestamp = [[NSUserDefaults standardUserDefaults] objectForKey:kZKLocationUpdateTimeKey];
    }
    return _timestamp;
}

@end
