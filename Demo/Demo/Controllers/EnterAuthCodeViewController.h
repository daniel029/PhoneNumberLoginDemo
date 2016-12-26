//
//  EnterAuthCodeViewController.h
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "BaseViewController.h"
#import "AreaCode.h"
#import "FetchAuthCodeResponseMessage.h"

@interface EnterAuthCodeViewController : BaseViewController
{
    UILabel *_tipsLabel;
    NSMutableArray *_arrCodeLabel;
    UITextField *_hideTextField;
    UIButton *_resendButton;
}

- (id)initWithFetchAuthCodeResponseMessage:(FetchAuthCodeResponseMessage *)message
                                  areaCode:(AreaCode *)areaCode
                               phoneNumber:(NSString *)phoneNumber;

@end
