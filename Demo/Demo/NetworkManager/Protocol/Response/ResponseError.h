//
//  ResponseError.h
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseError : NSObject

@property(nonatomic, assign) int code;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, assign) int hideAfterDelay;  //0: 不消失，需要用户点击确认 否则：过时消失

- (id)initWithCode:(int)code;
- (id)initWithCode:(int)code hideAfterDelay:(int)hideAfterDelay;

/**
 * 返回json格式的字典集合
 */
- (NSDictionary *)jsonDictionary;

/**
 * 根据errorCode返回error内容
 */
+ (NSString *)errorContentFromErrorCode:(int)errorCode;


/**
 * 返回网络不可用error
 **/
+ (ResponseError *)networkUnReachableError;

/**
 * 服务器返回数据error
 **/
+ (ResponseError *)serverDataError;
@end
