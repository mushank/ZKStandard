//
//  ZKUtils.h
//  ZKStandard
//
//  Created by Jack on 3/1/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZKDateFormatterType) {
    ZKDateFormatterZero = 0,    /* MM/dd */
    ZKDateFormatterOne,         /* yyyy-MM-dd */
    ZKDateFormatterTwo,         /* yyyy-MM-dd HH:mm:ss */
};

@interface ZKUtils : NSObject

// 对日期进行排序，单日日期作`03/11`显示，连续日期作`03/11-03/21`显示，非连续日期作`03/11·03/13·03/16`显示
+ (NSString *)sortedDateStringInFormatter:(ZKDateFormatterType)type fromArray:(NSArray<NSDate *> *)array;

+ (NSString *)dateFormatterString:(ZKDateFormatterType)type;

@end
