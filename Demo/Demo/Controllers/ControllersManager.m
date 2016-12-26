//
//  ControllersManager.m
//  iRun
//
//  Created by LiuYingbin on 12/25/16.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import "ControllersManager.h"

@interface ControllersManager( )
{
    NSMutableArray *_arrControllers;
}

@end

@implementation ControllersManager

+ (ControllersManager *)instance
{
    static dispatch_once_t onceToken;
    static ControllersManager *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[ControllersManager alloc] init];
    });
    
    return sSharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _arrControllers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addNavController:(UINavigationController *)controller
{
    [_arrControllers addObject:controller];
}

- (void)removeNavController:(UINavigationController *)controller
{
    [_arrControllers removeObject:controller];
}

- (void)pushViewController:(BaseViewController *)controller animated:(BOOL)animated
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [[self topViewController] presentViewController:nav animated:animated completion:nil];
    [_arrControllers addObject:nav];
}

- (void)popViewController:(BaseViewController *)controller animated:(BOOL)animated
{
    if ([controller.navigationController.viewControllers count] > 1)
    {
        [controller.navigationController popViewControllerAnimated:animated];
    }
    else
    {
        if (_arrControllers > 0 && [_arrControllers objectAtIndex:0] != controller.navigationController)
        {
            [controller.navigationController dismissViewControllerAnimated:animated completion:nil];
            [_arrControllers removeObject:controller.navigationController];
        }
    }
}

- (void)popToRootViewController:(BOOL)animated
{
    if ([_arrControllers count] == 0)
    {
        return;
    }
    
    for (int i = (int)[_arrControllers count] - 1; i >=0; --i)
    {
        UINavigationController *nav = [_arrControllers objectAtIndex:i];
        if (i == 0)
        {
            [nav popToRootViewControllerAnimated:animated];
        }
        else
        {
            [nav dismissViewControllerAnimated:animated completion:nil];
        }
    }
    
    UINavigationController *first = [_arrControllers firstObject];
    [_arrControllers removeAllObjects];
    [_arrControllers addObject:first];
}

- (BaseViewController *)topViewController
{
    if ([_arrControllers count] > 0)
    {
        return (BaseViewController *)[[_arrControllers lastObject] topViewController];
    }
    return nil;
}

- (BaseViewController *)rootViewController
{
    if ([_arrControllers count] > 0)
    {
        return (BaseViewController *)[[_arrControllers objectAtIndex:0] rootViewController];
    }
    return nil;
}

@end
