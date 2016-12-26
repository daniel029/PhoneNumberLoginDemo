//
//  RefreshTokenRequestMessage.m
//  Demo
//
//  Created by daniel on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "RefreshTokenRequestMessage.h"

@implementation RefreshTokenRequestMessage

- (id)initWithRefreshToken:(NSString *)refreshToken
{
    self = [super init];
    if (self)
    {
        _refresh_token = refreshToken;
        self.needOAuth = NO;
    }
    
    return self;
}

- (NSDictionary *)requestParams
{
    return @{@"refresh_token":_refresh_token, @"grant_type":@"refresh_token"};
}

/**
 * 获取请求接口的ur, 继承类需要实现该方法
 */
- (NSString *)requestApiUrl
{
    return @"";
}

@end
