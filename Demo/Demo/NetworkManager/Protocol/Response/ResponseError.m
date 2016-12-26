//
//  ResponseError.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ResponseError.h"
#import "NSString+Category.h"

@implementation ResponseError

- (id)initWithCode:(int)code
{
    self = [super init];
    if (self)
    {
        _code = code;
        _content = [ResponseError errorContentFromErrorCode:code];
    }
    
    return self;
}

- (id)initWithCode:(int)code hideAfterDelay:(int)hideAfterDelay
{
    self = [super init];
    if (self)
    {
        _code = code;
        _content = [ResponseError errorContentFromErrorCode:code];
        _hideAfterDelay = hideAfterDelay;
    }
    
    return self;
}

/**
 * 返回json格式的字典集合
 */
- (NSDictionary *)jsonDictionary
{
    return @{
             @"code":@(_code),
             @"content":(_content == nil) ? [ResponseError errorContentFromErrorCode:_code] : _content,
             @"hideAfterDelay":@(_hideAfterDelay)
             };
}

+ (NSString *)errorContentFromErrorCode:(int)errorCode
{
    NSString *strCode = [NSString stringWithFormat:@"error_code_%d", errorCode];
    NSString *defaultContent = [NSString stringWithFormat:@"Error code: %d", errorCode];
    return MLocalizableString(strCode, defaultContent);
}

/**
 * 返回网络不可用error
 **/
+ (ResponseError *)networkUnReachableError
{
    ResponseError *error = [[ResponseError alloc] initWithCode:NSURLErrorNetworkConnectionLost hideAfterDelay:3];
    return error;
}

/**
 * 服务器返回数据error
 **/
+ (ResponseError *)serverDataError
{
    ResponseError *error = [[ResponseError alloc] initWithCode:ErrorCodeServerDataError hideAfterDelay:0];
    return error;
}

@end
