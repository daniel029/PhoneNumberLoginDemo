//
//  UINavigationController+Category.m
//  iRun
//
//  Created by LiuYingbin on 16/10/14.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import "UINavigationController+Category.h"

@implementation UINavigationController (Category)

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

@end
