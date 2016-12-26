//
//  RefreshTokenResponseMessage.h
//  Demo
//
//  Created by daniel on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ResponseMessage.h"

@interface RefreshTokenResponseMessage : ResponseMessage

@property(nonatomic, strong) NSString *access_token;
@property(nonatomic, strong) NSString *token_type;
@property(nonatomic, assign) int expires_in;
@property(nonatomic, strong) NSString *refresh_token;

@end
