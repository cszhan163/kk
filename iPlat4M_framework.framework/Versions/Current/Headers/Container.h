//
//  Container.h
//  iPlat4M_iPad
//
//  Created by  on 11-11-28.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Updater.h"
#import "EiServiceAgent.h"
#import "SqliteManager.h"
#import "UserSession.h"
#import "MBSConstants.h"
@class IPadIndexViewController;
@class IPhoneIndexViewController;
@class SqliteManager;
@class EiServiceAgent;
@class MBProgressHUD;
@interface Container : NSObject <UpdaterProtocol,UIAlertViewDelegate>
{
    EiServiceAgent * serviceAgent;
    SqliteManager * sqliteManager;
    UIViewController * viewController;
    NSString *updateURLString;
    NSString *mbsHttpURLString;
    NSString *mbsHttpsURLString;
    NSString *checkStatusURLString;

    Updater *updater;

}

@property (nonatomic,retain) EiServiceAgent * serviceAgent;
@property (nonatomic,retain) SqliteManager * sqliteManager;
@property (nonatomic,retain) UIViewController * viewController;
@property (nonatomic,retain) NSString *updateURLString;
@property (nonatomic,retain) NSString *mbsHttpURLString;
@property (nonatomic,retain) NSString *mbsHttpsURLString;
@property (nonatomic,retain) NSString *checkStatusURLString;
@property (nonatomic,retain) NSString *serviceURLString;
@property (nonatomic,retain) NSString *platformSourceAppID;
@property (nonatomic,retain) NSString *platformSourceAppName;




@property (nonatomic,retain) Updater *updater;
@property (nonatomic,retain) IPadIndexViewController *iPadIndexViewController;
@property (nonatomic,retain) IPhoneIndexViewController *iPhoneIndexViewController;
@property (nonatomic,retain) MBProgressHUD *HUD;

@property (nonatomic,retain) UIViewController *loadingViewController;

@property (nonatomic,retain) NSArray *attrArray;//传入参数的数组
@property (nonatomic,retain) NSMutableDictionary *attrDic;//传入参数的键值对

+(Container * ) instance;
//子应用启动 调试默认带有本地服务模式
- (BOOL) launchAppWithDictionary:(NSDictionary *)launchDict isDebugMode:(BOOL)isdebugmode 
                toViewController:(UIViewController *) targetViewController 
                     AutoSetView: (BOOL)willAutoSetView;
//子应用启动函数带本地服务参数
- (BOOL) launchAppWithDictionary:(NSDictionary *)launchDict isDebugMode:(BOOL)isdebugmode WithLocalService:(BOOL)isLocalService
                toViewController:(UIViewController *) targetViewController
                     AutoSetView: (BOOL)willAutoSetView;

//webservice返回状态
- (NSString *) getStatusStr:(NSInteger) status;
- (void)getDeviceAndOSInfo;
- (NSString *) platform;
- (NSString *)networkStatus;
- (BOOL) reloadServiceAddress;
- (BOOL) loadAttrFromParaArray:(NSArray *)arr;//传入参数解析
- (BOOL) loadAttrFromURL:(NSURL *)sourceURL;//由URL解析出参数 用于被其他应用打开时
- (void) changeServiceAddress:(NSString *)newAddress forKey:(NSString *)addressKey ;
- (BOOL) openAppByID:(NSString *)appID withDictionary:(NSDictionary *)appendAttrDict;//打开其他应用的方法
//读取页面
-(void) loadView:(NSString *)viewName  
      viewController:(UIViewController *) viewController 
      withParameters:(NSMutableDictionary *)parameters;

//调用framework(bundle)内资源
-(UIImage *)getImage:(NSString *)imageName FromBundle:(NSString *)bundleName ;
@end
