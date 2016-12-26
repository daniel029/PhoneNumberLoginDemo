//
//  NBPhoneNumber+ex.m
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "NBPhoneNumber+ex.h"
#import "NBPhoneNumberUtil.h"

@implementation NBPhoneNumber (ex)

+ (BOOL)isValidNumber:(NSString *)phoneNumber countryCode:(int)countryCode
{
    if ([phoneNumber length] == 0)
    {
        return NO;
    }
    
    if (countryCode <= 0)
    {
        return NO;
    }
    
    NSString *regionCode = [[NBPhoneNumberUtil sharedInstance] getRegionCodeForCountryCode:[NSNumber numberWithInt:countryCode]];
    if ([regionCode length] == 0)
    {
        return NO;
    }
    
    NSString *filterNumber = [NSString filterPhone:phoneNumber];
    filterNumber = [NSString stringWithFormat:@"+%d%@", countryCode, filterNumber];
    NBPhoneNumber *nbNumber = [[NBPhoneNumberUtil sharedInstance] parse:filterNumber defaultRegion:regionCode error:nil];
    if (nbNumber.countryCode > 0)
    {
        return [[NBPhoneNumberUtil sharedInstance] isValidNumber:nbNumber];
    }
    
    return NO;
}

+ (BOOL)isValidNumber:(NSString *)phoneNumber countryCodeString:(NSString *)countryCode
{
    int code = [[NSString filterPhone:countryCode] intValue];
    return [self isValidNumber:phoneNumber countryCode:code];
}

@end
