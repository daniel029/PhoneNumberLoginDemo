//
//  ResponseMessage.h
//  Demo
//  @note 服务器返回内容的基类
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseError.h"

@interface ResponseMessage : NSObject
@property(nonatomic, strong) ResponseError *error;

/**
 * 根据json字符串，反序列化ResponseMessage对象实例
 */
+ (ResponseMessage *)deserializeFromjsonString:(NSString *)jsonString;

/**
 * 返回json格式的字符串, 继承类需要实现该方法
 */
- (NSString *)serializeJsonString;

/**
 * 检查请求返回的内容是否有错误
 * @param showError YES: 如果有错误就显示给用户，NO: 不显示
 * @return YES：有错误，NO：没错误
 */
- (BOOL)checkError:(BOOL)showError desiredClass:(Class)desiredClass;

/**
 * 序列化服务器返回内容到本地，继承类有需要的话，实现该方法
 **/
- (void)serializeToLocal;

@end
