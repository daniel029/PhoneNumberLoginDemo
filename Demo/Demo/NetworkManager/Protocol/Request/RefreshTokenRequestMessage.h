//
//  RefreshTokenRequestMessage.h
//  Demo
//
//  Created by daniel on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "RequestMessage.h"

@interface RefreshTokenRequestMessage : RequestMessage
@property(nonatomic, strong) NSString *refresh_token;

- (id)initWithRefreshToken:(NSString *)refreshToken;

@end
