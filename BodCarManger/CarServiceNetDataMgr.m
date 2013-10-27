//
//  DressMemoNetDataMgr.m
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarServiceNetDataMgr.h"
#import "ZCSNetClientNetInterfaceMgr.h"
#import "ZCSNetClientConfig.h"
#import "ZCSNetClient.h"
#import "AppSetting.h"
#import <iPlat4M_framework/iPlat4M_framework.h>
//#import "AppConfig_bak.h"
@interface CarServiceNetDataMgr()
@property(nonatomic,retain)NSMutableDictionary *requestResourceDict;
//@property(nonatomic,assign)BOOL isUserLogOut;
@end
static CarServiceNetDataMgr *sharedInstance = nil;
static ZCSNetClientNetInterfaceMgr *dressMemoInterfaceMgr = nil;
@implementation CarServiceNetDataMgr
@synthesize requestResourceDict;
+(id)getSingleTone{
    @synchronized(self)
    {
        if(sharedInstance == nil)
            sharedInstance = [[self alloc] init];
        
    }
    return sharedInstance;
}
-(id)init
{
    if(self = [super init])
    {
        dressMemoInterfaceMgr = [ZCSNetClientNetInterfaceMgr getSingleTone];
        NSDictionary *requestResouceMapDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                               
                                               @"login",        kNetLoginRes,
                                               @"register",             kNetResignRes,
                                               @"search_goods", @"getgoodslist",
                                               @"search_goodDetail",@"getGoodDetail",
                                               @"search_orders_old",@"search_orders_old",
                                               @"search_orders_month",@"search_orders_month",
                                               @"search_good_ad",@"getGoodAd",
                                               @"search_good_ad",@"getGoodMap",
                                               @"search_category",@"search_category",
                                               @"search_orders",@"search_orders",
                                               @"search_ordergoods",@"search_ordergoods",
                                               @"search_orderDetail",@"search_orderDetail",
                                               @"search_fav",@"search_fav",
                                               @"search_delivery",@"search_delivery",
                                               @"pay",@"pay",
                                               
                                               @"search_address",@"search_address",
                                               @"add_address",@"add_address",
                                               @"edit_address",@"edit_address",
                                               
                                               @"search_province",@"search_province",
                                               @"search_city",@"search_city",
                                               @"search_good_map",@"search_good_map",
                                               
                                               @"delete_order",@"delete_order",
                                               @"update",       @"update",
                                               @"getsms",       @"getsms",
                                               @"update_contacts",@"update_contacts",
                                               @"getsmsfindpassword",@"getsmsfindpassword",
                                               @"findpassword",@"findpassword",
                                               
                                               @"new_order",    @"new_order",
                                               @"search_ad",@"search_ad",
                                               @"search_good_ad",@"search_good_ad",
                                               @"search_good_map",@"search_good_map",
                                               @"update_userico",@"update_userico",
                                                   @"search_deliveryDetail",@"search_deliveryDetail",
                                               @"getDetailByDay",@"getDetailByDay",
                                               @"getInfoByMonth",@"getInfoByMonth",
                                               nil];
        dressMemoInterfaceMgr.requestResourceDict = requestResouceMapDict;
        
        dressMemoInterfaceMgr.netInterfaceDataSource = self;
        dressMemoInterfaceMgr.netInterfaceDelegate = self;
        //requestResourceDict = [[NSMutableDictionary alloc]init];
#if 0
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNet:) msgName:kZCSNetWorkOK];
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNetFailed:) msgName:kZCSNetWorkRequestFailed];
#endif
        //dbMgr = [DBManage getSingleTone];
    }
    return self;
}

#pragma mark login user data source
-(NSDictionary*)getUserLoginData
{
    
    //NSString *loginUser = [AppSetting getCurrentLoginUser];
    
    //[AppSetting setLoginUserInfo:data withUserKey:loginUserId];
    NSString *userName = @"";
    NSString *userPassword = @"";
    
#if 1
    NSString *loginUser = [AppSetting getLoginUserId];
    NSDictionary *loginData = [AppSetting getLoginUserInfo];                       
    userName = [loginData objectForKey:@"username"];
    userPassword = [loginData objectForKey:@"password"];
#else
    userName = @"13611694780";
    userPassword = @"111111";
#endif
    
    NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:
                              userName,@"username",
                              userPassword,@"password",
                              nil]; //[AppSetting getLoginUserInfo:loginUser];
   
    
    NSMutableDictionary * paramsDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              
                                              [userData objectForKey:@"username"],@"username",
                                              
                                              [userData objectForKey:@"password"],@"password",
                                                                                                                              
                                              nil];
    return paramsDictionary;
}
#pragma mark user login delegate
-(void)didLoginUser:(ZCSNetClient*)sender withLoginUserData:(NSDictionary*)data
{
    NSLog(@"%@",[data description]);
    NSDictionary *dataDict = [data objectForKey:@"data"];
    id userid = [dataDict objectForKey:@"username"];
    if([userid isKindOfClass:[NSNumber class]])
    {
        userid = [NSString stringWithFormat:@"%lld",[userid longLongValue]];
    }
    [AppSetting setLoginUserId:userid];
    NSString *loginUserId = [AppSetting getLoginUserId];
    [AppSetting setLoginUserInfo:[sender requestParam]];
    [AppSetting setLoginUserDetailInfo:dataDict userId:loginUserId];
    [ZCSNotficationMgr postMSG:kUserDidLoginOk obj:nil];

}
-(void)didServerRespond:(ZCSNetClient*)sender withErrorData:(NSDictionary*)data
{
    NSLog(@"%@",[data description]);
    id dataDict = [data objectForKey:@"data"];
    //id data = [dataDict objectForKey:@"data"];
    if([[dataDict objectForKey:@"code"]isEqualToString:@"-2"])//need to relogin
    {
        //[request reloadRequest];
        [dressMemoInterfaceMgr setLogin:NO];
        ZCSNetClient *newRequest = [self startAnRequestByResKey:sender.resourceKey needLogIn:YES withParam:sender.requestParam withMethod:sender.request.httpMethod withData:sender.isPostData];
        [ZCSNotficationMgr postMSG:kZCSNetWorkReloadRequest obj:newRequest];
        //[self startRequest:newRequest];
        return;
    }
    if(dataDict == nil)
    {
        kUIAlertView(@"提示",@"网络好像有问题,请检查网络");
    }
    else
    {
        id inforStr = [dataDict objectForKey:@"info"];
        if([inforStr isKindOfClass:[NSString class]])
        {
            kUIAlertView(@"提示",inforStr);
        }
    }
}
-(void)didRequestRespond:(ZCSNetClient*)sender withErrorData:(NSDictionary*)data
{
    kUIAlertView(@"提示",@"网络好像有问题,请检查网络");
}
#pragma mark -
#pragma mark
-(NSDictionary*)addUserIdParam:(NSDictionary*)param
{
    
   // return [NSDictionary dictionaryWithObject:@"13611694780" forKey:@"username"];
    
    
    NSMutableDictionary *newParam = [NSMutableDictionary dictionaryWithDictionary:param];
    NSString *loginUserId = [AppSetting getLoginUserId];
#if 0
    id userId = [[AppSetting getLoginUserInfo:loginUserId] objectForKey:@"user_id"];
    if([userId isKindOfClass:[NSNumber class]])
    {
        userId = [NSString stringWithFormat:@"%lld",[userId longLongValue]];
    }
    [newParam setValue:userId forKey:@"user_id"];
#else
    //userId = loginUserId;
    [newParam setValue:loginUserId forKey:@"username"];
#endif
    return newParam;
}
#pragma mark user login


-(id)userLogin:(NSDictionary*)param
{
    //param = [self getUserLoginData];
    return [dressMemoInterfaceMgr startAnRequestByResKey:kNetLoginRes
                                        needLogIn:NO
                                        withParam:param
                                       withMethod:@"POST"
                                         withData:NO];
    
}
-(id)userInfoUpdate:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"update"
                                        needLogIn:YES
                                        withParam:param
                                       withMethod:@"POST"
                                         withData:NO];
    
}
-(id)userResignRandomCode:(NSDictionary*)param
{
    
    [dressMemoInterfaceMgr startAnRequestByResKey:@"getsms"
                                        needLogIn:NO
                                        withParam:param
                                       withMethod:@"POST"
                                         withData:NO];
    
}
-(id)userResign:(NSDictionary*)param

{
    BOOL isHasData = NO;
    if([param objectForKey:@"avatar"])
    {
        
        isHasData  = YES;
        
    }
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"register"
                                        needLogIn:NO
                                        withParam:param
                                       withMethod:@"POST"
                                         withData:isHasData];
    
}
-(id)userFavProducts:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_fav"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
}
-(id)userResetPwdRadomCode:(NSDictionary*)param
{
    //search_category
    //param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getsmsfindpassword"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
}
-(id)userResetPassword:(NSDictionary*)param
{
    //search_category
    //param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"findpassword"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
}
/**
 接口名
 update_userico
 接口方式
 POST
 接口参数
 username
 head_icon
 */
-(id)userProfileIconUpdate:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"update_userico"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:YES];

}
/*
 *update_contacts	POST	username
 telnum[]	用户联系人信息更新
 */
-(id)uploadUserPhoneContactorsPhoneNumber:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"update_contacts"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
}
#pragma mark -
#pragma mark address
/**
 search_address	GET	username
 用户常用地址取得
 add_address	GET	username
 accept_name
 province
 city
 area
 address
 telphone
 mobile
 zip
 default	用户常用地址新增
 edit_address	GET	username
 id
 accept_name
 province
 city
 area
 address
 telphone
 mobile
 zip
 default 	用户常用地址修改
 */
-(id)getUserContactAddress:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_address"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)addUserContactAddress:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"add_address"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];


}
-(id)editUserContactAddress:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"edit_address"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];

}
/*
 *search_province	GET		省份信息查询
 search_city	GET	province_id	城市信息查询
 search_area	GET	city_id	区县信息查询
 province_id
 city_id
 */
-(id)getProvinceData:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_province"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getCityData:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_city"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getAreaData:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_area"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
#pragma mark -
#pragma mark ad
-(id)getHomePageAd:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_ad"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
/*
 search_good_ad
 */
-(id)getProductAd:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_good_ad"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}

-(id)getProductMap:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_good_map"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
    
}

#pragma mark -
#pragma mark 
-(id)getProductSiteMap:(NSDictionary*)param
{
//
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_good_map"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
#pragma mark -
#pragma mark goods
-(id)getProductsList:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getgoodslist"
                                        needLogIn:NO
                                        withParam:param
                                       withMethod:@"GET"
                                         withData:NO];
    
}
-(id)getProductsGroup:(NSDictionary*)param
{
    //search_category
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_category"
                                               needLogIn:NO
                                               withParam:nil
                                              withMethod:@"GET"
                                                withData:NO];
}
/*
 *
 search_goodDetail	GET
 search_good_ad	GET
 search_good_map	GET
 */
-(id)getProductDetail:(NSDictionary*)param
{
    //search_category
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getGoodDetail"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
    
}
-(id)getProductDetailAd:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getGoodAd"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

    
}
-(id)getProductDetailMap:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getGoodMap"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

    
}


#pragma mark -
#pragma mark my order
-(id)getProductOrderDetailGoodsList:(NSDictionary*)param
{
    //search_ordergoods
    //search_category
    //param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_ordergoods"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getProductOrderDetail:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orderDetail"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getProductsOrderList:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orders_old"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
}
-(id)getProductsOrderListOld:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orders_old"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];


}
-(id)getProductsOrderListNew:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orders_month"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
    
    
}

/**
 order_id
 */

-(id)cancelProductOrder:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"delete_order"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];

}
-(id)getOrderDelivery:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_delivery"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)newProductOrder:(NSDictionary*)param
{
//    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"new_order"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
}
/*
 order_id
 订单ID
 必须
 *search_deliveryDetail
 */
-(id)getOrderDeliveryDetail:(NSDictionary *)param
{

    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_deliveryDetail"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
}
#pragma mark -
#pragma mark pay
-(id)orderPay:(NSDictionary*)param
{

    return [dressMemoInterfaceMgr startAnRequestByResKey:@"pay"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];

}
#pragma mark -
#pragma mark user
- (id)carUserLogin:(NSDictionary *)param{
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:@"name" value:[param objectForKey:@"name"]];
    [inInfo set:@"password" value:[param objectForKey:@"password"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth"]; // 接口名
    [self startiPlant4MRequest:inInfo];
}
- (id)carUserRegister:(NSDictionary*)param{
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:@"name" value:[param objectForKey:@"name"]];
    [inInfo set:@"password" value:[param objectForKey:@"password"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth"]; // 接口名
    [self startiPlant4MRequest:inInfo];
}
#pragma mark -
#pragma mark rounter
- (id)getDetailByMonth:(NSDictionary*)param{
#if BAO_TEST
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getInfoByMonth"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
#else
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:@"month" value:[param objectForKey:@"month"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth"]; // 接口名
    [self startiPlant4MRequest:inInfo];
#endif
    
}
- (id)getDetailByDay:(NSDictionary*)param{
#if BAO_TEST
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getDetailByDay"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                            withData:NO];
#else
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:METHOD_TOKEN value:@"queryTripDay"]; // 接口名
    
    [inInfo set:@"year" value:[[NSNumber alloc] initWithInt:2013]]; // 设置参数
    [inInfo set:@"month" value:[[NSNumber alloc] initWithInt:10]];
    [inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [inInfo set:@"vin" value:@"SHD49232"];
    [self startiPlant4MRequest:inInfo];
#endif
}
- (id)getCarRouterRealTimeData:(NSString*)cardId{
    cardId = @"SHD05728";
    cardId = @"SHD49232";
    //SHD05728
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryTripNow"]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo];
}
- (id)getCarRouterLatestData{
    //queryLastTripID
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryLastTripID"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo];
}
#pragma mark -
#pragma mark service
- (id)checkCarStatus{
    //queryConData
    
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryConData"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo];
}

- (id)getMessageList:(NSDictionary*)param{
#if BAO_TEST
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getDetailByDay"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                            withData:NO];
#else
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryMessage"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    
    [self startiPlant4MRequest:inInfo];
#endif
}
#pragma mark -
#pragma mark drive model

- (id)getDriveDataByMoth:(NSString*)month withYear:(NSString*)year{
    //queryDriveMonthData
    year = @"2013";
    month = @"10";
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:@"queryMessage"]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    //[inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [self startiPlant4MRequest:inInfo];
}
#pragma mark -
#pragma mark iPlant4M common
- (EiInfo*)getCommIPlant4MParam{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    [inInfo set:SERVICE_TOKEN value:@"VESA01"]; // 由IF所在位置决定，需要文档
    return SafeAutoRelease(inInfo);
}
- (void)testiPlant4MInterface{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    [inInfo set:SERVICE_TOKEN value:@"VESA01"]; // 由IF所在位置决定，需要文档
#if 0
   
#else
    
#endif
    
}
- (void)startiPlant4MRequest:(EiInfo*)inInfo{
    
    [[Container instance].serviceAgent
     callServiceWithObject:self
     inInfo:inInfo
     target:self
     successCallBack:@selector(didQueryTripDaySuccess:)//回调函数
     failCallBack:@selector(didQueryTripDayFailed:)
     ]; // 失败时的回调
}
- (void)didQueryTripDaySuccess:(EiInfo*)info // 一般都必须有一个EiInfo参数
{
    if(info.status == 1){
    NSNumber *dayMilage = [info get:@"dayMilage"]; // 取出返回值，非block的类型
    NSNumber *dayFuel = [info get:@"dayFuel"];
    NSNumber *dayDrivinglong = [info get:@"dayDrivinglong"];
    EiBlock *tripInfo = [info getBlock:@"tripInfo"]; // block型返回值
    int rowCount = [tripInfo getRowCount];
    NSMutableDictionary *row = [tripInfo getRow:0]; // block有多个row，每个为一个NSMutableDictionary对象
    NSNumber *tripId = [row objectForKey:@"tripId"]; // 通过objectForKey取出
    }
}

- (void)didQueryTripDayFailed:(EiInfo*)info
{  
    NSLog(@"Failed");  
}
@end
