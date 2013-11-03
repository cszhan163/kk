//
//  WBAuthorizeV2.h
//  DressMemo
//
//  Created by Fengfeng Pan on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBRequest.h"
//#import "WBAuthorize.h"


@protocol WBAuthorizeV2Delegate;

@interface WBAuthorizeV2 : NSObject <WBRequestDelegate>{
    NSString    *appKey;
    NSString    *appSecret;
    NSString    *redirectURI;
    WBRequest   *request;
}

@property (nonatomic, retain) NSString *appKey;
@property (nonatomic, retain) NSString *appSecret;
@property (nonatomic, retain) NSString *redirectURI;
@property (nonatomic, retain) WBRequest *request;
@property (nonatomic, assign) id<WBAuthorizeV2Delegate> delegate;

- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret redirectURI:(NSString *)url;

- (NSURLRequest *)authURLRequest;

-(BOOL)parseQueryAndRedirect:(NSString *)query;


@end

@protocol  WBAuthorizeV2Delegate <NSObject>

- (void)authorize:(WBAuthorizeV2 *)authorize didSucceedWithAccessToken:(NSString *)accessToken userID:(NSString *)userID expiresIn:(NSInteger)seconds;

- (void)authorize:(WBAuthorizeV2 *)authorize didFailWithError:(NSError *)error;

@end
