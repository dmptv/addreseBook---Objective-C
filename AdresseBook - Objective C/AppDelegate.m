//
//  AppDelegate.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "AppDelegate.h"
#import "Utils.h"

#import "MainNavigationController.h"
#import "LoginController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:frame];
    [self.window makeKeyAndVisible];
        
    self.window.rootViewController =  [[MainNavigationController alloc] init];
    
    // nav bar
    [UINavigationBar appearance].barTintColor = RGBA(0, 137, 149, 255);
    
    // back bar button
    [UINavigationBar appearance].barStyle = UIBarStyleDefault;
    [UINavigationBar appearance].tintColor = RGBA(91, 14, 13, 255);
    
    // nav title
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : RGBA(91, 14, 13, 255)};
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
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


@end
