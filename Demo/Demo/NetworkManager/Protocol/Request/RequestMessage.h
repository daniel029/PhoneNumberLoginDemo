//
//  RequestMessage.h
//  Demo
//  @note 向服务器发送请求的基类
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

@interface RequestMessage : NSObject
@property(nonatomic, assign) BOOL needOAuth;  //YES: 请求参数需要带有oauth认证的assess_token，NO：不需要, 默认值:YES
@property(nonatomic, strong) NSString *requestType; //POST, GET, PUT, 默认值：POST
@property(nonatomic, strong) NSString *hostName;  //请求的域名

/**
 * 获取请求参数，继承类需要实现该方法
 **/
- (NSDictionary *)requestParams;

/**
 * 获取请求接口的ur, 继承类需要实现该方法
 */
- (NSString *)requestApiUrl;


@end
