//
//  WeiBoSinaEngine.h
//  Tester
//
//  Created by Fengfeng Pan on 11-12-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "WeiBoBaseEngine.h"
#import "WBAuthorize.h"
#import "WBAuthorizeV2.h"
#import "WeiBo.h"

//typedef enum{
//    WeiboSinaAuthTypeV2 = 0,
//    WeiboSinaAuthTypeV1
//} WeiboSinaAuthType;

#define kWeiBoSinaEngineFailReasonNoBind @"没有授权，请先绑定新浪微博帐号"
#define kWeiBoSinaEngineFailReasonExpire @"授权过期，请重新绑定新浪微博帐号"

@interface WeiBoSinaEngine : WeiBoBaseEngine <WBAuthorizeDelegate, WBRequestDelegate, WBAuthorizeV2Delegate>{
    WBAuthorizeV2 *_sinaV2Auth;

    WBRequest *_userInfoRequest;
    WBRequest *_sendRequest;
    
    NSString *_userID;
    NSTimeInterval _expireTime;
}

@property (nonatomic, retain)NSString *userID;
@property (nonatomic, retain)WBRequest *userInfoRequest;
@property (nonatomic, retain)WBRequest *sendRequest;
@property (nonatomic, assign)NSTimeInterval expireTime;

@end
