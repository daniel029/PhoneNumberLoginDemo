//
//  ISOAreaCode.m
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ISOAreaCode.h"

@implementation ISOAreaCode

+ (ISOAreaCode *)instance
{
    static dispatch_once_t onceToken;
    static ISOAreaCode *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[ISOAreaCode alloc] init];
    });
    
    return sSharedInstance;
}

- (AreaCode *)localAreaCode
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *value = [locale localeIdentifier];
    NSArray *array = [value componentsSeparatedByString:@"_"];
    NSString *countryCode = @"US";
    if ([array count] == 1)
    {
        countryCode = [array objectAtIndex:0];
    }
    else if ([array count] > 1)
    {
        countryCode = [array objectAtIndex:1];
    }
    NSString *strAreaCode = MLocalizableString(countryCode, nil);
    if ([strAreaCode isEqualToString: countryCode])
    {
        strAreaCode = MLocalizableString(@"US", nil);
    }
    array = [strAreaCode componentsSeparatedByString:@","];
    AreaCode *areaCode = [[AreaCode alloc] initWithString:strAreaCode];
    return areaCode;
}

- (NSString *)countryCode:(NSString*)areaCode
{
    areaCode = [areaCode uppercaseString];
    NSString *strCountryCode = MLocalizableString(areaCode, nil);
    if ([strCountryCode isEqualToString: areaCode])
    {
        return @"";
    }
    
    NSArray *array = [strCountryCode componentsSeparatedByString:@","];
    if ([array count] < 2)
    {
        return @"";
    }
    return [array objectAtIndex:1];
}

- (void)setAreaCodeToIndexPath
{
    if (_dicAreaCodeToIndex)
    {
        return;
    }
    
    _dicAreaCodeToIndex = [[NSMutableDictionary alloc] init];
    int section = 0;
    for (NSArray *arr in _arrAreaCodes)
    {
        int row = 0;
        for (AreaCode *areaCode in arr)
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
            [_dicAreaCodeToIndex setObject:path forKey:areaCode.area];
            ++row;
        }
        ++section;
    }
}

- (NSMutableArray *)ISOAreaCodeArray
{
    if (_arrAreaCodes)
    {
        return _arrAreaCodes;
    }
    NSMutableDictionary *areaCodeDict = [[NSMutableDictionary alloc] initWithCapacity:26];
    NSArray *isoCountryCodes = [NSLocale ISOCountryCodes];
    NSRange range;
    range.location = 0;
    range.length = 1;
    for (NSString *countryCode in isoCountryCodes)
    {
        NSString *areaCode = MLocalizableString(countryCode, nil);
        if (areaCode == nil || [areaCode isEqualToString: countryCode])
        {
            continue;
        }
        
        AreaCode *stAreaCode = [[AreaCode alloc] initWithString:areaCode];
        NSString *fl = [stAreaCode.area substringWithRange:range]; //国家名称首字母
        NSMutableArray *arrAreaCode = [areaCodeDict objectForKey:fl];      //根据首字母进行分类后的AreaCode数组
        if (!arrAreaCode)
        {
            arrAreaCode = [[NSMutableArray alloc] init];
            [areaCodeDict setObject:arrAreaCode forKey:fl];
        }
        [arrAreaCode addObject:stAreaCode];
    }
    
    NSArray *arrayKeys = [areaCodeDict allKeys];
    arrayKeys = [arrayKeys sortedArrayUsingSelector:@selector(compare:)];
    if (!_searchIndex)
    {
        _searchIndex = arrayKeys;
    }
    _arrAreaCodes = [[NSMutableArray alloc] initWithCapacity:[arrayKeys count]];
    for (NSString *key in arrayKeys)
    {
        NSMutableArray *areaCodes = (NSMutableArray *)[areaCodeDict objectForKey:key];
        NSArray *sortedArray = [areaCodes sortedArrayUsingSelector:@selector(letterAscendSort:)];
        [_arrAreaCodes addObject:sortedArray];
    }
    [self setAreaCodeToIndexPath];
    return _arrAreaCodes;
}

- (NSArray *)searchIndex
{
    return _searchIndex;
}

- (NSIndexPath *)indexPathByArea:(NSString *)area
{
    return [_dicAreaCodeToIndex objectForKey:area];
}

- (NSInteger)numberOfSections
{
    NSMutableArray *arr = [self ISOAreaCodeArray];
    NSInteger count = [arr count];
    return count;
    
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *arr = [self ISOAreaCodeArray];
    NSInteger count = [[arr objectAtIndex:section] count];
    return count;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section
{
    NSMutableArray *arr = [self ISOAreaCodeArray];
    AreaCode *areaCode = (AreaCode *)[[arr objectAtIndex:section] objectAtIndex:0];
    
    return [areaCode.area substringWithRange:NSMakeRange(0, 1)];
}

- (AreaCode *)areaCodeAtSection:(NSInteger)section Row:(NSInteger)row
{
    NSMutableArray *arr = [self ISOAreaCodeArray];
    AreaCode *areaCode = (AreaCode *)[[arr objectAtIndex:section] objectAtIndex:row];
    return areaCode;
}

//通过countrycode 查找 areacode
- (NSString *)areaCode:(NSString *)countryCode
{
    NSMutableArray *arr =[self ISOAreaCodeArray];
    NSString *strareacode = @"";
    for (int i = 0; i<=arr.count-1; i++) {
        NSMutableArray *arrcountry = [arr objectAtIndex:i];
        for (int j = 0; j <= arrcountry.count-1; j++) {
            AreaCode *areaCode = (AreaCode *)[[arr objectAtIndex:i] objectAtIndex:j];
            if ( [areaCode.code isEqualToString:countryCode]) {
                strareacode = areaCode.area;
                break;
            }
        }
    }
    
    return strareacode;
}

- (BOOL)isValidCountryCode:(NSString *)countryCode
{
    NSString *areaCode = [self areaCode:countryCode];
    return [areaCode length] > 0;
}

@end
