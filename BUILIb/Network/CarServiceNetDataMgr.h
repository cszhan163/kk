//
//  DressMemoNetDataMgr.h
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSNetClientDataMgr.h"

/**
 login and register
 */
#define  kUserDidLoginOk           @"userLoginOk"
#define  kUserDidResignOK           @"userDidResignOk"
#define  kUserDidLogOut             @"userLogOut"

#define kDidUserLoginOK             @"diduserLoginOk"


@protocol ZCSNetClientNetInterfaceMgrDataSource;
@protocol ZCSNetClientNetInterfaceMgrDelegate;
@interface CarServiceNetDataMgr : NSObject<ZCSNetClientNetInterfaceMgrDataSource,
ZCSNetClientNetInterfaceMgrDelegate>
/*user*/
+(id)getSingleTone;
/*router*/
- (id)getDetailByDay:(NSDictionary*)param;
- (id)getDetailByMonth:(NSDictionary*)param;

- (id)getRouterLatestData:(NSString*)cardId;
- (id)getRouterRealTimeData:(NSString*)cardId;
- (id)getRouterHistoryData:(NSString*)cardId withRouterId:(NSString*)routerId withStartTime:(NSString*)startTime;

- (id)getRouterDataByMonth:(NSString*)month withYear:(NSString*)year;
- (id)getRouterDataByDay:(NSString*)day withMoth:(NSString*)month withYear:(NSString*)year;
/*drive*/
- (id)getDriveDataByCarId:(NSString*)cardId withMonth:(NSString*)month withYear:(NSString*)year;
- (id)getDriveActionAnalysisDataByCarId:(NSString*)cardId withMoth:(NSString*)month withYear:(NSString*)year;
- (id)getDriveOilAnalysisDataByCarId:(NSString*)cardId withMoth:(NSString*)month withYear:(NSString*)year;
/*Service*/
- (id)getMessageList:(NSDictionary*)param;
@end
