//
//  ZKFileManager.h
//  ZKStandard
//
//  Created by Jack on 12/31/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKFileManager : NSObject

+ (ZKFileManager *)sharedInstance;

- (id)readObjectForKey:(NSString *)key fromBundleFile:(NSString *)fileName fileType:(NSString *)fileType;

- (NSMutableDictionary *)readDataFromBundleFile:(NSString *)fileName fileType:(NSString *)fileType;

- (void)writeData:(NSMutableDictionary *)writtenData toBundleFile:(NSString *)fileName fileType:(NSString *)fileType;


@end
