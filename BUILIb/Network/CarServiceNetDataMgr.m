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
#import "ZCSNotficationMgr.h"
//#import "AppSetting.h"
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
                                               @"check",@"check",
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

#pragma mark -
#pragma mark user
- (id)carUserLogin:(NSDictionary *)param{
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA02"];
    [inInfo set:@"name" value:[param objectForKey:@"name"]];
    [inInfo set:@"password" value:[param objectForKey:@"password"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:kCarUserLogin]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(userLoginOk:) withFailed:@selector(userLoginFailed:)];
    return nil;
}
- (id)carUserRegister:(NSDictionary*)param{
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA02"];
    [inInfo set:@"name" value:[param objectForKey:@"name"]];
    [inInfo set:@"password" value:[param objectForKey:@"password"]];
    if([param objectForKey:@"phoneNumber"]){
        [inInfo set:@"phoneNumber" value:[param objectForKey:@"phoneNumber"]];
    }
    //queryTripCalanderMonth @"userRegister" 
    [inInfo set:METHOD_TOKEN value:kCarUserRegister]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(userRegisterOk:) withFailed:@selector(userRegisterFailed:)];
    return nil;
}
- (id)carUserPasswordUpdate:(NSDictionary*)param{
    //updateUserPhoneNumber
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA02"];
    [inInfo set:@"userName" value:[param objectForKey:@"name"]];
    [inInfo set:@"password" value:[param objectForKey:@"password"]];
//    if([param objectForKey:@"phoneNumber"]){
//        [inInfo set:@"phoneNumber" value:[param objectForKey:@"phoneNumber"]];
//    }
    //queryTripCalanderMonth @"userRegister"
    [inInfo set:METHOD_TOKEN value:kCarUserUpdatePass]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(userUserPasswordUpdateOk:) withFailed:@selector(userUserPasswordUpdateFailed:)];
    return nil;


}
- (id)carUserPhoneUpdate:(NSDictionary*)param{
    //updateUserPhoneNumber
    //updateUserPhoneNumber
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA02"];
    [inInfo set:@"userName" value:[param objectForKey:@"name"]];
    [inInfo set:@"phoneNumber" value:[param objectForKey:@"phoneNumber"]];
    //    if([param objectForKey:@"phoneNumber"]){
    //        [inInfo set:@"phoneNumber" value:[param objectForKey:@"phoneNumber"]];
    //    }
    //queryTripCalanderMonth @"userRegister"
    [inInfo set:METHOD_TOKEN value:kCarUserUpdatePhone]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(userPhoneUpdateOk:) withFailed:@selector(userPhoneUpdateFailed:)];
    return nil;
}
- (id)carUserLocationSet:(NSString*)userName withType:(NSString*)type {

    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA02"];
    [inInfo set:@"userName" value:userName];
    [inInfo set:@"type " value:type ];
    //    if([param objectForKey:@"phoneNumber"]){
    //        [inInfo set:@"phoneNumber" value:[param objectForKey:@"phoneNumber"]];
    //    }
    //queryTripCalanderMonth @"userRegister"
    [inInfo set:METHOD_TOKEN value:kCarUserLocation]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(userLocationSetOk:) withFailed:@selector(userLocationSetFailed:)];
    return nil;

}
- (id)backDoorRequest:(NSDictionary*)param{
    [dressMemoInterfaceMgr setRequestUrl:@"http://checkapp.sinaapp.com/api/index.php?command="];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"check" needLogIn:NO withParam:param withMethod:@"GET" withData:NO];
}
static BOOL isExit = NO;
- (void)didGetRawRespond:(ZCSNetClient*)sender withRawData:(NSData*)data{
    NSError *error = nil;
    isExit = NO;
    if([sender.resourceKey isEqualToString:@"check"]){
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *item = [[dataDict objectForKey:@"result"]objectAtIndex:0];
        NSString *status = [item objectForKey:@"userok"];
        NSString *msg = [item objectForKey:@"alarm"];
        if([status isEqualToString:@"0"]){
            isExit = YES;
             UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:@"警告" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil, nil]autorelease];[alertErr show];
            
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(isExit){
        exit(0);
    }
}

#pragma mark -
- (id)carInforQuery:(NSString*)username{
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA02"];
    [inInfo set:@"userName" value:username];
    //queryTripCalanderMonth @"userRegister"
    [inInfo set:METHOD_TOKEN value:kCarInfoQuery]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(carInforQueryOk:) withFailed:@selector(carInforQueryFailed:)];
    return nil;

}
- (id)carInforUpdate:(NSDictionary*)param withType:(int)type{
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA02"];
    [inInfo set:@"userName" value:[param objectForKey:@"userName"]];
    [inInfo set:@"brandy" value:[param objectForKey:@"brandy"]];
    [inInfo set:@"model" value:[param objectForKey:@"model"]];
    [inInfo set:@"NO" value:[param objectForKey:@"NO"]];
    [inInfo set:@"milage" value:[param objectForKey:@"milage"]];
    [inInfo set:@"lastMilage" value:[param objectForKey:@"lastMilage"]];
    [inInfo set:@"lastmaintainDate" value:[param objectForKey:@"lastmaintainDate"]];
    [inInfo set:@"OBD" value:[param objectForKey:@"OBD"]];
    //[inInfo set:@"type" value:[NSString stringWithFormat:@"%d",type]];
    [inInfo set:@"type" value:[param objectForKey:@"type"]];
    [inInfo set:@"insureExpDate" value:[param objectForKey:@"insureExpDate"]];
    //queryTripCalanderMonth @"userRegister"
    [inInfo set:METHOD_TOKEN value:kCarInfoUpdate]; // 接口名
    [self startiPlant4MRequest:inInfo withSuccess:@selector(carInforUpdateOk:) withFailed:@selector(carInforUpdateFailed:)];
    return nil;
    
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
    /*
    EiInfo *inInfo = [self getCommIPlant4MParam];
    [inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:@"month" value:[param objectForKey:@"month"]];
    //queryTripCalanderMonth
    [inInfo set:METHOD_TOKEN value:@"queryTripCalanderMonth"]; // 接口名
    [self startiPlant4MRequest:inInfo];
     */
    [self getRouterDataByMonth:[param objectForKey:@"month"] withYear:[param objectForKey:@"year"]];
    return nil;
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
    //[self getRouterDataByDay:@"" withMoth:@"" withYear:<#(NSString *)#>]
    return nil;
#endif
}

- (id)getRouterRealTimeData:(NSString*)cardId{
    //cardId = @"SHD05728";
    //cardId = @"SHD49232";
    //SHD05728
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VEMT02"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    //[inInfo set:SERVICE_TOKEN  value:@"VEMT02"]
    [inInfo set:METHOD_TOKEN value:kResRouterNow]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterRealTimeDataOk:) withFailed:@selector(getRouterRealTimeDataFaild:)];
    return nil;
}
- (id)getRouterLatestData:(NSString*)cardId{
    //queryLastTripID
    EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:kResRouterLatest]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterLatestDataOk:) withFailed:@selector(getRouterLatestDataFaild:)];
    return nil;
}
- (id)getRouterHistoryData:(NSString*)cardId withRouterId:(NSString*)routerId withStartTime:(NSString*)startTime {
    //queryTripHistory
#ifdef Router_Test
    cardId = @"SHD05728";
    routerId = @"1382912362";
    startTime = @"20131028072900";
#endif
   
    //		eiInfo.set("startTime", "20131028072900");
    
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VEMT02"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    //[inInfo set:SERVICE_TOKEN  value:@"VEMT02"]
    [inInfo set:METHOD_TOKEN value:kResRouterHistory]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [inInfo set:@"startTime" value:startTime];
    [inInfo set:@"tripID"  value:routerId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterHistoryDataOk:) withFailed:@selector(getRouterHistoryDataFailed:)];
    return nil;
}
- (id)getRouterDataByMonth:(NSString*)month withYear:(NSString*)year{
    //queryDriveMonthData
    
#ifdef Router_Test
    year = @"2013";
    month = @"10";
#endif
    NSString *carId = nil;
    carId = [AppSetting getUserCarId:nil];
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:kResRouterDataMoth]; // 接口名
    //[inInfo set:@"vin" value:cardId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    [inInfo set:@"vin" value:carId];
    //SHD05728
    //SHD49232
    //[inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterDataByMonthOk:) withFailed:@selector(getRouterDataByMonthFailed:)];
    return nil;
}
- (id)getRouterDataByDay:(NSString*)day withMoth:(NSString*)month withYear:(NSString*)year{
    
#ifdef Router_Test
    year = @"2013";
    month = @"10";
    day = @"11";
#endif
    NSString *carId = nil;
    carId = [AppSetting getUserCarId:nil];
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    [inInfo set:METHOD_TOKEN value:kResRouterDataDay]; // 接口名
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    [inInfo set:@"day" value:day];
    [inInfo set:@"vin" value:carId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getRouterDataByDayOk:) withFailed:@selector(getRouterDataByDayFailed:)];
    return nil;
}

#pragma mark -
#pragma mark drive model
//#define Drive_TEST
- (id)getDriveDataByCarId:(NSString*)cardId withMonth:(NSString*)month withYear:(NSString*)year{
    //queryDriveMonthData
#ifdef Drive_TEST
    year = @"2013";
    month = @"10";
    cardId = @"SHD05728";
#endif
    NSString *carId = nil;
    carId = [AppSetting getUserCarId:nil];
    
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:kResDriveDataMoth]; // 接口名
    [inInfo set:@"vin" value:carId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    //[inInfo set:@"day" value:[[NSNumber alloc] initWithInt:16]];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getDriveDataOk:) withFailed:@selector(getDriveDataFailed:)];
    return nil;
}
- (id)getDriveActionAnalysisDataByCarId:(NSString*)cardId withMoth:(NSString*)month withYear:(NSString*)year{
#ifdef Drive_TEST
    year = @"2013";
    month = @"10";
    cardId = @"SHD05728";
#endif
    NSString *carId = nil;
    carId = [AppSetting getUserCarId:nil];
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    [inInfo set:METHOD_TOKEN value:kResDriveActionAnalysis]; // 接口名
    
    [inInfo set:@"vin" value:carId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getDriveActionAnalysisDataOk:) withFailed:@selector(getDriveActionAnalysisDataFaild:)];
    return nil;
}
- (id)getDriveOilAnalysisDataByCarId:(NSString*)cardId withMoth:(NSString*)month withYear:(NSString*)year{
#ifdef Drive_TEST
    year = @"2013";
    month = @"10";
    cardId = @"SHD05728";
#endif
    NSString *carId = nil;
    carId = [AppSetting getUserCarId:nil];
    
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    [inInfo set:METHOD_TOKEN value:kResDriveOilAnalysis]; // 接口名
    [inInfo set:@"vin" value:carId];
    [inInfo set:@"year" value:year]; // 设置参数
    [inInfo set:@"month" value:month];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getDriveOilAnalysisDataOk:) withFailed:@selector(getDriveOilAnalysisDataFailed:)];
    return nil;

}
#pragma mark -
#pragma mark car status
- (void)getCarMaintainanceData:(NSString*)cardId{
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:kResDriveMaintainData]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getCarMaintainanceDataOk:) withFailed:@selector(getCarMaintainanceDataFailed:)];
}
- (id)getCarCheckData:(NSString*)cardId{
    //queryConData
    EiInfo *inInfo = [self getCommIPlant4MParamByServiceToken:@"VESA01"];
    //EiInfo *inInfo = [self getCommIPlant4MParam];
    //[inInfo set:@"year" value:[param objectForKey:@"year"]];
    [inInfo set:METHOD_TOKEN value:kResCarCheckData]; // 接口名
    [inInfo set:@"vin" value:cardId];
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getCarCheckDataOk:) withFailed:@selector(getCarCheckDataFailed:)];
    return nil;
}

#pragma mark -
#pragma mark service
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
    [self startiPlant4MRequest:inInfo withSuccess:@selector(getMessageListOk:) withFailed:@selector(getMessageListFailed:)];
    
#endif
}

#pragma mark -
#pragma mark iPlant4M common
- (EiInfo*)getCommIPlant4MParam{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    [inInfo set:SERVICE_TOKEN value:@"VESA01"]; // 由IF所在位置决定，需要文档
    return SafeAutoRelease(inInfo);
}
- (EiInfo*)getCommIPlant4MParamByServiceToken:(NSString*)token{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    if(token)
        [inInfo set:SERVICE_TOKEN value:token]; // 由IF所在位置决定，需要文档
    return SafeAutoRelease(inInfo);
}
- (void)sendFinalOkData:(id)data withKey:(NSString*)key{
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          data,@"data",
                          key,@"key",
                          nil];
    [ZCSNotficationMgr postMSG:kZCSNetWorkOK obj:item];
}
- (void)sendFinalFailedData:(id)data withKey:(NSString*)key{
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                         data,@"data",
                         key,@"key",
                         nil];
    [ZCSNotficationMgr postMSG:kZCSNetWorkRequestFailed obj:item];
}
- (void)testiPlant4MInterface{
    EiInfo *inInfo = [[EiInfo alloc] init];
    [inInfo set:PROJECT_TOKEN value:kBaoTApp]; // 固定
    [inInfo set:SERVICE_TOKEN value:@"VESA01"]; // 由IF所在位置决定，需要文档
#if 0
   
#else
    
#endif
    
}
- (void)startiPlant4MRequest:(EiInfo*)inInfo withSuccess:(SEL)sucCalFun withFailed:(SEL)failedCalFun{
    
    [[Container instance].serviceAgent
     callServiceWithObject:self
     inInfo:inInfo
     target:self
     successCallBack:sucCalFun//回调函数
     failCallBack:failedCalFun
     ]; // 失败时的回调
}
#pragma mark -
#pragma mark delegate user
- (void)userLoginOk:(EiInfo*)info{
    if(info.status == 1){
        //NSLog(@"%@",info.blocks);
        if([[info get:@"retType"]intValue] == 0){
            NSString *locationType = [info get:@"locateType"];
            NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
            [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
            [resultDict setValue:[info get:@"phoneNumber"] forKey:@"phoneNumber"];
            [resultDict setValue:[info get:@"points"] forKey:@"points"];
            if(![locationType isKindOfClass:[NSNull class]])
                [resultDict setValue:locationType forKey:@"locateType"];
            else
                [resultDict setValue:@"1" forKey:@"locateType"];
            [self sendFinalOkData:resultDict withKey:kNetLoginRes];
        }
        else{
            //kUIAlertView(<#y#>, <#x#>);
            NSMutableDictionary *errorDict = [NSMutableDictionary dictionary];
            [errorDict setValue:info.msg forKey:@"msg"];
            [self sendFinalFailedData:errorDict withKey:kNetLoginRes];
        }
    }
    else{
        NSMutableDictionary *errorDict = [NSMutableDictionary dictionary];
        [errorDict setValue:info.msg forKey:@"msg"];
        [self sendFinalFailedData:errorDict withKey:kNetLoginRes];
    }
}
- (void)userLoginFailed:(EiInfo*)info{
    
    [self sendFinalFailedData:@"" withKey:kCarUserLogin];

}
- (void)userRegisterOk:(EiInfo*)info{
    if(info.status == 1){
        //NSLog(@"%@",info.blocks);
        //phoneNumber;
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
        [resultDict setValue:[info get:@"phoneNumber"] forKey:@"phoneNumber"];
        [resultDict setValue:[info get:@"points"] forKey:@"points"];
        [resultDict setValue:[info get:@"versionCur"] forKey:@"versionCur"];
        [resultDict setValue:[info get:@"versionCur"] forKey:@"versionCur"];
        [resultDict setValue:[info get:@"url"] forKey:@"url"];
        [self sendFinalOkData:resultDict withKey:kCarUserRegister];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kCarUserRegister];
    }
    
}

- (void)userRegisterFailed:(EiInfo*)info{
   [self sendFinalFailedData:@"" withKey:kCarUserRegister]; 
}
- (void)carInforQueryOk:(EiInfo*)info{
    if(info.status == 1){
        /*
            "attr":{"insureExpDate":"20140225","milage":10020,"model":"福克斯2013手动经典版","lastMilage":8000,"vin":"SHDtst123","retType":1,"brandy":"福特","NO":"沪A12345","lastmaintainDate":"20130525","OBD":"nqtsyg2160132100391"},
            */
        //NSLog(@"%@",info.blocks);
        //phoneNumber;
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
        [resultDict setValue:[info get:@"milage"] forKey:@"milage"];
        [resultDict setValue:[info get:@"insureExpDate"] forKey:@"insureExpDate"];
        [resultDict setValue:[info get:@"model"] forKey:@"model"];
        [resultDict setValue:[info get:@"vin"] forKey:@"vin"];
        [resultDict setValue:[info get:@"brandy"] forKey:@"brandy"];
        [resultDict setValue:[info get:@"NO"] forKey:@"NO"];
        [resultDict setValue:[info get:@"lastmaintainDate"] forKey:@"lastmaintainDate"];
         [resultDict setValue:[info get:@"OBD"] forKey:@"OBD"];
        [resultDict setValue:[info get:@"lastMilage"] forKey:@"lastMilage"];
        [self sendFinalOkData:resultDict withKey:kCarInfoQuery];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kCarInfoQuery];
    }

}
- (void)carInforQueryFailed:(EiInfo*)info{
    [self sendFinalFailedData:@"" withKey:kCarInfoQuery];
}

- (void)carInforUpdateOk:(EiInfo*)info{
    if(info.status == 1){
        //NSLog(@"%@",info.blocks);
        //phoneNumber;
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
        [resultDict setValue:[info get:@"phoneNumber"] forKey:@"phoneNumber"];
        [resultDict setValue:[info get:@"points"] forKey:@"points"];
        [resultDict setValue:[info get:@"versionCur"] forKey:@"versionCur"];
        [resultDict setValue:[info get:@"versionCur"] forKey:@"versionCur"];
        [resultDict setValue:[info get:@"url"] forKey:@"url"];
        [self sendFinalOkData:resultDict withKey:kCarInfoUpdate];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kCarInfoUpdate];
    }
    
}
- (void)carInforUpdateFailed:(EiInfo*)info{
    [self sendFinalFailedData:@"" withKey:kCarInfoUpdate];
}
- (void)userUserPasswordUpdateOk:(EiInfo*)info{
    if(info.status == 1){
        //NSLog(@"%@",info.blocks);
        //phoneNumber;
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
        [self sendFinalOkData:resultDict withKey:kCarUserUpdatePass];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kCarUserUpdatePass];
    }
    
}
- (void)userUserPasswordUpdateFailed:(EiInfo*)info{

[self sendFinalFailedData:@"" withKey:kCarUserUpdatePass];
}
- (void)userPhoneUpdateOk:(EiInfo*)info{
    if(info.status == 1){
        //NSLog(@"%@",info.blocks);
        //phoneNumber;
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
        [self sendFinalOkData:resultDict withKey:kCarUserUpdatePhone];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kCarUserUpdatePhone];
    }
    
}
- (void)userPhoneUpdateFailed:(EiInfo*)info{
    
    [self sendFinalFailedData:@"" withKey:kCarUserUpdatePhone];
}

- (void)userLocationSetOk:(EiInfo*)info{
    if(info.status == 1){
        //NSLog(@"%@",info.blocks);
        //phoneNumber;
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
        [self sendFinalOkData:resultDict withKey:kCarUserLocation];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kCarUserLocation];
    }
    
}
- (void)userLocationSetFailed:(EiInfo*)info{
    
    [self sendFinalFailedData:@"" withKey:kCarUserUpdatePhone];
}
#pragma mark -
#pragma mark delegate router

- (void)getRouterRealTimeDataOk:(EiInfo*)info{
    if(info.status == 1){
        NSLog(@"%@",info.blocks);
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"tripMileage"] forKey:@"tripMileage"];
        [resultDict setValue:[info get:@"fuelWear"] forKey:@"fuelWear"];
        [resultDict setValue:[info get:@"safeScore"]  forKey:@"safeScore"];
        [resultDict setValue:[info get:@"economicScore"] forKey:@"economicScore"];
        EiBlock *tripInfo = [info getBlock:@"gps"]; // block型返回值
        
            [self sendFinalOkData:resultDict withKey:kResRouterNow];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kResRouterNow];
    }

}
- (void)getRouterRealTimeDataFailed:(EiInfo*)info{
    [self sendFinalFailedData:@"" withKey:kResRouterNow];

}
- (void)getRouterLatestDataOk:(EiInfo*)info{
    if(info.status == 1){
        //        tripCalanderDay
        //        {
        //            int          day;              //1~31
        //            int          status;           //1：行程无故障或报警
        //            //2：行程有故障或报警
        //        }
        NSLog(@"%@",info.blocks);
        //infor.blocks =
        /*
         [[item objectForKey:@"day"]intValue];
         flag = [item objectForKey:@"driveflg"];
         */
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        [resultDict setValue:[info get:@"tripID"] forKey:@"tripId"];
        [resultDict setValue:[info get:@"startTime"] forKey:@"startTime"];
        [resultDict setValue:[info get:@"endTime"] forKey:@"endTime"];
        [self sendFinalOkData:resultDict withKey:kResRouterLatest];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kResRouterLatest];
    }
}
- (void)getRouterLatestDataFailed:(EiInfo*)info{
    
    
}
- (void)getRouterHistoryDataOk:(EiInfo*)info{
    if(info.status == 1){
        //        tripCalanderDay
        //        {
        //            int          day;              //1~31
        //            int          status;           //1：行程无故障或报警
        //            //2：行程有故障或报警
        //        }
        NSLog(@"%@",info.blocks);
        //infor.blocks =
        /*
         [[item objectForKey:@"day"]intValue];
         flag = [item objectForKey:@"driveflg"];
         */
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        NSMutableArray *gpsArray = [NSMutableArray array];
        
        [resultDict setValue:[info get:@"tripMileage"] forKey:@"distance"];
        [resultDict setValue:[info get:@"fuelWear"] forKey:@"fuelWear"];
        [resultDict setValue:[info get:@"safeScore"]  forKey:@"safeScore"];
        [resultDict setValue:[info get:@"economicScore"] forKey:@"economicScore"];
        
        EiBlock *tripInfo = [info getBlock:@"gps"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        for(int i = 0;i<rowCount;i++){
            NSMutableDictionary *row = [tripInfo getRow:i]; // block有多个row，每个为一个NSMutableDictionary对象
            //NSNumber *tripId = [row objectForKey:@"tripId"]; // 通过objectForKey取出
            /*
             cell.mStartLabel.text = [NSString stringWithFormat:@"始: %@",[data objectForKey:@"startadr"]];
             cell.mEndLabel.text = [NSString stringWithFormat:@"终:%@",[data objectForKey:@"endadr"]];
             
             int oiltest = [[data objectForKey:@"oiltest"]intValue];
             if(oiltest>=11) oiltest = 11;
             int drivetest = [[data objectForKey:@"drivetest"]intValue];
             */
            //NSString *gprsInfo = [NSString stringWithFormat:@"%@,%@",[row objectForKey:@"lng"],[row objectForKey:@"lat"]];
            //NSString *endadr2 = [NSString stringWithFormat:@"%@,%@",[row objectForKey:@"endLon"],[row objectForKey:@"endLat"]];
            NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [row objectForKey:@"lng"],@"lng",
                                  [row objectForKey:@"lat"],@"lat",
                                  nil];
            [gpsArray addObject:item];

        }
        [resultDict setValue:gpsArray forKey:@"gps"];
        [self sendFinalOkData:resultDict withKey:kResRouterHistory];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kResRouterHistory];
    }
    
}
- (void)getRouterHistoryDataFailed:(EiInfo*)info{


}
- (void)getRouterDataByMonthOk:(EiInfo*)info{
    if(info.status == 1){
//        tripCalanderDay
//        {
//            int          day;              //1~31
//            int          status;           //1：行程无故障或报警
//            //2：行程有故障或报警
//        }
        NSLog(@"%@",info.blocks);
        //infor.blocks =
        /*
         [[item objectForKey:@"day"]intValue];
         flag = [item objectForKey:@"driveflg"];
             */
        NSMutableArray *data = [NSMutableArray array];
        EiBlock *tripInfo = [info getBlock:@"tripCalanderDay"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        for(int i = 0;i<rowCount;i++){
            NSMutableDictionary *row = [tripInfo getRow:i]; // block有多个row，每个为一个NSMutableDictionary对象
            //NSNumber *tripId = [row objectForKey:@"tripId"]; // 通过objectForKey取出
            NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [row objectForKey:@"day"],@"day",
                                  [row objectForKey:@"status"],@"driveflg",
                                  nil];
            [data addObject:item];
        }
        [self sendFinalOkData:data  withKey:kResRouterDataMoth];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kResRouterDataMoth];
    }
    
}
- (void)getRouterDataByMonthFailed:(EiInfo*)info{
    [self sendFinalFailedData:@"" withKey:kResRouterDataMoth];
    
}

- (void)getRouterDataByDayOk:(EiInfo*)info{
    if(info.status == 1){
        //        tripCalanderDay
        //        {
        //            int          day;              //1~31
        //            int          status;           //1：行程无故障或报警
        //            //2：行程有故障或报警
        //        int dayMilage;               //当天总里程
//        int dayAverageFuel;          //当天平均油耗
//        int dayFuel;                 //当天总油耗
//        int dayDrivinglong;          //当天总驾驶时长
//        block: tripInfo
        /*
        NSString *flag = [data objectForKey:@"driveflg"];
        int time = [[data objectForKey:@"time"]intValue];
        float distance = [[data objectForKey:@"distance"]floatValue];
        float oilvolume = [[data objectForKey:@"oil"]floatValue];
              */
        //        }
        NSLog(@"%@",info.blocks);
        //infor.blocks =
        /*
         [[item objectForKey:@"day"]intValue];
         flag = [item objectForKey:@"driveflg"];
         */
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        NSMutableArray *data = [NSMutableArray array];
        
        NSNumber *dayMilage = [info get:@"dayMilage"]; // 取出返回值，非block的类型
        NSNumber *dayFuel = [info get:@"dayFuel"];
        NSNumber *dayDrivinglong = [info get:@"dayDrivinglong"];
        
        [resultDict setValue:dayMilage forKey:@"dayMil"];
        [resultDict setValue:dayFuel forKey:@"dayFuel"];
        [resultDict setValue:dayDrivinglong forKey:@"dayDrive"];
        [resultDict setValue:[info get:@"dayAverageSpeed"] forKey:@"daySpeed"];
        
        EiBlock *tripInfo = [info getBlock:@"tripInfo"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        for(int i = 0;i<rowCount;i++){
            NSMutableDictionary *row = [tripInfo getRow:i]; // block有多个row，每个为一个NSMutableDictionary对象
            //NSNumber *tripId = [row objectForKey:@"tripId"]; // 通过objectForKey取出
            /*
             cell.mStartLabel.text = [NSString stringWithFormat:@"始: %@",[data objectForKey:@"startadr"]];
             cell.mEndLabel.text = [NSString stringWithFormat:@"终:%@",[data objectForKey:@"endadr"]];
             
             int oiltest = [[data objectForKey:@"oiltest"]intValue];
             if(oiltest>=11) oiltest = 11;
             int drivetest = [[data objectForKey:@"drivetest"]intValue];
                    */
            NSString *startadr2 = [NSString stringWithFormat:@"%@,%@",[row objectForKey:@"startLon"],[row objectForKey:@"startLat"]];
            NSString *endadr2 = [NSString stringWithFormat:@"%@,%@",[row objectForKey:@"endLon"],[row objectForKey:@"endLat"]];
            NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [row objectForKey:@"tripMileage"],@"distance",
                                  [row objectForKey:@"status"],@"driveflg",
                                  [row objectForKey:@"drivingLong"],@"drivingLong",
                                  [row objectForKey:@"startTime"],@"startTime",
                                  [row objectForKey:@"endTime"],@"endTime",
                                   startadr2,@"startadr2",
                                   endadr2,@"endadr2",
                                  [row objectForKey:@"fuelWear"],@"oil",
                                  [row objectForKey:@"tripId"],@"tripId",
                                  [row objectForKey:@"economicScore"],@"economicScore",
                                  [row objectForKey:@"safeScore"],@"safeScore",
                                  nil];
            [data addObject:item];
        }
        [resultDict setValue:data forKey:@"data"];
        [self sendFinalOkData:resultDict  withKey:kResRouterDataDay];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kResRouterDataDay];
    }

}
- (void)getRouterDataByDayFailed:(EiInfo*)info{
    [self sendFinalFailedData:@"" withKey:kResRouterDataDay];
}
#pragma mark -
#pragma mark drive delegate
- (void)getDriveDataOk:(EiInfo*)info{
    /*
     totalMilage":247.6959991455078,"safeScore":6,"segments":34,"days":11,"economicScore":6,"toatalFuel":99.19999694824219}
     */
    
    if(info.status == 1){
       
        NSLog(@"%@",info.blocks);
       
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        NSMutableArray *data = [NSMutableArray array];
        
        
        [resultDict setValue:[info get:@"totalMilage"] forKey:@"totalMilage"];
        [resultDict setValue:[info get:@"safeScore"] forKey:@"safeScore"];
        [resultDict setValue:[info get:@"days"] forKey:@"days"];
        [resultDict setValue:[info get:@"economicScore"] forKey:@"economicScore"];
        [resultDict setValue:[info get:@"toatalFuel"] forKey:@"toatalFuel"];
        [resultDict setValue:[info get:@"segments"] forKey:@"segments"];
        [self sendFinalOkData:resultDict withKey:kResDriveDataMoth];
    }
    else{
        
        [self sendFinalFailedData:@"" withKey:kResDriveDataMoth];
    }
    
}
- (void)getDriveDataFailed:(EiInfo*)info{

  [self sendFinalFailedData:@"" withKey:kResDriveDataMoth];
}
- (void)getDriveActionAnalysisDataOk:(EiInfo*)info{
    if(info.status == 1){
        /*
         {"overSpeedRate":0,"breakRate":0,"accRate":0},"blocks":{"safeData":{"meta":{"columns":[{"pos":0,"name":"day","descName":" "},{"pos":1,"name":"accCount","descName":" ","type":"N"},{"pos":2,"name":"breakCount","descName":" ","type":"N"},{"pos":3,"name":"overSpeedCount","descName":" ","type":"N"}]},"rows":
             */
        NSLog(@"%@",info.blocks);
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        NSMutableArray *data = [NSMutableArray array];
        
        [resultDict setValue:[info get:@"overSpeedRate"] forKey:@"overSpeedRate"];
        [resultDict setValue:[info get:@"breakRate"] forKey:@"breakRate"];
        [resultDict setValue:[info get:@"accRate"] forKey:@"accRate"];
        
        EiBlock *tripInfo = [info getBlock:@"safeData"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        for(int i = 0;i<rowCount;i++){
            NSMutableDictionary *row = [tripInfo getRow:i];
            NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [row objectForKey:@"accCount"],@"accCount",
                                  [row objectForKey:@"day"],@"day",
                                  //[row objectForKey:@"drivingLong"],@"drivingLong",
                                  [row objectForKey:@"breakCount"],@"breakCount",
                                  [row objectForKey:@"overSpeedCount"],@"overSpeedCount",
                                  nil];
            [data addObject:item];
        }
        [resultDict setValue:data forKey:@"safeData"];
        [self sendFinalOkData:resultDict withKey:kResDriveActionAnalysis];
    }
    else{
        [self sendFinalFailedData:@"" withKey:kResDriveActionAnalysis];
    }
}
- (void)getDriveActionAnalysisDataFaild:(EiInfo*)info{

    [self sendFinalFailedData:@"" withKey:kResDriveActionAnalysis];
    
}
- (void)getDriveOilAnalysisDataOk:(EiInfo*)info{
    if(info.status == 1){
        /*
         {"msg":"","msgKey":"","detailMsg":"","status":1,"attr":{"breakRate":0,"highRPMRate":0,"accRate":0},"blocks":{"economicData":{"meta":{"columns":[{"pos":0,"name":"day","descName":" "},{"pos":1,"name":"accCount","descName":" ","type":"N"},{"pos":2,"name":"breakCount","descName":" ","type":"N"},{"pos":3,"name":"overSpeedCount","descName":" ","type":"N"}]},"rows":[["9","0","0",null],["8","0","0",null],["13","0","0",null],["7","0","0",null],["28","0","0",null],["12","0","0",null],["11","0","0",null],["16","0","0",null],["10","0","0",null],["15","0","0",null],["14","0","0",null]]}}}
                */
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        NSMutableArray *data = [NSMutableArray array];
        
        [resultDict setValue:[info get:@"breakRate"] forKey:@"breakRate"];
        [resultDict setValue:[info get:@"highRPMRate"] forKey:@"highRPMRate"];
        [resultDict setValue:[info get:@"accRate"] forKey:@"accRate"];
        //[resultDict setValue:[info get:@"conclusion"] forKey:@"conclusion"];
        EiBlock *tripInfo = [info getBlock:@"economicData"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        for(int i = 0;i<rowCount;i++){
            NSMutableDictionary *row = [tripInfo getRow:i];
            NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [row objectForKey:@"accCount"],@"accCount",
                                  [row objectForKey:@"day"],@"day",
                                  [row objectForKey:@"breakCount"],@"breakCount",
                                  [row objectForKey:@"highRPMCount"],@"highRPMCount",
                                  nil];
            [data addObject:item];
        }
        [resultDict setValue:data forKey:@"economicData"];
        [self sendFinalOkData:resultDict withKey:kResDriveOilAnalysis];
    }
    else{
        [self sendFinalFailedData:@"" withKey:kResDriveOilAnalysis];
    }
}
- (void)getDriveOilAnalysisDataFailed:(EiInfo*)info{
    [self sendFinalFailedData:@"" withKey:kResDriveOilAnalysis];
}
- (void)getCarMaintainanceDataOk:(EiInfo*)info{
    if(info.status == 1){
        /*
         "milage":248.5290069580078,"days":37,"timeSpan":12,"milageSpan":10000}
         */
        NSLog(@"%@",info.blocks);
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        NSMutableArray *data = [NSMutableArray array];
        [resultDict setValue:[info get:@"milage"] forKey:@"milage"];
        [resultDict setValue:[info get:@"days"] forKey:@"days"];
        [resultDict setValue:[info get:@"milageSpan"] forKey:@"milageSpan"];
        [resultDict setValue:[info get:@"timeSpan"] forKey:@"timeSpan"];
        [self sendFinalOkData:resultDict withKey:kResDriveMaintainData];
    }
    else{
        [self sendFinalFailedData:@"" withKey:kResDriveMaintainData];
    }
    
}
- (void)getCarMaintainanceDataFailed:(EiInfo*)info{
   
    [self sendFinalFailedData:@"" withKey:kResDriveMaintainData];
    
}
#pragma mark -
#pragma mark service delegate
- (void)getCarCheckDataOk:(EiInfo*)info{
    
    if(info.status == 1){
        /*
         "{"time":"1383533806","state":"1","conclusion":"检测情况良好","RPM":"800","temper":"78"},"blocks":{"conData":{"meta":{"columns":[{"pos":0,"name":"name","descName":" "},{"pos":1,"name":"ran
         */
        NSLog(@"%@",info.blocks);
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        NSMutableArray *data = [NSMutableArray array];
        [resultDict setValue:[info get:@"RPM"] forKey:@"RPM"];
        [resultDict setValue:[info get:@"temper"] forKey:@"temper"];
        [resultDict setValue:[info get:@"conclusion"] forKey:@"conclusion"];
        [resultDict setValue:[info get:@"time"] forKey:@"time"];
        [resultDict setValue:[info get:@"level"] forKey:@"level"];
        EiBlock *tripInfo = [info getBlock:@"conData"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        for(int i = 0;i<rowCount;i++){
            NSMutableDictionary *row = [tripInfo getRow:i];
            NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [row objectForKey:@"name"],@"name",
                                  [row objectForKey:@"range"],@"range",
                                  [row objectForKey:@"value"],@"value",
                                  nil];
            [data addObject:item];
        }
        [resultDict setValue:data forKey:@"conData"];
        [self sendFinalOkData:resultDict withKey:kResCarCheckData];
    }
    else{
        [self sendFinalFailedData:@"" withKey:kResCarCheckData];
    }
}
- (void)getCarCheckDataFailed:(EiInfo*)info{
    
}

#pragma mark -
#pragma mark card status delegate

- (void)getMessageListOk:(EiInfo*)info{
    
}
- (void)getMessageListFailed:(EiInfo*)info{
    
}


- (void)didQueryTripDaySuccess:(EiInfo*)info // 一般都必须有一个EiInfo参数
{
    if([info.name isEqualToString:@"queryDriveMonthData"]){
        NSLog(@"%@",info.name);
    }
    if(info.status == 1){
        NSNumber *dayMilage = [info get:@"dayMilage"]; // 取出返回值，非block的类型
        NSNumber *dayFuel = [info get:@"dayFuel"];
        NSNumber *dayDrivinglong = [info get:@"dayDrivinglong"];
        
        EiBlock *tripInfo = [info getBlock:@"tripInfo"]; // block型返回值
        int rowCount = [tripInfo getRowCount];
        NSMutableDictionary *row = [tripInfo getRow:0]; // block有多个row，每个为一个NSMutableDictionary对象
        NSNumber *tripId = [row objectForKey:@"tripId"]; // 通过objectForKey取出
    }
    else{
    
    }
}

- (void)didQueryTripDayFailed:(EiInfo*)info
{  
    NSLog(@"Failed");  
}
@end
