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
 *  @method             sharedManager
 *  @abstract           share fileManager
 *  @discussion
 *  @param              NULL
 *  @param result       return ZKFileManager Singleton
 */
+ (ZKFileManager *)sharedManager;

/**
 *  @method             readFromBundleFile
 *  @abstract           read data from bundle file
 *  @discussion
 *  @param fileName     file name
 *  @param fileType     file type
 *  @param result       return NSMutableDictionary
 */
- (NSMutableDictionary *)readFromBundleFile:(NSString *)fileName withType:(NSString *)fileType;

/**
 *  @method             writeData
 *  @abstract           write data to file in bundle
 *  @discussion
 *  @param writtenData  data to be written
 *  @param fileName     file name
 *  @param fileType     file type
 *  @param result       void
 */
- (void)writeData:(NSMutableDictionary *)writtenData toBundleFile:(NSString *)fileName withType:(NSString *)fileType;


@end
