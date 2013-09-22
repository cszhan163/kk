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
@interface CardShopNetDataMgr : NSObject<ZCSNetClientNetInterfaceMgrDataSource,
ZCSNetClientNetInterfaceMgrDelegate>
/*user*/
+(id)getSingleTone;
-(id)userLogin:(NSDictionary*)param;
-(id)userResign:(NSDictionary*)param;
-(id)userInfoUpdate:(NSDictionary*)param;
-(id)userResignRandomCode:(NSDictionary*)param;
-(id)userFavProducts:(NSDictionary*)param;
-(id)userResetPwdRadomCode:(NSDictionary*)param;
-(id)userResetPassword:(NSDictionary*)param;
-(id)userProfileIconUpdate:(NSDictionary*)param;
-(id)uploadUserPhoneContactorsPhoneNumber:(NSDictionary*)param;
/*good*/
-(id)getProductDetail:(NSDictionary*)param;
-(id)getProductDetailAd:(NSDictionary*)param;
-(id)getProductDetailMap:(NSDictionary*)param;
/*address*/
-(id)getUserContactAddress:(NSDictionary*)param;
-(id)addUserContactAddress:(NSDictionary*)param;
-(id)editUserContactAddress:(NSDictionary*)param;
-(id)getProvinceData:(NSDictionary*)param;
-(id)getCityData:(NSDictionary*)param;
-(id)getAreaData:(NSDictionary*)param;
/*order*/
-(id)getProductOrderDetailGoodsList:(NSDictionary*)param;
-(id)getProductOrderDetail:(NSDictionary*)param;
-(id)getProductsGroup:(NSDictionary*)param;
-(id)cancelProductOrder:(NSDictionary*)param;
-(id)getOrderDelivery:(NSDictionary*)param;
-(id)newProductOrder:(NSDictionary*)param;
-(id)getOrderDeliveryDetail:(NSDictionary *)param;

/*ad*/
-(id)getHomePageAd:(NSDictionary*)param;
-(id)getProductAd:(NSDictionary*)param;
-(id)getProductMap:(NSDictionary*)param;

/*router*/
- (id)getDetailByDay:(NSDictionary*)param;
- (id)getDetailByMonth:(NSDictionary*)param;
@end
