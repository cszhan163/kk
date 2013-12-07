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
#import "SharePlatformCenter.h"
#import "DBManage.h"
#import "WeiXinShareMgr.h"
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
//static UIImage *sharedImage = nil;
- (void)setLastWidnows{
    sharedAlterView = [[UIShareActionAlertView alloc]initMoreAlertActionView:CGRectMake(0.f, 20.f, kDeviceScreenWidth, kDeviceScreenHeight) subViewStatus:NO];
    [self.window addSubview:sharedAlterView];
    sharedAlterView.delegate = self;
    sharedAlterView.hidden = YES;
    [sharedAlterView showAlertActionViewStatus:NO animated:NO];
    [ZCSNotficationMgr addObserver:self call:@selector(startShowSharedView:) msgName:kStartShowSharedViewMSG];
    [ZCSNotficationMgr addObserver:self call:@selector(endShowSharedView) msgName:kEndShowSharedViewMSG];
}

- (void)startShowSharedView:(NSNotification*)ntf{
    self.sharedImage = [ntf object];
    sharedAlterView.hidden = NO;
    [sharedAlterView showAlertActionViewStatus:YES animated:YES];
}
- (void)endShowSharedView{
    [sharedAlterView disMissAlertView:YES];
    self.sharedImage = nil;
}
- (void)didTouchItem:(UIButton*)sender{
    SharePlatformCenter *sharedCenter = [SharePlatformCenter defaultCenter];
    [sharedCenter setDelegate:self];
    /*
     type = K_PLATFORM_Sina;
     }else{
     type = K_PLATFORM_Tencent;
     */
    switch ([sender tag]) {
        case 0://威信{
        {
            NSString *urlStr = [NSString  stringWithFormat:@"%@://",@"weixin"];
               NSURL *appUrl  = [NSURL URLWithString:urlStr];
            if(![[UIApplication sharedApplication]canOpenURL:appUrl]){
                kUIAlertView(@"提示", @"请先安装微信");
            }
            UIImage *thumbImage = [self imageByScalingAndCroppingForSize:CGSizeMake(100,100*self.sharedImage.size.height/self.sharedImage.size.width) withSourceImage:self.sharedImage];
            [[WeiXinShareMgr getSingleTone]sendKokImageDataToWeiXin:self.sharedImage thumbData:thumbImage];
        }
            break;
        case 1://新浪
            if([sharedCenter modelDataWithType:K_PLATFORM_Sina]){
                
                [sharedCenter sendStatus:@"分享图片" ImageData:UIImagePNGRepresentation(self.sharedImage )];
            }
            else{
                kUIAlertView(@"提示", @"请到设置界面先绑定微博");
            }
            break;
        case 2://tencent
            if([sharedCenter modelDataWithType:K_PLATFORM_Tencent]){
                
                [sharedCenter sendStatus:@"分享图片" ImageData:UIImagePNGRepresentation(self.sharedImage)];
            }
            else{
                kUIAlertView(@"提示", @"请到设置界面先绑定微博");
            }
            break;
        default:
            break;
    }
}
- (void)didTouchFunItem:(id)sender withItem:(id)index{
    //self.sharedImage  = nil;
}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [[Container instance] launchAppWithDictionary:launchOptions isDebugMode:YES toViewController:nil AutoSetView:nil];
    [[WeiXinShareMgr getSingleTone]initAndRegister];
#if 1
    //[AppSetting setLoginUserId:@"kkzhan"];
    AppMainUIViewManage *appMg = [AppMainUIViewManage getSingleTone];
    appMg.window = self.window;
    [appMg addMainViewUI];
    
        //[self checkCarIsRunning:nil];
    [self setLastWidnows];
    //[NSTimer timerWithTimeInterval:5 invocation:@selector(checkCarIsRunning) repeats:YES];
    [ZCSNotficationMgr addObserver:self call:@selector(backDoorCheckOk:) msgName:kZCSNetWorkOK];
    [ZCSNotficationMgr addObserver:self call:@selector(checkCarIsRunning:) msgName:kCheckCardRecentRun];
    [ZCSNotficationMgr addObserver:self call:@selector(queryCarInfo:) msgName:kQueryCarInfoMSG];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kFetchMessageLen target:self selector:@selector(checkUnReadMessageList) userInfo:nil repeats:YES];
    [self.timer fire];
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
    
    NSString *usrId = [AppSetting getLoginUserId];
    NSString *cardId = [AppSetting getUserCarId:usrId];
    if(cardId && ![cardId isEqualToString:@""]){
        [self performSelector:@selector(didLoginOK:) withObject:nil  afterDelay:1.0];
    }
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
    //return;
    NSString *usrId = [AppSetting getLoginUserId];
    NSString *cardId = [AppSetting getUserCarId:usrId];
    if(cardId == nil||[cardId isEqualToString:@""]){
        [ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInt:kTabCountMax-1]];
    }
    CarServiceNetDataMgr *cardNetMgr = [CarServiceNetDataMgr getSingleTone];
    [cardNetMgr getRouterLatestData:cardId];
}
- (void)backDoorRequest{
    
    CarServiceNetDataMgr *cardNetMgr = [CarServiceNetDataMgr getSingleTone];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"value",@"key1",
                           nil];
    
    [cardNetMgr backDoorRequest:param];
    
    
}
- (void)checkUnReadMessageList{
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId == nil || [usrId isEqualToString:@""]){
        return;
    }
    CarServiceNetDataMgr *netMgr = [CarServiceNetDataMgr getSingleTone];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AppSetting getLoginUserId],@"userName",
                           nil];
    
    [netMgr getMessageList:param];
}
- (void)queryCarInfo:(NSNotification*)ntf{
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    NSString *useName = [AppSetting getLoginUserId];
    [cardShopMgr carInforQuery:useName];
}
- (void)backDoorCheckOk:(NSNotification*)ntf{
    static int i = 0;
    id obj = [ntf object];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kCarInfoQuery])
    {
        if([data objectForKey:@"vin"]){
            NSString *userId = [AppSetting getLoginUserId];
            [AppSetting setUserCarId:[data objectForKey:@"vin"] withUserId:userId];
        }
         [self didLoginOK:ntf];
    }
    if([resKey isEqualToString:kResMessageData]){
        NSArray *mesData = [data objectForKey:@"messageBox"];
        if([mesData count]>0){
            NSString *userId = [AppSetting getLoginUserId];
            NSMutableArray *histData = [NSMutableArray arrayWithArray:[[DBManage getSingletone]getMessageHistData:userId]];
            [histData addObject:mesData];
            [[DBManage  getSingletone] saveMessageHistData:histData withUserId:userId];
            self.mesCount = self.mesCount+[mesData count];
            [ZCSNotficationMgr postMSG:KNewMessageFromMSG obj:[NSString stringWithFormat:@"%d",self.mesCount]];
            
        }
       
        //if([mesData count]>0)
           
    }
    if([resKey isEqualToString:kNetLoginRes]){
    
       
    }
    
}
- (void)didLoginOK:(NSNotification*)ntf{
    self.mesCount = 0;
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId && ![usrId isEqualToString:@""]){
        NSArray *histData = [[DBManage getSingletone]getMessageHistData:usrId];
        for(NSDictionary *item in histData){
            if([item objectForKey:@"readTag"]){
                if([[item objectForKey:@"readTag"] intValue] == 0){
                    self.mesCount = self.mesCount +1;
                }
            }
        }
        [ZCSNotficationMgr postMSG:KNewMessageFromMSG obj:[NSString stringWithFormat:@"%d",self.mesCount]];
    }
}
-(BOOL)checkCarInforData{
    NSString *userId = [AppSetting getLoginUserId];
    NSString *cardId = nil;
    if(userId){
        cardId = [AppSetting getUserCarId:userId];
    }
    if(cardId == nil||[cardId isEqualToString:@""]){
        kUIAlertView(@"信息", kAlertCardBidTXT);
        [ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInt:kTabCountMax-1]];
        [ZCSNotficationMgr postMSG:kNeedCarBindMSG obj:nil];
        return NO;
    }
    return  YES;
}
-(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage*)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end
