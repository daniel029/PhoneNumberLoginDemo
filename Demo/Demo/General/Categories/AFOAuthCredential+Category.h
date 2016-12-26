//
//  AFOAuthCredential+Category.h
//  Demo
//
//  Created by daniel on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "AFOAuthCredential.h"

@interface AFOAuthCredential (Category)

+ (void)storeOauthCredential:(NSString *)access_token
               refresh_token:(NSString *)refresh_token
                  expires_in:(int)expires_in
                  token_type:(NSString *)token_type;

@end
