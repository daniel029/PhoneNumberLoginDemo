//
//  AppDelegate.m
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "AppDelegate.h"
#import "PhoneNumberLoginViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    setenv("XcodeColors", "YES", 1);
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [[NetworkManager instance] startMonitorNetwork];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyLoginSuccess:) name:NotifyLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyLogout:) name:NotifyLogout object:nil];
    
    if ([[NetworkManager instance] isLogin])
    {
        [self enterMainViewController];
    }
    else
    {
        [self enterLoginViewController];
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)enterMainViewController
{
    MainViewController *main = [[MainViewController alloc] init];
    UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:main];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rootController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)enterLoginViewController
{
    UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:[[PhoneNumberLoginViewController alloc] init]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rootController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma -
#pragma Notification
- (void)onNotifyLoginSuccess:(NSNotification *)notify
{
    [self enterMainViewController];
}

- (void)onNotifyLogout:(NSNotification *)notify
{
    [self enterLoginViewController];
}

@end
