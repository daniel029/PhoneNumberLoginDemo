//
//  LoginResponseMessage.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "LoginResponseMessage.h"
#import "JSONKit.h"
#import "AFOAuthCredential+Category.h"

@implementation LoginResponseMessage

- (NSString *)serializeJsonString
{
    return [[self jsonDictionary] JSONString];
}

- (NSDictionary *)jsonDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_access_token ? _access_token : @"" forKey:@"access_token"];
    [dic setObject:_token_type ? _token_type : @"" forKey:@"token_type"];
    [dic setObject:@(_expires_in) forKey:@"expires_in"];
    [dic setObject:_refresh_token ? _refresh_token : @"" forKey:@"refresh_token"];
    
    if (self.error)
    {
        return @{@"name":@"LoginResponseMessage",
                 @"value":dic,
                 @"error":[self.error jsonDictionary]};
    }
    return @{@"name":@"LoginResponseMessage", @"value":dic};
}

/**
 * 检查请求返回的内容是否有错误
 * @param showError YES: 如果有错误就显示给用户，NO: 不显示
 * @return YES：有错误，NO：没错误
 */
- (BOOL)checkError:(BOOL)showError desiredClass:(Class)desiredClass
{
    BOOL ret = [super checkError:showError desiredClass:desiredClass];
    if (ret == NO)
    {
        if ([_access_token length] == 0 || [_token_type length] == 0 || _expires_in <= 0 || [_refresh_token length] == 0)
        {
            self.error = [[ResponseError alloc] initWithCode:ErrorCodeServerDataTokenError hideAfterDelay:0];
            if (showError)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:self.error.content
                                                               delegate:nil
                                                      cancelButtonTitle:MLocalizableString(@"confirm", @"确定")
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            
            return YES;
        }
    }
    
    return ret;
}

/**
 * 序列化服务器返回内容到本地
 **/
- (void)serializeToLocal
{
    if (self.error.code != 0)
    {
        return;
    }
    [AFOAuthCredential storeOauthCredential:_access_token refresh_token:_refresh_token expires_in:_expires_in token_type:_token_type];
}

@end
