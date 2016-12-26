//
//  MockTestFactory.m
//  Demo
//
//  Created by LiuYingbin on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "MockTestFactory.h"
#import "FetchAuthCodeRequestMessage.h"
#import "LoginRequestMessage.h"
#import "FetchAuthCodeResponseMessage.h"
#import "LoginResponseMessage.h"
#import "RefreshTokenRequestMessage.h"
#import "RefreshTokenResponseMessage.h"
#import "NBPhoneNumber+ex.h"

static NSString *g_mockAuthCode = @"";

#define MockAccessToken @"1234567890"
#define MockRefreshToken @"0987654321"
#define MockTokenExpire (3600 * 24 * 7)
#define MockTokenType @"bearer"

@implementation MockTestFactory

+ (NSString *)mockTestResponse:(RequestMessage *)message
{
    if ([message isKindOfClass:[FetchAuthCodeRequestMessage class]])
    {
        return [self mockTestFetchAuthCodeResponse:(FetchAuthCodeRequestMessage *)message];
    }
    else if ([message isKindOfClass:[LoginRequestMessage class]])
    {
        return [self mockTestLoginResponse:(LoginRequestMessage *)message];
    }
    else if ([message isKindOfClass:[RefreshTokenRequestMessage class]])
    {
        return [self mockTestRefreshTokenResponse:(RefreshTokenRequestMessage *)message];
    }
    
    return @"";
}

+ (NSString *)mockTestFetchAuthCodeResponse:(FetchAuthCodeRequestMessage *)message
{
    FetchAuthCodeResponseMessage *response = [[FetchAuthCodeResponseMessage alloc] init];
    if ([[NetworkManager instance] isReachable] == NO)
    {
        response.error = [ResponseError networkUnReachableError];
    }
    else
    {
        if ([NBPhoneNumber isValidNumber:message.phoneNumber countryCodeString:message.countryCode] == NO)
        {
            response.error = [[ResponseError alloc] initWithCode:ErrorCodePhoneNumberInValid hideAfterDelay:0];
        }
        else
        {
            g_mockAuthCode = @"654896";
            response.authCodeCount = 6;
            response.countDown = 30;
            response.mockAuthCode = g_mockAuthCode;
        }
    }
    return [response serializeJsonString];
}

+ (NSString *)mockTestLoginResponse:(LoginRequestMessage *)message
{
    LoginResponseMessage *response = [[LoginResponseMessage alloc] init];
    if ([[NetworkManager instance] isReachable] == NO)
    {
        response.error = [ResponseError networkUnReachableError];
    }
    else
    {
        if ([message.authCode isEqualToString:g_mockAuthCode] == NO)
        {
            response.error = [[ResponseError alloc] initWithCode:ErrorCodeAuthCodeInValid hideAfterDelay:0];
        }
        else
        {
            response.access_token = MockAccessToken;
            response.refresh_token = MockRefreshToken;
            response.expires_in = MockTokenExpire;
            response.token_type = MockTokenType;
        }
    }
    return [response serializeJsonString];
}

+ (NSString *)mockTestRefreshTokenResponse:(RefreshTokenRequestMessage *)message
{
    RefreshTokenResponseMessage *response = [[RefreshTokenResponseMessage alloc] init];
    if ([[NetworkManager instance] isReachable] == NO)
    {
        response.error = [ResponseError networkUnReachableError];
    }
    else
    {
        response.access_token = MockAccessToken;
        response.refresh_token = MockRefreshToken;
        response.expires_in = MockTokenExpire;
        response.token_type = MockTokenType;
    }
    return [response serializeJsonString];
}

@end
