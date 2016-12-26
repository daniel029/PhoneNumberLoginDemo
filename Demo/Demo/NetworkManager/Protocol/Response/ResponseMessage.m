//
//  ResponseMessage.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ResponseMessage.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "NSDictionaryAdditions.h"

@implementation ResponseMessage

/**
 * 根据json字符串，反序列化ResponseMessage对象实例
 */
+ (ResponseMessage *)deserializeFromjsonString:(NSString *)jsonString
{
    ResponseMessage *response = nil;
    @try {
        NSDictionary *dic = [jsonString objectFromJSONString];
        if ([dic isKindOfClass:[NSDictionary class]] == NO)
        {
            response = [[ResponseMessage alloc] init];
            response.error = [ResponseError serverDataError];
        }
        else
        {
            NSString *className = [dic getStringValueForKey:@"name" defaultValue:@""];
            if ([className length] == 0)
            {
                response = [[ResponseMessage alloc] init];
                response.error = [ResponseError serverDataError];
            }
            else
            {
                Class responseClass = NSClassFromString(className);
                id instance = [[responseClass alloc] init];
                if ([instance isKindOfClass:[ResponseMessage class]] == NO)
                {
                    response = [[ResponseMessage alloc] init];
                    response.error = [ResponseError serverDataError];
                }
                else
                {
                    NSDictionary *value = [dic getDictionaryForKey:@"value"];
                    if (value == nil)
                    {
                        response = [[ResponseMessage alloc] init];
                        response.error = [ResponseError serverDataError];
                    }
                    else
                    {
                        [instance setValuesForKeysWithDictionary:value];
                        response = (ResponseMessage *)instance;
                        
                        NSDictionary *error = [dic getDictionaryForKey:@"error"];
                        if (error != nil)
                        {
                            response.error = [[ResponseError alloc] init];
                            [response.error setValuesForKeysWithDictionary:error];
                        }
                    }
                }
            }
        }
    } @catch (NSException *exception) {
        response = [[ResponseMessage alloc] init];
        response.error = [ResponseError serverDataError];
        
    } @finally {
        
    }
    
    return response;
}


/**
 * 返回json格式的字符串, 继承类需要实现该方法
 */
- (NSString *)serializeJsonString
{
    return @"";
}

/**
 * 检查请求返回的内容是否有错误
 * @param showError YES: 如果有错误就显示给用户，NO: 不显示
 * @return YES：有错误，NO：没错误
 */
- (BOOL)checkError:(BOOL)showError desiredClass:(Class)desiredClass
{
    if (_error.code != 0)
    {
        if (showError)
        {
            if (_error.hideAfterDelay == 0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:_error.content
                                                               delegate:nil
                                                      cancelButtonTitle:MLocalizableString(@"confirm", @"确定")
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:delegate.window];
                hud.mode = MBProgressHUDModeCustomView;
                hud.detailsLabel.text = _error.content;
                [delegate.window addSubview:hud];
                [hud showAnimated:YES];
                [hud hideAnimated:YES afterDelay:_error.hideAfterDelay];
            }
        }
        
        
        return YES;
    }
    
    if ([self isKindOfClass:desiredClass] == NO)
    {
        self.error = [[ResponseError alloc] initWithCode:ErrorCodeServerDataError hideAfterDelay:0];
        
        if (showError)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:self.error.content
                                                           delegate:nil
                                                  cancelButtonTitle:MLocalizableString(@"confirm", @"确定")
                                                  otherButtonTitles:nil];
            [alert show];
        }
        DDLogError(@"desiredClass: %@, self: %@", [desiredClass description], [self description]);
        return YES;
    }
    
    
    return NO;
}

/**
 * 序列化服务器返回内容到本地，继承类有需要的话，实现该方法
 **/
- (void)serializeToLocal
{
    
}

@end
