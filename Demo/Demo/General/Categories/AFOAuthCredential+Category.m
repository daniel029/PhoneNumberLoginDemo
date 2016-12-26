//
//  AFOAuthCredential+Category.m
//  Demo
//
//  Created by daniel on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "AFOAuthCredential+Category.h"

@implementation AFOAuthCredential (Category)

+ (void)storeOauthCredential:(NSString *)access_token
               refresh_token:(NSString *)refresh_token
                  expires_in:(int)expires_in
                  token_type:(NSString *)token_type
{
    if ([access_token length] == 0 || [token_type length] == 0)
    {
        return;
    }
    
    AFOAuthCredential *credential = [AFOAuthCredential credentialWithOAuthToken:access_token tokenType:token_type];
    
    
    if (refresh_token) { // refreshToken is optional in the OAuth2 spec
        [credential setRefreshToken:refresh_token];
    }
    
    // Expiration is optional, but recommended in the OAuth2 spec. It not provide, assume distantFuture === never expires
    
    if (expires_in > 0)
    {
        NSDate *expireDate = expireDate = [NSDate dateWithTimeIntervalSinceNow:expires_in];
        
        if (expireDate) {
            [credential setExpiration:expireDate];
        }
    }
    
    [AFOAuthCredential storeCredential:credential withIdentifier:OAuthCredentialIdentifier];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotifyUpdateAFOAuthCredential object:credential];
}

@end
