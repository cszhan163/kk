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
#define HAVE_WINDOWLAST
#ifdef  HAVE_WINDOWLAST
#import "UIShareActionAlertView.h"
#endif
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

#ifdef  HAVE_WINDOWLAST
UIShareActionAlertView *sharedAlterView = nil;
- (void)setLastWidnows{
    sharedAlterView = [[UIShareActionAlertView alloc]initMoreAlertActionView:CGRectMake(0.f, 20.f, kDeviceScreenWidth, kDeviceScreenHeight) subViewStatus:NO];
    [self.window addSubview:sharedAlterView];
    sharedAlterView.delegate = self;
    sharedAlterView.hidden = YES;
    [sharedAlterView showAlertActionViewStatus:NO animated:NO];
    [ZCSNotficationMgr addObserver:self call:@selector(startShowSharedView) msgName:kStartShowSharedViewMSG];
    [ZCSNotficationMgr addObserver:self call:@selector(endShowSharedView) msgName:kEndShowSharedViewMSG];
}

- (void)startShowSharedView{
    sharedAlterView.hidden = NO;
    [sharedAlterView showAlertActionViewStatus:YES animated:YES];
}
- (void)endShowSharedView{
    [sharedAlterView disMissAlertView:YES];
}
- (void)didTouchItem:(UIButton*)sender{
    switch ([sender tag]) {
        case 0://威信
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}
- (void)didTouchFunItem:(id)sender withItem:(id)sender{

}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [[Container instance] launchAppWithDictionary:launchOptions isDebugMode:YES toViewController:nil AutoSetView:nil];
    
#if 1
    [AppSetting setLoginUserId:@"kkzhan"];
    AppMainUIViewManage *appMg = [AppMainUIViewManage getSingleTone];
    appMg.window = self.window;
    [appMg addMainViewUI];
    [self checkCarIsRunning:nil];
    [self setLastWidnows];
    //[NSTimer timerWithTimeInterval:5 invocation:@selector(checkCarIsRunning) repeats:YES];
    [ZCSNotficationMgr addObserver:self call:@selector(backDoorCheckOk:) msgName:kZCSNetWorkOK];
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
    [self backDoorRequest];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)checkCarIsRunning:(id)sender{
    return;
    CarServiceNetDataMgr *cardNetMgr = [CarServiceNetDataMgr getSingleTone];
    [cardNetMgr getRouterLatestData:@"SHD05728"];
}
- (void)backDoorRequest{
    
    CarServiceNetDataMgr *cardNetMgr = [CarServiceNetDataMgr getSingleTone];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"value",@"key1",
                           nil];
    
    //[cardNetMgr backDoorRequest:param];
    
    
}

- (void)backDoorCheckOk:(NSNotification*)ntf{
    
}
@end
