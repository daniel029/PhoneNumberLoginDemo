//
//  EnterAuthCodeViewController.m
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "EnterAuthCodeViewController.h"
#import "NSString+Category.h"
#import "MSWeakTimer.h"
#import "FetchAuthCodeRequestMessage.h"
#import "FetchAuthCodeResponseMessage.h"
#import "LoginRequestMessage.h"
#import "LoginResponseMessage.h"

@interface EnterAuthCodeViewController ()<UITextFieldDelegate, UINavigationControllerDelegate>
{
    AreaCode *_areaCode;
    NSString *_phoneNumber;
    MSWeakTimer *_timer;
    int _countdown;
    FetchAuthCodeResponseMessage *_message;
}

@end

@implementation EnterAuthCodeViewController

- (id)initWithFetchAuthCodeResponseMessage:(FetchAuthCodeResponseMessage *)message
                                  areaCode:(AreaCode *)areaCode
                               phoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if (self)
    {
        _areaCode = areaCode;
        _phoneNumber = phoneNumber;
        _arrCodeLabel = [[NSMutableArray alloc] init];
        _message = message;
        _countdown = _message.countDown;
        
    }
    
    return self;
}

- (void)dealloc
{
    [_timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:[NSString stringWithFormat:@"%@%@", _areaCode.code, _phoneNumber]];
    
    // Do any additional setup after loading the view.

    _tipsLabel = [self createLabel:16 color:[UIColor blackColor]];
    _tipsLabel.text = [NSString stringWithFormat:MLocalizableString(@"enter_auth_code_tips", @"验证码已经通过短信发送至以上号码\r\n请输入%d位数字验证码来完成手机号验证"), _message.authCodeCount];
    _tipsLabel.numberOfLines = 0;
    CGFloat width = [CG s].W - 20;
    CGSize size = [_tipsLabel.text compatibleSizeWithFont:_tipsLabel.font constrainedToSize:CGSizeMake(width, 0) lineBreakMode:NSLineBreakByWordWrapping];
    _tipsLabel.frame = CGRectMake(([CG s].W - size.width) / 2, 10 + NavBarHeight + StatusBarHeight, size.width, size.height + 10);
    [self.view addSubview:_tipsLabel];
    
    CGFloat fontSize = 26;
    CGFloat x = ([CG s].W - fontSize * _message.authCodeCount) / 2;
    CGFloat y = _tipsLabel.frame.origin.y + _tipsLabel.frame.size.height;
    for (int i = 0; i < _message.authCodeCount; ++i)
    {
        UILabel *codeLabel = [self createLabel:fontSize color:[UIColor blackColor]];
        codeLabel.frame = CGRectMake(x + fontSize * i, y, fontSize, fontSize + 1);
        codeLabel.text = @"-";
        [self.view addSubview:codeLabel];
        [_arrCodeLabel addObject:codeLabel];
    }

    _hideTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _hideTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _hideTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _hideTextField.delegate = self;
    _hideTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _hideTextField.spellCheckingType = UITextSpellCheckingTypeNo;
    _hideTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_hideTextField];
    
    
    _resendButton = [[UIButton alloc] initWithFrame:CGRectMake(([CG s].W - 100) / 2, y + fontSize + 10, 100, 44)];
    _resendButton.backgroundColor = [UIColor clearColor];
    [_resendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_resendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_resendButton addTarget:self action:@selector(resendAuthCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resendButton];
    
    if (_countdown > 0)
    {
        [self lockView];
    }
    else
    {
        [self unlockView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_hideTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self mockAuthCodeTips];
}

- (void)mockAuthCodeTips
{
    if ([_message.mockAuthCode length] > 0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:[NSString stringWithFormat:@"用于测试的验证码：%@, 请使用该值。", _message.mockAuthCode]
                                                       delegate:nil
                                              cancelButtonTitle:MLocalizableString(@"confirm", @"确定")
                                              otherButtonTitles:nil];
        [alert show];
    }
}


- (UILabel *)createLabel:(CGFloat)fontSize color:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.6;
    label.textColor = color;
    return label;
}

- (void)resendAuthCode
{
    _resendButton.enabled = NO;
    [self.navigationItem setHidesBackButton:YES];
    
    //请求验证码
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FetchAuthCodeRequestMessage *message = [[FetchAuthCodeRequestMessage alloc] initWithCountryCode:_areaCode.code phoneNumber:_phoneNumber];
    [[NetworkManager instance] sendRequestMessage:message completion:^(ResponseMessage *response) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //检查服务器返回内容是否有错误
        if ([response checkError:YES desiredClass:[FetchAuthCodeResponseMessage class]] == NO)
        {
            _message = (FetchAuthCodeResponseMessage *)response;
            _countdown = _message.countDown;
            
            [self lockView];
            [self mockAuthCodeTips];
        }
        else
        {
            _resendButton.enabled = YES;
            [self.navigationItem setHidesBackButton:NO];
        }
        
    }];
}

- (void)lockView
{
    if (_timer == nil)
    {
        _timer = [MSWeakTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(onTimer)
                                                    userInfo:nil
                                                     repeats:YES
                                               dispatchQueue:dispatch_get_main_queue()];
        [_timer fire];
    }
    _resendButton.enabled = NO;
    [self.navigationItem setHidesBackButton:YES];
    [self refreshResendButtonContent];
}

- (void)unlockView
{
    [_timer invalidate];
    _timer = nil;
    _resendButton.enabled = YES;
    [self.navigationItem setHidesBackButton:NO];
    [self refreshResendButtonContent];
}

- (void)onTimer
{
    _countdown--;
    if (_countdown == 0)
    {
        [self unlockView];
    }
    else
    {
        [self refreshResendButtonContent];
    }
    
}

- (void)refreshResendButtonContent
{
    if (_countdown == 0)
    {
        [_resendButton setTitle:MLocalizableString(@"resend", @"重发") forState:UIControlStateNormal];
    }
    else
    {
        [_resendButton setTitle:[NSString stringWithFormat:@"%@(%d)", MLocalizableString(@"resend", @"重发"), _countdown] forState:UIControlStateNormal];
    }
}

#pragma mark ------------------UITextField delegate---------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *typedString = [textField.text stringByReplacingCharactersInRange: range
                                                                    withString: string];
    
    if (typedString.length > _arrCodeLabel.count)
    {
        return NO;
    }
    
    for (int i = 0; i < _arrCodeLabel.count; ++i)
    {
        UILabel *label = _arrCodeLabel[i];
        label.text = @"-";
    }
    
    for (int i = 0; i < typedString.length; ++i)
    {
        UILabel *label = _arrCodeLabel[i];
        label.text = [typedString substringWithRange:NSMakeRange(i, 1)];
    }
    
    if (typedString.length == _message.authCodeCount)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        FetchAuthCodeRequestMessage *fetchAuthCoderequest = [[FetchAuthCodeRequestMessage alloc] initWithCountryCode:_areaCode.code phoneNumber:_phoneNumber];
        LoginRequestMessage *loginRequest = [[LoginRequestMessage alloc] initWithFetchAuthCodeRequestMessage:fetchAuthCoderequest authCode:typedString];
        [[NetworkManager instance] sendRequestMessage:loginRequest completion:^(ResponseMessage *response) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            //检查服务器返回内容是否有错误
            if ([response checkError:YES desiredClass:[LoginResponseMessage class]] == NO)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotifyLoginSuccess object:nil];
            }
        }];
    }
    
    return YES;
}

@end
