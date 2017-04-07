//
//  ZKUtils.h
//  ZKStandard
//
//  Created by Jack on 11/1/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Extern functions
/**
 * Boolean function to check for null values. 
 * Handy when you need to both check for nil and [NSNUll null]
 */
extern BOOL isNull(id value);


@interface ZKUtils : NSObject

@end
