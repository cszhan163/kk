//
//  AppSetting.m
//  MP3Player
//
//  Created by cszhan on 12-1-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppSetting.h"


@implementation AppSetting

+(BOOL)getUserLoginStatus
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [[usrDefaults objectForKey:@"userLogin"]boolValue];
}
+(void)setUserLoginStatus:(BOOL)status
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:[NSNumber numberWithBool:status] forKey:@"userLogin"];
    [usrDefaults synchronize];

}
+(BOOL)getUserCanPost:(NSString*)userId
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    
    return [[usrDefaults objectForKey:userId]boolValue];
    
}
+(void)setUserCanPost:(BOOL)status userId:(NSString*)userId
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:[NSNumber numberWithBool:status] forKey:userId];
    [usrDefaults synchronize];
}
+(void)setLoginUserId:(NSString*)userId
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:userId forKey:@"userId"];
    [usrDefaults synchronize];
}

+(NSString*)getLoginUserId
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [usrDefaults objectForKey:@"userId"];
}

+(void)setLoginUserPassword:(NSString*)password{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:password forKey:@"userpassword"];
    [usrDefaults synchronize];
}

+(NSString*)getLoginUserPassword{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [usrDefaults objectForKey:@"userpassword"];
}
+(void)exitLoginUserOut
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults removeObjectForKey:@"userId"];
    [usrDefaults synchronize];
}
+(BOOL)getLoginUserUploadContactorsPhoneNumberStatus
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [[usrDefaults objectForKey:@"phonenumberStatus"]boolValue];
    
}
+(void)setLoginUserUploadContactorsPhoneNumbersStatus:(BOOL)status
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:[NSNumber numberWithBool:status] forKey:@"phonenumberStatus"];
    [usrDefaults synchronize];
}
+(void)setLoginUserInfo:(NSDictionary*)data 
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:data forKey:@"currentLoginUser"];
    [usrDefaults synchronize];

}
+(NSDictionary*)getLoginUserInfo
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [usrDefaults objectForKey:@"currentLoginUser"];
    
}
+(NSDictionary*)getLoginUserCarData{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [usrDefaults objectForKey:@"currentLoginUserCarData"];
}
+(void)setLoginUserCarData:(NSDictionary*)data{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:data forKey:@"currentLoginUserCarData"];
    [usrDefaults synchronize];

}
+(void)setLoginUserDetailInfo:(NSDictionary*)data userId:(NSString*)userId
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:data forKey:userId];
    [usrDefaults synchronize];
}
+(NSDictionary*)getLoginUserDetailInfo:(NSString*)userId
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [usrDefaults objectForKey:userId];
}
+(NSString*)getCurrentLoginUser
{
    
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    return [usrDefaults objectForKey:kCurrentLoginUser];
    
}
+(void)setCurrentLoginUser:(NSString*)currUserId{

    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    [usrDefaults setValue:currUserId forKey:kCurrentLoginUser];
    [usrDefaults synchronize];
}
+(void)clearCurrentLoginUser
{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
    NSString *usrId = [usrDefaults objectForKey:kCurrentLoginUser];
    [usrDefaults removeObjectForKey:usrId];
    [usrDefaults removeObjectForKey:kCurrentLoginUser];
    [usrDefaults synchronize];
}
+(BOOL)getStopPlayTimerStatus:(NSString*)time{
	return [[[NSUserDefaults standardUserDefaults]objectForKey:time]boolValue];
}
+(void)setStopPlayTimer:(NSString*)time status:(BOOL)status{
	NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
	[usrDefaults setValue:[NSNumber numberWithBool:status] forKey:time];
	[usrDefaults synchronize];
}
+(id)getStopPlayTimer
{
	NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
	/*
	[usrDefaults setValue:[NSNumber numberWithBool:status] forKey:@];
	[usrDefaults synchronize];
	*/
	return [usrDefaults objectForKey:@"stopTimer"];
}
+(void)setStopPlayTimer:(id)minuteNum{
	NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
	[usrDefaults setValue:minuteNum forKey:@"stopTimer"];
	[usrDefaults synchronize];
}
+(BOOL)getNeedLoadImage
{
	NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
	/*
     [usrDefaults setValue:[NSNumber numberWithBool:status] forKey:@];
     [usrDefaults synchronize];
     */
    NSNumber *value = [usrDefaults objectForKey:@"needLoadImage"];
    if(value==nil)
    {
        [AppSetting setNeedLoadImage:YES];
        return YES;
    }
	return [value boolValue];

}
+(void)setNeedLoadImage:(BOOL)status

{
    
	NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
	
     [usrDefaults setValue:[NSNumber numberWithBool:status] forKey:@"needLoadImage"];
     [usrDefaults synchronize];
}
+(BOOL)getCarLocationSetting{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
	/*
     [usrDefaults setValue:[NSNumber numberWithBool:status] forKey:@];
     [usrDefaults synchronize];
     */
    NSNumber *value = [usrDefaults objectForKey:@"locationSetting"];
    if(value==nil)
    {
        //[AppSetting setNeedLoadImage:YES];
        return YES;
    }
	return [value boolValue];

}
+(void)setCarLocationSetting:(BOOL)status{
    NSUserDefaults *usrDefaults = [NSUserDefaults standardUserDefaults];
	
    [usrDefaults setValue:[NSNumber numberWithBool:status] forKey:@"locationSetting"];
    [usrDefaults synchronize];
    
}
@end
