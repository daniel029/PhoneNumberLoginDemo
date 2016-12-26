//
//  ClientRequest.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ClientRequest.h"
#import "NetworkManager.h"
#import "MockTestFactory.h"

@interface ClientRequest( )
{
    NSString *_response;
    RequestMessage *_requestMessage;
}

@end

@implementation ClientRequest

/**
 * @param request RequestMessage对象实例
 **/
- (id)initWithRequestMessage:(RequestMessage *)request
{
    self = [super init];
    if (self)
    {
        _requestMessage = request;
    }
    
    return self;
}

/**
 * 开始请求
 */
- (void)start
{
    [self mockTest];
}

- (void)mockTest
{
    _response = [MockTestFactory mockTestResponse:_requestMessage];
    if ([[NetworkManager instance] isReachable] == NO)
    {
        [self mockResponseCallback];
    }
    else
    {
        [self performSelector:@selector(mockResponseCallback) withObject:nil afterDelay:2];
    }
}

- (void)mockResponseCallback
{
    ResponseMessage *response = [ResponseMessage deserializeFromjsonString:_response];
    [response serializeToLocal];
    dispatchOnMainQueue(^{
        
        if (_serverResponse != nil)
        {
            _serverResponse(response);
        }
        [_delegate clientRequestFinished:self responseMessage:response];
        
    });
    
}

/**
 * 取消请求
 */
- (void)cancel
{
    
}

@end
