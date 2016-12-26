//
//  LoginRequestMessage.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "LoginRequestMessage.h"

@implementation LoginRequestMessage

- (id)initWithFetchAuthCodeRequestMessage:(FetchAuthCodeRequestMessage *)message
                                 authCode:(NSString *)authCode
{
    self = [super init];
    if (self)
    {
        _message = message;
        _authCode = authCode;
        self.needOAuth = NO;
    }
    
    return self;
}

- (NSDictionary *)requestParams
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[_message requestParams]];
    [dic setObject:_authCode forKey:@"authCode"];
    
    return dic;
}

/**
 * 获取请求接口的ur, 继承类需要实现该方法
 */
- (NSString *)requestApiUrl
{
    return @"";
}

@end
