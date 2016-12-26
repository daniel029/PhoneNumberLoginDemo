//
//  NetworkManager.h
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "RequestMessage.h"
#import "ResponseMessage.h"

typedef void (^ServerResponse)(ResponseMessage *response);

@interface NetworkManager : NSObject

+ (NetworkManager *)instance;

/**
 *  开始检测网络状况
 **/
- (void)startMonitorNetwork;

/**
 *  停止检测网络状况
 **/
- (void)stopMonitorNetwork;

/**
 *  网络状况是否可用
 **/
- (BOOL)isReachable;

/**
 * 判断用户是否已经登录
 */
- (BOOL)isLogin;

/**
 * 判断AccessToken是否过期
 */
- (BOOL)isAccessTokenExpires;


/**
 * 向服务器发送请求
 * @param message RequestMessage对象实例
 * @param completion block callback
 */
- (void)sendRequestMessage:(RequestMessage *)message completion:(ServerResponse)completion;

@end
