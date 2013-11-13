//
//  untitled.m
//  MP3Player
//
//  Created by cszhan on 12-1-10.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppMainUIViewManage.h"
#import "UIFrameworkMSG.h"
#import "NTESMBMainMenuController.h"
#import "NETabNavBar.h"
#import "UIParamsCfg.h"
#import "ViewController.h"

#if 0
#import "DressWhatViewController.h"
#import "PhotoUploadViewController.h"
#import "MyProfileViewController.h"
#import "CMPopTipView.h"
#import "DBManage.h"
#endif

#import "UserSettingViewController.h"
#import "CarDriveStatusViewController.h"
#import "CarRouterViewController.h"
#import "CarServiceViewController.h"
#import "CarStatusViewController.h"

#define HAVE_WINDOWLAST
#define USER_LOGIN

#ifdef  USER_LOGIN
//#import "LoginAndResignMainViewController.h"
#import "CardShopLoginViewController.h"
#import "AppSetting.h"
#endif



@class GMusicPlayMgr;
#define kLoginViewControllerClass @"CardShopLoginViewController"
static NSString * TabMainClassArray[kTabCountMax] ={@"CarRouterDateViewController",@"CarMonitorViewController",@"CarStatusViewController",@"CarServiceViewController",@"UserSettingViewController"};

static AppMainUIViewManage *sharedObj = nil;
static NETabNavBar *currentTabBar = nil;
static NTESMBMainMenuController *mainVC = nil;
static UINavigationController *currentNavgationController = nil;
static UIButton *popup = nil;
@implementation AppMainUIViewManage
@synthesize isShouldHiddenTabBarWhenPush;
@synthesize window;


#if 1
-(void)addObserveMsg
{
	//[[GMusicPlayMgr getSingleTone] startRegisterBackGroundPlay];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNewViewControllerFromMsg:) name:kPushNewViewController object:nil];
    [ZCSNotficationMgr addObserver:self call:@selector(popAllViewControllerFromMsg:) msgName:kPopAllViewController];
    [ZCSNotficationMgr addObserver:self call:@selector(presentViewControllerFromMsg:) msgName:kPresentModelViewController];
    [ZCSNotficationMgr addObserver:self call:@selector(dismissViewControllerFromMsg:) msgName:kDisMissModelViewController]; 
    //addObserver:s forKeyPath:<#(NSString *)keyPath#> options:<#(NSKeyValueObservingOptions)options#> context:<#(void *)context#> ]
#ifdef  USER_LOGIN
    
	[ZCSNotficationMgr addObserver:self call:@selector(didUserLoginOkFromMsg:) msgName:kUserDidLoginOk];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserResignOkFromMsg:) msgName:kUserDidResignOK];
    [ZCSNotficationMgr addObserver:self call:@selector(popNewMSGNotify:) msgName:KNewMessageFromMSG];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserloginOutFromMsg:) msgName:
     kUserDidLogOut];
#endif
    /*
    [ZCSNotficationMgr addObserver:self call:@selector(didReceiveMemoryWarning:) msgName:kLowMemoryFromMSG];
    */
}
#endif
+(id)getSingleTone{
	@synchronized(self){
		if(sharedObj == nil){
			sharedObj = [[self alloc]init];
			[sharedObj addObserveMsg];
		}
		return sharedObj;
	}
}
-(void)addMainViewUI
{
	/*
	NSNotificationCenter *ntfCenter = [NSNotificationCenter defaultCenter];
	[ntfCenter addObserver:self selector:@selector(change name:@"" object:];
     
	 */
	//UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight)];
#if 0
    ViewController *test = [[ViewController alloc]init];
    [self.window addSubview:test.view];
    return;
#endif

	mainVC = [[NTESMBMainMenuController alloc]init];
    mainVC.delegate = self;
#if 1
	UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:mainVC];
    navCtrl.navigationBar.tintColor = [UIColor redColor];//[UIColor colorWithPatternImage:];
	navCtrl.navigationBarHidden = YES;
	currentNavgationController = navCtrl;
    
    [self.window addSubview:navCtrl.view];
   
    
	//navCtrl.delegate = self;
#else
	[self.window addSubview:mainVC.view];
#endif

#ifdef  USER_LOGIN
    
    NSString *loginUser = [AppSetting getCurrentLoginUser];
    NSString *loginUserId = [AppSetting getLoginUserId];
    /*
    NSDictionary *loginUserData = nil;
    
    if(loginUser)
    {
        loginUserData = [AppSetting getLoginUserInfo:loginUser];
    }
     ||loginUserData == nil||loginUserId== nil
    */
    if(loginUser == nil )
    {
        id loginMainVc = [[NSClassFromString(kLoginViewControllerClass) alloc]init];
        UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:loginMainVc];
        //navCtrl.navigationBar.tintColor = [UIColor redColor];//[UIColor colorWithPatternImage:];
        [loginMainVc release];
        navCtrl.navigationBarHidden = YES;
        //[ZCSNotficationMgr postMSG:kPresentModelViewController obj:navCtrl];
        [currentNavgationController presentModalViewController:navCtrl animated:NO];
        SafeAutoRelease(navCtrl);
        
    }
#endif
	//[mainView addSubview:navCtrl.view];
	
}
#pragma mark -
#pragma mark create tabBar viewcontrollers delegate
-(NSArray*)viewcontrollersForTabBarController:(NTESMBMainMenuController*)controller;
{

    //return 0;
    NSMutableArray *_navControllersArr = [NSMutableArray arrayWithCapacity:10];
    //[vcontroller1 setNavgationBarTitle:kPlayListVCTitle];
    
    for(int i =0;i<kTabCountMax;i++){
        NSString *classNameStr = TabMainClassArray[i];
        UIViewController *vcontroller1 = [[NSClassFromString(classNameStr)alloc]init];
        UINavigationController *navCtrl1 = [[UINavigationController alloc]initWithRootViewController:vcontroller1];
        
        navCtrl1.navigationBarHidden = YES;
        navCtrl1.view.backgroundColor = [UIColor whiteColor];
        //navCtrl1.delegate = self;
        navCtrl1.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
        [_navControllersArr addObject:navCtrl1];
        
        [vcontroller1 release];
        [navCtrl1 release];
    }
//#if 1
//    UIViewController *vcontroller1 = [[NSClassFromString(<#Class aClass#>)] alloc]init];
//    UINavigationController *navCtrl1 = [[UINavigationController alloc]initWithRootViewController:vcontroller1];
//    
//    navCtrl1.navigationBarHidden = YES;
//    //navCtrl1.delegate = self;
//    navCtrl1.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
//    [_navControllersArr addObject:navCtrl1];
//    
//    [vcontroller1 release];
//    [navCtrl1 release];
//#endif
//    UIViewController *vcontroller2 = [[PhotoUploadViewController alloc]init];
//    UINavigationController *navCtrl2 = [[UINavigationController alloc]initWithRootViewController:vcontroller2];
//    navCtrl2.navigationBarHidden = YES;
//    //navCtrl2.delegate = self;
//    navCtrl2.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
//    [_navControllersArr addObject:navCtrl2];
//    
//    [navCtrl2 release];
//    [vcontroller2 release];
//    
//    UIViewController *vcontroller3 = [[MyProfileViewController alloc]init];
//    UINavigationController *navCtrl3 = [[UINavigationController alloc]initWithRootViewController:vcontroller3];
//    navCtrl3.navigationBarHidden = YES;
//    //navCtrl2.delegate = self;
//    navCtrl3.view.frame = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight);
//    [_navControllersArr addObject:navCtrl3];
//    
//    [navCtrl3 release];
//    [vcontroller3 release];
    
    return _navControllersArr;
 
}
-(void)changeMainViewUI:(id)Vc
{
	
}
-(void)setCurrentTabBar:(NETabNavBar*)tabBar{
	currentTabBar = tabBar;
}
-(id)getCurrentTabBar{
	return currentTabBar;
}
-(void)pushNewViewController:(id)viewController{
	
	//UINavigationController
	if(isShouldHiddenTabBarWhenPush)
	{
		currentTabBar.hidden = YES;
	}
	if([viewController isKindOfClass:[UIViewController class]])
	{
		[[[self class] sharedAppNavigationController] pushViewController:viewController animated:YES];
		//[[[self class] sharedAppNavigationController] setDelegate:self];
	}

}
#ifdef USER_LOGIN
#pragma mark user login and resign
-(void)didUserLoginOkFromMsg:(NSNotification*)ntf
{
    [mainVC didSelectorTabItem:0];
    [self dismissViewControllerFromMsg:nil];
}
-(void)didUserResignOkFromMsg:(NSNotification*)ntf{
    [mainVC didSelectorTabItem:0];
   [self dismissViewControllerFromMsg:nil];
}
-(void)didUserloginOutFromMsg:(NSNotification*)ntf
{
    for(UINavigationController *item in [mainVC.mainTabBarVC navControllersArr])
    {
        [item popToRootViewControllerAnimated:YES];
    }
}
#endif  

-(void)popNewMSGNotify:(NSNotification*)ntf
{
#if 0
    CMPopTipView *popup = [[CMPopTipView alloc]initWithMessage:@"10"];
    popup.disableTapToDismiss  = YES;
    popup.hidden = NO;
#else
//    if(popup == nil)
//    {
//    
//        UIImage *bgImage = nil;
//        UIImageWithFileName(bgImage,@"icon-notice.png");
//        popup = [[UIButton alloc]initWithFrame:CGRectZero];
//        popup.titleLabel.adjustsFontSizeToFitWidth = YES;
//        popup.titleLabel.textColor = [UIColor whiteColor];
//        popup.titleEdgeInsets = UIEdgeInsetsMake(0.f,2.f,6.f,2.f);
//        popup.titleLabel.font = kAppTextBoldSystemFont(15);
//        //popup.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter;
//        [popup setBackgroundImage:bgImage forState:UIControlStateNormal];
//        UIButton *view = [currentTabBar.navBarArr objectAtIndex:2];
//        CGRect rect = CGRectMake(0.f, -10.f, bgImage.size.width/kScale,bgImage.size.height/kScale);
//        popup.frame = CGRectOffset(rect,33.f,-3);
//        [view addSubview:popup];
//        [popup release];
//    
//    }
//    NSString *num = [ntf object];
//    if([num intValue]>0)
//    {
//        [popup setTitle:num forState:UIControlStateNormal];
//         popup.hidden = NO;
//    }
//    else
//    {
//        popup.hidden = YES;
//    }
   
    /*
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, bgImage.size.width/kScale, bgImage.size.height/kScale)];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.adjustsFontSizeToFitWidth = YES;
    numLabel.textAlignment = UITextAlignmentCenter;
    numLabel.text = @"10000";
    numLabel.backgroundColor = [UIColor clearColor];
    [popup addSubview:numLabel];
    [numLabel release];
    */
  
    //popup.titleLabel.text = @"10000";
    //popup.backgroundColor = [UIColor redColor];
#endif
 
    
    /*
    [popup presentPointingAtView:view inView:currentTabBar animated:YES];
                      //viewinView: animated:NO]/
    */
}
-(void)memory
{

}
#pragma mark -
#pragma mark navgation

-(void)pushNewViewControllerFromMsg:(NSNotification*)ntfObj
{
	id obj = [ntfObj object];
	[self pushNewViewController:obj];
}
-(void)popAllViewControllerFromMsg:(NSNotification*)ntfObj
{
    id obj = [ntfObj object];
    if(obj == nil)
    {
        obj =[NSNumber numberWithBool:YES];
    }
    [currentNavgationController popToRootViewControllerAnimated:[obj boolValue]];
}
-(void)presentViewControllerFromMsg:(NSNotification*)ntfObj
{
    id obj = [ntfObj object];
    [currentNavgationController presentModalViewController:obj animated:YES];
}
-(void)dismissViewControllerFromMsg:(NSNotification*)ntfOjb
{
    BOOL animation = NO;
    if(ntfOjb)
    {
        if([ntfOjb isKindOfClass:[NSNumber class]])
        {
            animation = [ntfOjb boolValue];
        }
    }
    [currentNavgationController dismissModalViewControllerAnimated:animation];
}
+(UINavigationController*)sharedAppNavigationController{
	return currentNavgationController;
}
#pragma mark navigationBarHidden

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
#if 0
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if([viewController isKindOfClass:[PlayingMenuViewController class]])
	{
		if(isShouldHiddenTabBarWhenPush)
		{
			currentTabBar.hidden = YES; 
		}
	}
	else {
		currentTabBar.hidden = NO;
	}
	/*
	NSInteger count = [navigationController.viewControllers count];
	
	UIViewController *topVC = [navigationController.viewControllers objectAtIndex:count-1];
	NE_LOG(@"ssss:%@",[topVC description]);
	*/
	[viewController viewDidAppear:animated];
	[viewController viewDidAppear:animated];
}
#endif
@end
