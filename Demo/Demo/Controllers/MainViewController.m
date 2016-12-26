//
//  MainViewController.m
//  Demo
//
//  Created by daniel on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"登录成功"];
    
    [self setNavBarRightButtonTitle:MLocalizableString(@"logout", @"登出")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightNavBarButtonPressed
{
    [self logout];
}

- (void)logout
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:MLocalizableString(@"confirm_logout", @"确认登出当前账号？") preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:MLocalizableString(@"logout", @"登出") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyLogout object:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:MLocalizableString(@"cancel", @"取消") style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
