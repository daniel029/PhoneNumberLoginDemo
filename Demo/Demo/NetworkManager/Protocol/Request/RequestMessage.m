//
//  RequestMessage.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "RequestMessage.h"

@implementation RequestMessage

- (id)init
{
    self = [super init];
    if (self)
    {
        _needOAuth = YES;
        _requestType = @"POST";
        _hostName = @"";
    }
    
    return self;
}

/**
 * 获取请求参数
 **/
- (NSDictionary *)requestParams
{
    return @{};
}

/**
 * 获取请求接口的ur
 */
- (NSString *)requestApiUrl
{
    return @"";
}

@end
