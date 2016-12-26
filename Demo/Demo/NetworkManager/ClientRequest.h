//
//  ClientRequest.h
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseMessage.h"
#import "RequestMessage.h"

@class ClientRequest;

typedef void (^ServerResponse)(ResponseMessage *response);

@protocol ClientRequestDelegate <NSObject>

- (void)clientRequestFinished:(ClientRequest *)client responseMessage:(ResponseMessage *)message;

@end

@interface ClientRequest : NSObject

@property(nonatomic, copy) ServerResponse serverResponse;
@property(nonatomic, weak) id<ClientRequestDelegate> delegate;

/**
 * @param request RequestMessage对象实例
 **/
- (id)initWithRequestMessage:(RequestMessage *)request;

/**
 * 开始请求
 */
- (void)start;

/**
 * 取消请求
 */
- (void)cancel;

@end
