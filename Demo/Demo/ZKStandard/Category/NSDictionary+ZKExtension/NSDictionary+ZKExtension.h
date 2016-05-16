//
//  NSDictionary+ZKExtension.h
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZKExtension)

- (id)ZKSafeObjectForKey:(id)key;

- (NSString *)ZKSafeStringForKey:(id)key;

- (NSNumber *)ZKSafeNumberForKey:(id)key;

@end
