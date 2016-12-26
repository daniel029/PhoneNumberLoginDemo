//
//  NSDictionaryAdditions.m
//  Digisocial
//
//  Created by junmin liu on 10-10-6.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (Additions)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue 
{
    if ([self objectForKey:key] == nil)
    {
        return defaultValue;
    }
    
    return [self objectForKey:key] == [NSNull null] ? defaultValue 
						: [[self objectForKey:key] boolValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue 
{
    if ([self objectForKey:key] == nil)
    {
        return defaultValue;
    }
    
	return [self objectForKey:key] == [NSNull null] 
				? defaultValue : [[self objectForKey:key] intValue];
}

- (uint)getUIntValueForKey:(NSString *)key defaultValue:(uint)defaultValue
{
    if ([self objectForKey:key] == nil)
    {
        return defaultValue;
    }
    
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] unsignedIntValue];
}

- (float)getFloatValueForKey:(NSString *)key defaultValue:(float)defaultValue
{
    if ([self objectForKey:key] == nil)
    {
        return defaultValue;
    }
    
	return [self objectForKey:key] == [NSNull null]
        ? defaultValue : [[self objectForKey:key] floatValue];
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue 
{
	NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) 
    {
        stringTime = @"";
    }
	struct tm created;
    time_t now;
    time(&now);
    
	if (stringTime) 
    {
		if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) 
        {
			strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
		}
		return mktime(&created);
	}
	return defaultValue;
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue 
{
    id res = [self objectForKey:key];
    if (res == nil || res == [NSNull null])
    {
        return defaultValue;
    }
    
    if ([res isKindOfClass:[NSDictionary class]])
    {
        return defaultValue;
    }
    
    if ([res isKindOfClass:[NSArray class]])
    {
        return defaultValue;
    }
    
	return [[self objectForKey:key] longLongValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue 
{
    if ([self objectForKey:key] == nil)
    {
        return defaultValue;
    }
    
	id res=[self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] 
				? defaultValue : [self objectForKey:key];
    if([res isKindOfClass:[NSString class]])
    {
        return res;
    }
    else
    {
        return [res description];
    }
}

- (NSArray *)getArrayForKey:(NSString *)key
{
    if([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null])
    {
        return nil;
    }
    else 
    {
        if([[self objectForKey:key] isKindOfClass:[NSArray class]])
        {
            return [self objectForKey:key];
        }
        else 
        {
            return nil;
        }
    }
}

- (NSDictionary *)getDictionaryForKey:(NSString *)key
{
    if([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null])
    {
        return nil;
    }
    else 
    {
        if([[self objectForKey:key] isKindOfClass:[NSDictionary class]])
        {
            return [self objectForKey:key];
        }
        else 
        {
            return nil;
        }
    }

}
@end
