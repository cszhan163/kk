//
//  CardShopMainUIViewManage.m
//  CardShop
//
//  Created by cszhan on 12-8-31.
//  Copyright (c) 2012年 cszhan. All rights reserved.
//

#import "CardShopMainUIViewManage.h"
#import "UIScrollerMainViewController.h"
#import "CardShopPullDownMenuView.h"

#import "CardShopMainPageViewController.h"
#import "CardShopProductGroupViewController.h"
#import "CardShopProductBuyViewController.h"
#import "CardShopOrderViewController.h"
#import "CardShopUserViewController.h"
//#import "CardShopSettingViewController.h"
#import "UserSettingController.h"

#import "AppSetting.h"
#import "CardShopLoginViewController.h"

#define kPullDownMenuH  60.f/2.f
static UIScrollerMainViewController *mainScrollerVc = nil;
@implementation CardShopMainUIViewManage
+(UIScrollerMainViewController*)getMainScrollerViewController
{
    return mainScrollerVc;
}
+(id)getMainViewController
{
    return mainScrollerVc;
}
-(void)addObserveMsg
{
    [super addObserveMsg];
    [ZCSNotficationMgr addObserver:self call:@selector(checkUserLoginStatus) msgName:kScrollerViewWillAppear];
}
-(void)addMainViewUI
{

    mainScrollerVc = [[UIScrollerMainViewController alloc] init];
    mainScrollerVc.scrollerViewControllers = [self viewcontrollersForScrollerController:nil];
    //mainScrollerVc.view.frame = CGRectMake(0.f,-20.f,320.f,480.f);
    NE_LOGRECT(mainScrollerVc.view.frame);
    
#if 0
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:mainScrollerVc];
    navCtrl.navigationBar.tintColor = [UIColor redColor];//[UIColor colorWithPatternImage:];
    navCtrl.navigationBarHidden = YES;
    navCtrl.view.frame = CGRectMake(0.f,-20.f,320.f,480.f);

    NE_LOGRECT(navCtrl.view.frame);

	self.currentNavgationController = navCtrl;
#else
    //mainScrollerVc.view.backgroundColor = [UIColor ];
    UIViewController *navCtrl = mainScrollerVc;
#endif
    self.currentNavgationController = navCtrl;
    [self.window addSubview:navCtrl.view];
    [self checkUserLoginStatus];
    //navCtrl.view.frame = CGRectMake(0.f,-20.f,320.f,480.f);

    //navCtrl.navigationBarHidden = YES;
    //[self.window makeKeyAndVisible];
    //[mainScrollerVc release];
}
-(void)shouldAdjustViewFrame
{
    //mainScrollerVc.shouldAdjust = YES;
   mainScrollerVc.view.frame = CGRectMake(0.f,0.f,320.f,480.f);
}
#pragma mark -
#pragma mark create tabBar viewcontrollers delegate
-(NSArray*)viewcontrollersForScrollerController:(UIScrollerMainViewController*)controller
{
#if 1
    //return 0;
//    if([[UIScreen mainScreen] bounds].size.height== 568)
//    {
//#undef kDeviceScreenHeight
//#define kDeviceScreenHeight 568
//    }
//    else
//    {
//        
//    }
    NSMutableArray *_navControllersArr = [NSMutableArray arrayWithCapacity:10];
    
    UIViewController *vcontroller1 = [[CardShopMainPageViewController alloc]init];
    //[vcontroller1 setNavgationBarTitle:kPlayListVCTitle];
    
#if 1
    UINavigationController *navCtrl1 = [[UINavigationController alloc]initWithRootViewController:vcontroller1];
    
    navCtrl1.navigationBarHidden = YES;
    navCtrl1.delegate = self;
    navCtrl1.view.frame = CGRectMake(0.f,0.f, kDeviceScreenWidth, kDeviceScreenHeight);
    NE_LOGRECT(navCtrl1.view.frame);
    [_navControllersArr addObject:navCtrl1];
    
    [vcontroller1 release];
    
    [navCtrl1 release];
#endif
    UIViewController *vcontroller2 = [[CardShopProductGroupViewController alloc]init];
    UINavigationController *navCtrl2 = [[UINavigationController alloc]initWithRootViewController:vcontroller2];
    navCtrl2.navigationBarHidden = YES;
    navCtrl2.delegate = self;
    navCtrl2.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
    [_navControllersArr addObject:navCtrl2];
    
    [navCtrl2 release];
    [vcontroller2 release];
    
    UIViewController *vcontroller3 = [[CardShopProductBuyViewController alloc]init];
    UINavigationController *navCtrl3 = [[UINavigationController alloc]initWithRootViewController:vcontroller3];
    navCtrl3.navigationBarHidden = YES;
    navCtrl3.delegate = self;
    navCtrl3.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
    [_navControllersArr addObject:navCtrl3];
    
    [navCtrl3 release];
    [vcontroller3 release];
    
    
    UIViewController *vcontroller4 = [[CardShopOrderViewController alloc]init];
    UINavigationController *navCtrl4 = [[UINavigationController alloc]initWithRootViewController:vcontroller4];
    navCtrl4.navigationBarHidden = YES;
    navCtrl4.delegate = self;
    navCtrl4.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
    [_navControllersArr addObject:navCtrl4];
    
    [navCtrl4 release];
    [vcontroller4 release];
    
    //for user
    UIViewController *vcontroller5 = [[CardShopUserViewController alloc]init];
    UINavigationController *navCtrl5 = [[UINavigationController alloc]initWithRootViewController:vcontroller5];
    navCtrl5.navigationBarHidden = YES;
    //navCtrl2.delegate = self;
    navCtrl5.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
    [_navControllersArr addObject:navCtrl5];
    
    [navCtrl5 release];
    [vcontroller5 release];
    
    //for setting
    
    UIViewController *vcontroller6 = [[UserSettingController alloc]init];
    UINavigationController *navCtrl6 = [[UINavigationController alloc]initWithRootViewController:vcontroller6];
    navCtrl6.navigationBarHidden = YES;
    //navCtrl2.delegate = self;
    navCtrl6.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
    [_navControllersArr addObject:navCtrl6];
    
    [navCtrl6 release];
    [vcontroller6 release];
    
    
    
    return _navControllersArr;
#endif
    
}
-(void)checkUserLoginStatus
{
    //NSString *loginUser = [AppSetting getCurrentLoginUser];
    NSString *loginUserId = [AppSetting getLoginUserId];
    NSDictionary *loginUserData = nil;
    if(loginUserId)
    {
        loginUserData = [AppSetting getLoginUserInfo];
    }
    if(loginUserData == nil||loginUserId== nil)
    {
        CardShopLoginViewController *loginMainVc = [[CardShopLoginViewController alloc]initWithNibName:@"CardShopLoginViewController" bundle:nil];
        UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:loginMainVc];
        //navCtrl.navigationBar.tintColor = [UIColor redColor];//[UIColor colorWithPatternImage:];
        [loginMainVc release];
        navCtrl.navigationBarHidden = YES;
        navCtrl.view.frame = CGRectMake(0.f,-20.f,320.f,480.f);

        //[ZCSNotficationMgr postMSG:kPresentModelViewController obj:navCtrl];
        [self.currentNavgationController presentModalViewController:navCtrl animated:NO];
        //self.currentNavgationController.presentedViewController
        [navCtrl release];
        
    }
}
-(void)dismissViewControllerFromMsg:(NSNotification*)ntf
{
    BOOL animation = NO;
    id ntfOjb = [ntf object];
    if(ntfOjb)
    {
        if([ntfOjb isKindOfClass:[NSNumber class]])
        {
            animation = [ntfOjb boolValue];
        }
    }
    [self.currentNavgationController dismissModalViewControllerAnimated:animation];
    NE_LOGRECT(mainScrollerVc.view.frame);
    self.currentNavgationController.view.frame = CGRectMake(0.f,0.f,320.f,480.f);

}
-(void)viewWillApperar
{
    mainScrollerVc.view.frame = CGRectMake(0.f,-20.f,320.f,480.f);

}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([[navigationController viewControllers]count]==1)
    {
    
    }
    else
    {
    
    }
}

@end
