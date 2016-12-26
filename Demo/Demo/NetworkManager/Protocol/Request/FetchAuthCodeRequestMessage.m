//
//  FetchAuthCodeRequestMessage.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "FetchAuthCodeRequestMessage.h"

@implementation FetchAuthCodeRequestMessage

- (id)initWithCountryCode:(NSString *)code phoneNumber:(NSString *)phone
{
    self = [super init];
    if (self)
    {
        _countryCode = code;
        _phoneNumber = phone;
        self.needOAuth = NO;
    }
    
    return self;
}

- (NSDictionary *)requestParams
{
    return @{@"countryCode":_countryCode, @"phoneNumber":_phoneNumber};
}


- (NSString *)requestApiUrl
{
    return @"";
}

@end
