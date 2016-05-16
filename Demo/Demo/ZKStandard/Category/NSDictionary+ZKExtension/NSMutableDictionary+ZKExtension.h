//
//  NSMutableDictionary+ZKExtension.h
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ZKExtension)

- (void)ZKSetSafeObject:(id)object forKey:(id<NSCopying>)key;

- (void)ZKSetSafeString:(id)object forKey:(id<NSCopying>)key;

@end
