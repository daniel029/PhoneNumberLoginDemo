//
//  BaseViewController.h
//  iRun
//
//  Created by LiuYingbin on 16/10/14.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    AnimatedTransitionStyleNone = -1,
    AnimatedTransitionStyleCoverVertical = 0,
    AnimatedTransitionStyleFlipHorizontal,
    AnimatedTransitionStyleCrossDissolve,
    AnimatedTransitionStylePartialCurl,
    AnimatedTransitionStylePresentModal,
    AnimatedTransitionStyleCoverHorizontal,
    
} AnimatedTransitionStyle;

@interface BaseViewController : UIViewController
{
}

- (void)pushViewController:(BaseViewController *)viewController animatedStyle:(AnimatedTransitionStyle) animatedStyle animated:(BOOL)animated;

- (void)popViewController:(BOOL)animated;

- (void)popToRootViewController:(BOOL)animated;

- (void)setNavBarRightButtonTitle:(NSString *)title;

@end
