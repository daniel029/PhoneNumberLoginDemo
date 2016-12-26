//
//  FetchAuthCodeRequestMessage.h
//  Demo
//  @note 获取验证码的请求消息
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "RequestMessage.h"

@interface FetchAuthCodeRequestMessage : RequestMessage
@property(nonatomic, strong, readonly) NSString *countryCode;
@property(nonatomic, strong, readonly) NSString *phoneNumber;

- (id)initWithCountryCode:(NSString *)code phoneNumber:(NSString *)phone;


@end
