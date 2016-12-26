//
//  PhoneNumberLoginViewController.m
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "PhoneNumberLoginViewController.h"
#import "ChooseAreaCodeViewController.h"
#import "ISOAreaCode.h"
#import "EnterAuthCodeViewController.h"
#import "NBPhoneNumber+ex.h"
#import "Reachability.h"
#import "FetchAuthCodeRequestMessage.h"

#define BUTTON_HEIGHT   57.0f//按钮高度

@interface PhoneNumberLoginViewController ()<UITextFieldDelegate
,UIAlertViewDelegate, ChooseAreaCodeDelegate>
{
    UILabel *_countryLabel;//国家label
    UITextField *_areaCodeField;//区号输入框
    UITextField *_phoneField;//电话输入框


}

@end

@implementation PhoneNumberLoginViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:MLocalizableString(@"phone_number", @"手机号码")];
    
    [self setNavBarRightButtonTitle:MLocalizableString(@"next", @"下一步")];
    
    self.navigationItem.rightBarButtonItem.enabled = ([_phoneField.text length] > 0);
    
    UIButton *hideKeyboardBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CG s].W, [CG s].H - StatusBarHeight - NavBarHeight)];
    hideKeyboardBtn.backgroundColor = [UIColor clearColor];
    [hideKeyboardBtn addTarget:self action:@selector(hideKeyBoardClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideKeyboardBtn];
    
    CGFloat addHeight = StatusBarHeight + NavBarHeight;
    
    UIImageView *segmentLine = [[UIImageView alloc] initWithFrame:CGRectMake(12.0f,
                                                                              BUTTON_HEIGHT + addHeight,
                                                                              [CG s].W, 0.5f)];
    [segmentLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:segmentLine];
    
    UIImageView *segmentLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(12.0f,
                                                                              BUTTON_HEIGHT * 2 + addHeight,
                                                                              [CG s].W, 0.5f)];
    [segmentLine2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:segmentLine2];
    
    UIImageView *segmentLine3 = [[UIImageView alloc] initWithFrame:CGRectMake(72.0f,
                                                                              BUTTON_HEIGHT + addHeight,
                                                                              0.5f, BUTTON_HEIGHT)];
    [segmentLine3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:segmentLine3];
    
    AreaCode *code = [[ISOAreaCode instance] localAreaCode];
    
    UIButton *countryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, addHeight, [CG s].W, BUTTON_HEIGHT)];
    [countryBtn addTarget:self action:@selector(countryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countryBtn];
    
    _areaCodeField = [[UITextField alloc] initWithFrame:CGRectMake(4.0f, addHeight + BUTTON_HEIGHT, 72.0f, BUTTON_HEIGHT)];
    _areaCodeField.backgroundColor = [UIColor clearColor];
    _areaCodeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _areaCodeField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _areaCodeField.textAlignment = NSTextAlignmentCenter;
    _areaCodeField.keyboardType = UIKeyboardTypeNumberPad;
    _areaCodeField.delegate=self;
    _areaCodeField.text = code.code;
    _areaCodeField.font = [UIFont systemFontOfSize:19];
    _areaCodeField.textColor = [UIColor blackColor];
    [self.view addSubview:_areaCodeField];
    
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(82.0f, addHeight + BUTTON_HEIGHT,[CG s].W - 72.0f, BUTTON_HEIGHT)];
    _phoneField.backgroundColor = [UIColor clearColor];
    _phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneField.delegate=self;
    _phoneField.placeholder = MLocalizableString(@"enter_phone_number",@"填写手机号码");
    _phoneField.font = [UIFont systemFontOfSize:19];
    _phoneField.textColor = [UIColor blackColor];
    [self.view addSubview:_phoneField];
    
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, addHeight, [CG s].W, BUTTON_HEIGHT)];
    _countryLabel.textAlignment = NSTextAlignmentCenter;
    _countryLabel.textColor = [UIColor blackColor];
    _countryLabel.font = [UIFont systemFontOfSize:19];
    _countryLabel.backgroundColor=[UIColor clearColor];
    _countryLabel.text = code.area;
    [self.view addSubview:_countryLabel];
    
    
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_arrow"]];
    CGRect frame = arrowView.frame;
    frame.origin.x = [CG s].W - 35;
    frame.origin.y = (BUTTON_HEIGHT - 18.0f) / 2;
    arrowView.frame = frame;
    [_countryLabel addSubview:arrowView];
    
    //prompt
    float finterval = 0.0f;
    if ([CG s].H > 480)
    {
        finterval = 10.0f;
    }
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0f,
                                                                     BUTTON_HEIGHT * 2 + 5.0f + finterval + addHeight,
                                                                     [CG s].W - 24.0f,40.0f)];
    promptLabel.text = MLocalizableString(@"enter_phone_number_tips",@"请确认你的国家或地区并输入手机号码");
    promptLabel.font = [UIFont systemFontOfSize:16];
    promptLabel.textColor = [UIColor lightGrayColor];
    promptLabel.adjustsFontSizeToFitWidth = YES;
    promptLabel.textAlignment = NSTextAlignmentLeft;
    promptLabel.numberOfLines = 0;
    CGSize size = [promptLabel.text compatibleSizeWithFont:promptLabel.font
                                         constrainedToSize:CGSizeMake(promptLabel.frame.size.width, MAXFLOAT)
                                             lineBreakMode:NSLineBreakByWordWrapping];
    frame = promptLabel.frame;
    frame.size.height = size.height;
    promptLabel.frame = frame;
    
    [self.view addSubview:promptLabel];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_phoneField becomeFirstResponder];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)rightNavBarButtonPressed
{
    static BOOL s_onClick = NO;
    if (s_onClick)
    {
        return;
    }
    
    s_onClick = YES;
    [_areaCodeField resignFirstResponder];
    [_phoneField resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        s_onClick = NO;
        if ([[ISOAreaCode instance] isValidCountryCode:_areaCodeField.text] == NO) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MLocalizableString(@"phone_number_error", @"手机号码错误")
                                                            message:MLocalizableString(@"country_code_invalid",@"国家码无效")
                                                           delegate:self
                                                  cancelButtonTitle:MLocalizableString(@"confirm", @"确定")
                                                  otherButtonTitles:nil];
            alert.tag = 0;
            [alert show];
            return;
        }
        
        NSString *phoneNumber = _phoneField.text;
        if ([phoneNumber length] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MLocalizableString(@"please_enter_phone_number", @"请输入手机号码")
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:MLocalizableString(@"confirm", @"确定")
                                                  otherButtonTitles:nil];
            alert.tag = 1;
            [alert show];
            return;
        }
        
        NSString *content;
        
        if ([NBPhoneNumber isValidNumber:_phoneField.text countryCodeString:_areaCodeField.text] == NO)
        {
            content = [NSString stringWithFormat:MLocalizableString(@"check_phone_number_invalid", @"手机号码有误：\n(%@) %@\n确认将验证码短信发送到这个手机号码？"), _areaCodeField.text, phoneNumber];
        }
        else
        {
            content = [NSString stringWithFormat:MLocalizableString(@"check_phone_number_valid", @"手机号码是否正确?\n(%@) %@\n我们将发送验证码短信到这个手机号码"), _areaCodeField.text, phoneNumber];
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MLocalizableString(@"confirm_phone_number", @"确认手机号码")
                                                        message:content
                                                       delegate:self
                                              cancelButtonTitle:MLocalizableString(@"edit", @"编辑")
                                              otherButtonTitles:MLocalizableString(@"confirm", @"确定"), nil];
        alert.tag = 2;
        [alert show];
    });
    
    return;
}

- (void)countryBtnClick
{
    ChooseAreaCodeViewController *select = [[ChooseAreaCodeViewController alloc] initWithCountryString:_countryLabel.text];
    select.delegate = self;
    [self pushViewController:select animatedStyle:AnimatedTransitionStyleCoverHorizontal animated:YES];

}

- (void)hideKeyBoardClick
{
    if (_phoneField && [_phoneField isFirstResponder] == YES)
    {
        [_phoneField resignFirstResponder];
    }
    else if (_areaCodeField && [_areaCodeField isFirstResponder] == YES)
    {
        [_areaCodeField resignFirstResponder];
    }
}


#pragma mark ----------------UITextFieldDelegate----------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _areaCodeField)
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        if (range.location > 4)
        {
            return NO;
        }
        else if(range.location < 1)
        {
            _countryLabel.text = MLocalizableString(@"country_code",@"国家码");
            return NO;
        }
        else
        {
            NSString *content = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString *strarea = [[ISOAreaCode instance] areaCode:content];
            if ([strarea isEqualToString:@""])
            {
                _countryLabel.text = MLocalizableString(@"country_code_invalid",@"国家码无效");
            }
            else
            {
                self.navigationItem.rightBarButtonItem.enabled = YES;
                _countryLabel.text = strarea;
            }
        }
        
        if(range.location == 1)
        {
            NSString *content = [textField.text stringByReplacingCharactersInRange:range withString:string];
            if([content isEqualToString:@"+"])
            {
                _countryLabel.text = MLocalizableString(@"country_code",@"国家码");
            }
        }
    }
    else if (textField == _phoneField)
    {
        NSString *content = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([content length] == 0)
        {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
        else
        {
            NSString *strarea = [[ISOAreaCode instance] areaCode:_areaCodeField.text];
            if ([strarea isEqualToString:@""])
            {
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            else
            {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            
        }
    }
    
    return YES;
}
#pragma mark ----------------UIAlertViewDelegate----------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0)
    {
        [_areaCodeField becomeFirstResponder];
    }
    else if (alertView.tag == 1)
    {
        [_phoneField becomeFirstResponder];
    }
    else
    {
        if (buttonIndex == 0)
        {
            [_phoneField becomeFirstResponder];
        }
        else
        {
            //请求验证码
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            FetchAuthCodeRequestMessage *message = [[FetchAuthCodeRequestMessage alloc] initWithCountryCode:_areaCodeField.text phoneNumber:_phoneField.text];
            [[NetworkManager instance] sendRequestMessage:message completion:^(ResponseMessage *response) {
               
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                //检查服务器返回内容是否有错误
                if ([response checkError:YES desiredClass:[FetchAuthCodeResponseMessage class]] == NO)
                {
                    FetchAuthCodeResponseMessage *responseMessage = (FetchAuthCodeResponseMessage *)response;
                    AreaCode *code = [[AreaCode alloc] initWithArea:_countryLabel.text code:_areaCodeField.text];
                    EnterAuthCodeViewController  *authCode = [[EnterAuthCodeViewController alloc] initWithFetchAuthCodeResponseMessage:responseMessage
                                                                                                                              areaCode:code
                                                                                                                           phoneNumber:_phoneField.text];
                    [self pushViewController:authCode animatedStyle:AnimatedTransitionStyleCoverHorizontal animated:YES];
                }
                
            }];
            
        }
    }
    
}

#pragma mark ----------------ChooseAreaCodeDelegate----------------
- (void) choosedAreaCode:(AreaCode *)areaCode
{
    _countryLabel.text = areaCode.area;
    _areaCodeField.text = areaCode.code;
}

@end
