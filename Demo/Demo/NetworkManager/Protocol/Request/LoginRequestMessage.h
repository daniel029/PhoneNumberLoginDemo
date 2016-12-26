//
//  LoginRequestMessage.h
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "RequestMessage.h"
#import "FetchAuthCodeRequestMessage.h"

@interface LoginRequestMessage : RequestMessage
@property(nonatomic, strong, readonly) FetchAuthCodeRequestMessage *message;
@property(nonatomic, strong, readonly) NSString *authCode;

- (id)initWithFetchAuthCodeRequestMessage:(FetchAuthCodeRequestMessage *)message
                                 authCode:(NSString *)authCode;

@end
