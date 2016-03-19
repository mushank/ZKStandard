//
//  ZKFileManager.h
//  ZKStandard
//
//  Created by Jack on 12/31/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKFileManager : NSObject

/**
 *  Shared fileManager
 *
 *  @return ZKFileManager Singleton
 */
+ (ZKFileManager *)sharedManager;

/**
 *  Read specified value from bundle file
 *
 *  @param key      key
 *  @param fileName file name
 *  @param fileType file type
 *
 *  @return id
 */
- (id)readValueForKey:(NSString *)key fromBundleFile:(NSString *)fileName withType:(NSString *)fileType;

/**
 *  Read data from bundle file
 *
 *  @param fileName file name
 *  @param fileType file type
 *
 *  @return NSMutableDictionary
 */
- (NSMutableDictionary *)readDataFromBundleFile:(NSString *)fileName withType:(NSString *)fileType;

/**
 *  write data to file in bundle
 *
 *  @param writtenData data to be written
 *  @param fileName    file name
 *  @param fileType    file type
 */
- (void)writeData:(NSMutableDictionary *)writtenData toBundleFile:(NSString *)fileName withType:(NSString *)fileType;


@end
