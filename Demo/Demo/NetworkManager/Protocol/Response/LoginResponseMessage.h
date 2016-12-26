//
//  LoginResponseMessage.h
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ResponseMessage.h"

@interface LoginResponseMessage : ResponseMessage
@property(nonatomic, strong) NSString *access_token;
@property(nonatomic, strong) NSString *token_type;
@property(nonatomic, assign) int expires_in;
@property(nonatomic, strong) NSString *refresh_token;

@end
