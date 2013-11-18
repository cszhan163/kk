//
//  WeiXinShareMgr.h
//  kok
//
//  Created by cszhan on 12-12-4.
//  Copyright (c) 2012年 raiyin. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define TEST
//for distribution
#define kWXAppId        @"wx35824ac1de06c4cf"
#define kWXAppSecrect   @"2568f1c11a1e680866863e8350c368bc"
#define kWeiXinApp  @""
#define kKokCardSizeShared CGSizeMake(190,114)

@protocol WeiXinSendDataDelegate;
@protocol WeiXinGetDataDelegate;
@interface WeiXinShareMgr:NSObject
@property(nonatomic,assign)id<WeiXinSendDataDelegate> sendDataDelegate;
@property(nonatomic,assign)id<WeiXinGetDataDelegate>  getDataDelegate;
/**
 *@brief common public method
 */
+ (id)getSingleTone;
- (BOOL)handleOpenFromWeiXin:(NSURL*)url;
- (BOOL)handleOpenFromWeiXin:(NSURL *)url fromSourceApplication:(NSString*)app withParam:(id)param;
/**
 *@brief return to weixin app
*/
- (BOOL)returnToWXApp;
/**
 @brief send data to weixin
 */
- (void)sendMediaDataToWeiXin:(id)mediaData;
- (void)sendTextDataToWeiXin:(NSString*)text;
- (BOOL)sendKokAppDataToWeixin:(id)appData;
//- (void)sendKokImageDataToWeiXin:(UIImage*)data;
- (BOOL)sendKokImageDataToWeiXin:(UIImage*)data thumbData:(UIImage*)thumbData;
@end
/**
 @brief send data to weixin respond
 */
@protocol WeiXinSendDataDelegate <NSObject>
@optional
- (void)openFromWeiXin:(WeiXinShareMgr*)sender;
- (void)sendData:(WeiXinShareMgr*)sender withStatus:(BOOL)status;
@end
@protocol WeiXinGetDataDelegate <NSObject>
- (void)getDataFromWx:(WeiXinShareMgr*)sender withData:(id)Data;
@end
