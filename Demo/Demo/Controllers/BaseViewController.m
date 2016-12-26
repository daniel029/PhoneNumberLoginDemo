//
//  BaseViewController.m
//  iRun
//
//  Created by LiuYingbin on 16/10/14.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import "BaseViewController.h"
#import "ControllersManager.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)pushViewController:(BaseViewController *)viewController animatedStyle:(AnimatedTransitionStyle) animatedStyle animated:(BOOL)animated
{
    switch(animatedStyle)
    {
        case AnimatedTransitionStyleCoverVertical:
        case AnimatedTransitionStyleFlipHorizontal:
        case AnimatedTransitionStyleCrossDissolve:
        case AnimatedTransitionStylePartialCurl:
        {
            viewController.modalTransitionStyle = (UIModalTransitionStyle)animatedStyle;
            [[ControllersManager instance] pushViewController:viewController animated:animated];
        }
            break;
        case AnimatedTransitionStyleCoverHorizontal:
        {
            [self.navigationController pushViewController:viewController animated:animated];
        }
            break;
        case AnimatedTransitionStyleNone:
        {
            [self.navigationController pushViewController:viewController animated:NO];
        }
            break;
        case AnimatedTransitionStylePresentModal:
        {
            [[ControllersManager instance] pushViewController:viewController animated:animated];
        }
            break;
        default:
        {
            DDLogWarn(@"pushViewController Error: 不支持的类型：%d", animatedStyle);
        }
            break;
    }

}

- (void)popViewController:(BOOL)animated
{
    [[ControllersManager instance] popViewController:self animated:animated];
}

- (void)popToRootViewController:(BOOL)animated
{
    [[ControllersManager instance] popToRootViewController:animated];
}

- (void)setNavBarRightButtonTitle:(NSString *)title
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(rightNavBarButtonPressed)];
}

- (void)rightNavBarButtonPressed
{
    
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
