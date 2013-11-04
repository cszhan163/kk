//
//  AppDelegate.m
//  BodCarManger
//
//  Created by cszhan on 13-9-16.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppMainUIViewManage.h"
#import "ViewController.h"
#import <iPlat4M_framework/iPlat4M_framework.h>
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [[Container instance] launchAppWithDictionary:launchOptions isDebugMode:YES toViewController:nil AutoSetView:nil];
    
#if 1
    AppMainUIViewManage *appMg = [AppMainUIViewManage getSingleTone];
   
    appMg.window = self.window;
    [appMg addMainViewUI];
    //[NSTimer timerWithTimeInterval:5 invocation:@selector(checkCarIsRunning) repeats:YES];
    
    //
    //[UIAlertViewMgr getSigleTone];
    
    //[ZCSDataArchiveMgr getSingleTone];
    //[DressMemoNetInterfaceMgr getSingleTone];
    //[ZCSNetClientErrorMgr getSingleTone];
    //[NTESMBLocalImageStorage getInstance];
    //ZCSNetClientDataMgr *clientMgr = [ZCSNetClientDataMgr getSingleTone];
    //[clientMgr startMemoImageTagDataSource];
    //[clientMgr startMemoDataUpload:nil];
#ifdef UI_APPEARANCE_SELECTOR
    if([UINavigationBar resolveClassMethod:@selector(appearanceWhenContainedIn:)])
    {
        [[UINavigationBar appearanceWhenContainedIn:[UIImagePickerController class], nil] setTintColor:[UIColor blackColor]];
    }
#endif
    
#endif
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self checkCarIsRunning:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)checkCarIsRunning:(id)sender{
    CarServiceNetDataMgr *cardNetMgr = [CarServiceNetDataMgr getSingleTone];
    [cardNetMgr getRouterLatestData:@"SHD05728"];
}
@end
