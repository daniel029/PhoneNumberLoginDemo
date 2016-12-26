//
//  NetworkManager.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "NetworkManager.h"
#import "ClientRequest.h"
#import "AFOAuthCredential.h"
#import "RefreshTokenRequestMessage.h"
#import "RefreshTokenResponseMessage.h"

@interface NetworkManager( )<ClientRequestDelegate>
{
    Reachability *_reachbility;
    NSMutableArray *_arrClient;
    AFOAuthCredential *_oauthCredential;
}

@end

@implementation NetworkManager

+ (NetworkManager *)instance
{
    static dispatch_once_t onceToken;
    static NetworkManager *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[NetworkManager alloc] init];
    });
    
    return sSharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _arrClient = [[NSMutableArray alloc] init];
        _oauthCredential = [AFOAuthCredential retrieveCredentialWithIdentifier:OAuthCredentialIdentifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyLogout:) name:NotifyLogout object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyUpdateAFOAuthCredential:) name:NotifyUpdateAFOAuthCredential object:nil];
        if (_oauthCredential != nil)
        {
            if ([_oauthCredential isExpired])
            {
                [self performSelector:@selector(sendRefreshTokenRequest) withObject:nil afterDelay:0];
            }
        }
    }
    
    return self;
}

- (void)startMonitorNetwork
{
    [self stopMonitorNetwork];
    _reachbility = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [_reachbility startNotifier];
}

- (void)stopMonitorNetwork
{
    if (_reachbility)
    {
        [_reachbility stopNotifier];
        _reachbility = nil;
    }
}

- (BOOL)isReachable
{
    return [_reachbility isReachable];
}

/**
 * 判断用户是否已经登录
 */
- (BOOL)isLogin
{
    return (_oauthCredential != nil);
}

/**
 * 判断AccessToken是否过期
 */
- (BOOL)isAccessTokenExpires
{
    if (_oauthCredential == nil)
    {
        return YES;
    }
    
    return [_oauthCredential isExpired];
}

/**
 * 向服务器发送请求
 * @param message RequestMessage对象实例
 * @param completion block callback
 */
- (void)sendRequestMessage:(RequestMessage *)message completion:(ServerResponse)completion
{
    ClientRequest *client = [[ClientRequest alloc] initWithRequestMessage:message];
    client.serverResponse = completion;
    client.delegate = self;
    [client start];
    
    [_arrClient addObject:client];
}

- (void)sendRefreshTokenRequest
{
    RefreshTokenRequestMessage *request = [[RefreshTokenRequestMessage alloc] initWithRefreshToken:_oauthCredential.refreshToken];
    [self sendRequestMessage:request completion:nil];
}

#pragma mark -
#pragma ClientRequestDelegate
- (void)clientRequestFinished:(ClientRequest *)client responseMessage:(ResponseMessage *)message
{
    if (client == nil)
    {
        return;
    }
    
    [_arrClient removeObject:client];
}


#pragma mark -
#pragma Notification
- (void)onNotifyLogout:(NSNotification *)notify
{
    [AFOAuthCredential deleteCredentialWithIdentifier:OAuthCredentialIdentifier];
    _oauthCredential = nil;
}

- (void)onNotifyUpdateAFOAuthCredential:(NSNotification *)notify
{
    AFOAuthCredential *oauth = [notify object];
    if ([oauth isKindOfClass:[AFOAuthCredential class]])
    {
        _oauthCredential = oauth;
    }
}

@end
