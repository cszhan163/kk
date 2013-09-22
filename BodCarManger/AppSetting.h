//
//  AppSetting.h
//  MP3Player
//
//  Created by cszhan on 12-1-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserDefaultIconPath @"kLoginUserDefaultIconPath"
#define  kCurrentLoginUser   @"currentLoginUser"

@interface AppSetting : NSObject {

}

+(void)setLoginUserInfo:(NSDictionary*)data withUserKey:(NSString*)userId;
+(NSDictionary*)getLoginUserInfo:(NSString*)usrId;

+(NSString*)getCurrentLoginUser;
+(void)setCurrentLoginUser:(NSString*)currUserId;
+(void)clearCurrentLoginUser;
+(void)setLoginUserId:(NSString*)userId;
+(NSString*)getLoginUserId;

+(BOOL)getUserLoginStatus;
+(void)setUserLoginStatus:(BOOL)status;
+(void)setLoginUserDetailInfo:(NSDictionary*)data userId:(NSString*)userId;
+(BOOL)getNeedLoadImage;
+(void)setNeedLoadImage:(BOOL)status;

@end
