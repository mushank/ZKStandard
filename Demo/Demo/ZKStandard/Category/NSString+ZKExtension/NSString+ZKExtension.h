//
//  NSString+ZKExtension.h
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZKExtension)

#pragma mark - Cast to date
- (NSDate *)ZKDateFromFormatter:(ZKDateFormatterType)type;

#pragma mark - Utils
- (NSString *)ZKRemoveWhiteSpaceCharacter;

@end
