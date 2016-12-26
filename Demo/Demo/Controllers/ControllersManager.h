//
//  ControllersManager.h
//  iRun
//
//  Created by LiuYingbin on 12/25/16.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface ControllersManager : NSObject

+ (ControllersManager *)instance;
- (void)addNavController:(UINavigationController *)controller;
- (void)removeNavController:(UINavigationController *)controller;
- (void)pushViewController:(BaseViewController *)controller animated:(BOOL)animated;
- (void)popViewController:(BaseViewController *)controller animated:(BOOL)animated;
- (void)popToRootViewController:(BOOL)animated;

- (BaseViewController *)topViewController;
- (BaseViewController *)rootViewController;

@end
