//
//  AppDelegate.m
//  GraphicsTest
//
//  Created by yiyaowang on 15/10/20.
//  Copyright © 2015年 zengyao. All rights reserved.
//

#import "AppDelegate.h"
#import "PageViewController.h"
#import "RootViewController.h"
#import "SpecialPageViewController.h"
#import "GraphicViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 版本号在info.plist中的key值
    NSString* key = (NSString*)kCFBundleVersionKey;
    NSLog(@"key: %@",key);
    
    // 从info.plist中取出当前版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"version: %@",version);
    
    // 从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSLog(@"saveVersion: %@",saveVersion);
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if (saveVersion) {
        RootViewController* rootVC = [[RootViewController alloc]init];
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:rootVC];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
        
        
    }else{
        
        /**
         * 一般启动页
         */
        if (/* DISABLES CODE */ (1)) {
            PageViewController* pageVC = [[PageViewController alloc]init];
            UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:pageVC];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            
        }else{
            //动画启动页
            SpecialPageViewController* specialVC = [[SpecialPageViewController alloc]init];
            UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:specialVC];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            
        }
        
    }
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
