//
//  FetchAuthCodeResponseMessage.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "FetchAuthCodeResponseMessage.h"
#import "JSONKit.h"

@implementation FetchAuthCodeResponseMessage

- (NSString *)serializeJsonString
{
    return [[self jsonDictionary] JSONString];
}

- (NSDictionary *)jsonDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@(_authCodeCount) forKey:@"authCodeCount"];
    [dic setObject:@(_countDown) forKey:@"countDown"];
    [dic setObject:_mockAuthCode ? _mockAuthCode : @"" forKey:@"mockAuthCode"];
    
    if (self.error)
    {
        return @{@"name":@"FetchAuthCodeResponseMessage",
                 @"value":dic,
                 @"error":[self.error jsonDictionary]};
    }
    
    return @{@"name":@"FetchAuthCodeResponseMessage", @"value":dic};
}

@end
