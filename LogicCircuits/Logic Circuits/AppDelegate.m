//
//  AppDelegate.m
//  Logic Circuits
//
//  Created by woodcol on 12-11-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "TridTableViewController.h"

#import "FourthViewController.h"
#import "AllViewFile.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2,*viewController3,*viewController4;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
       // [AllViewFile sharedAllFile].selectListName = @"54/74 TTL Logic IC";
        
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
      // [AllViewFile sharedAllFile].selectListName = @"40XX CMOS Logic IC";
        
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
        viewController3 = [[TridTableViewController alloc] initWithNibName:@"TridTableViewController_iPhone" bundle:nil];
        viewController4 = [[FourthViewController alloc] initWithNibName:@"FourthViewController_iPhone" bundle:nil];
    } else {
        
        
        
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];

        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
        viewController3 = [[TridTableViewController alloc] initWithNibName:@"TridTableViewController_iPad" bundle:nil];
        viewController4 = [[FourthViewController alloc] initWithNibName:@"FourthViewController_iPad" bundle:nil];
    }
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:viewController1];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:viewController2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:viewController4];
    nav1.interactivePopGestureRecognizer.enabled = NO;
    nav2.interactivePopGestureRecognizer.enabled = NO;
    nav3.interactivePopGestureRecognizer.enabled = NO;
    nav4.interactivePopGestureRecognizer.enabled = NO;

    
    self.tabBarController = [[UITabBarController alloc] init];
    //self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2,viewController3,viewController4,viewController5, nil];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil];    
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
