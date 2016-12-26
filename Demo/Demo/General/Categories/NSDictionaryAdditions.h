//
//  NSDictionaryAdditions.h
//  Digisocial
//
//  Created by junmin liu on 10-10-6.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Additions)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (uint)getUIntValueForKey:(NSString *)key defaultValue:(uint)defaultValue;
- (float)getFloatValueForKey:(NSString *)key defaultValue:(float)defaultValue;
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSArray *)getArrayForKey:(NSString *)key;
- (NSDictionary *)getDictionaryForKey:(NSString *)key;
@end
