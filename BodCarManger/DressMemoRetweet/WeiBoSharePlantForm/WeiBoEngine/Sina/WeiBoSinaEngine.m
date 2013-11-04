//
//  WeiBoSinaEngine.m
//  Tester
//
//  Created by Fengfeng Pan on 11-12-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "WeiBoSinaEngine.h"
#import "JSON.h"
#import "constant.h"
#import "WBSDKGlobal.h"

#define kExpireTimeKey @"kExpireTimeKey"

@implementation WeiBoSinaEngine

@synthesize userID = _userID;
@synthesize userInfoRequest = _userInfoRequest;
@synthesize sendRequest = _sendRequest;
@synthesize expireTime = _expireTime;

-(id)initWithAppKey:(NSString *)appKey AppSecret:(NSString *)appSecret{
    self = [self init];
    
    if (self) {
        _sinaV2Auth = [[WBAuthorizeV2 alloc] initWithAppKey:appKey appSecret:appSecret redirectURI:K_APPREDIRECTURI_SINA];
        _sinaV2Auth.delegate = self;
        
        _expireTime = [[[NSUserDefaults standardUserDefaults] objectForKey:kExpireTimeKey] doubleValue];
    }
    
    return  self;
}

-(void)dealloc{
    
    [_sinaV2Auth release]; _sinaV2Auth = nil;
    
    self.authRequest = nil;
    self.userID = nil;
    self.userInfoRequest = nil;
    self.sendRequest = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark public api
- (BOOL)isAuth{
    return [self.tokenKey length];
}

-(NSURLRequest *)auth{
    
    if (self.authRequest) {
        return self.authRequest;
    }
    
    
    self.authRequest = [_sinaV2Auth authURLRequest];
    
    return self.authRequest;
}

-(void)canceAuth{
    [super canceAuth];
    self.userID = nil;
}


-(BOOL)parseQueryAndRedirect:(NSString *)query{
    return [_sinaV2Auth parseQueryAndRedirect:query];
}

- (void)setExpireTime:(NSTimeInterval)expireTime{
    _expireTime = expireTime;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:_expireTime]
                                              forKey:kExpireTimeKey];
}

-(void)sendStatus:(NSString *)str Image:(NSData *)imageData{
    [self sendWeiBoWithText:str image:[UIImage imageWithData:imageData]];
}

#pragma mark -
#pragma mark Private API
- (void)loadRequestWithMethodName:(NSString *)methodName
                       httpMethod:(NSString *)httpMethod
                           params:(NSDictionary *)params
                     postDataType:(WBRequestPostDataType)postDataType
                 httpHeaderFields:(NSDictionary *)httpHeaderFields
{
    
    // Step 1.
    // Check if the user has been logged in.
	if (![self isAuth])
	{
        if ([self.dataDelegate respondsToSelector:@selector(sendStatusFailWithEngine:failReason:)]) {
            [self.dataDelegate sendStatusFailWithEngine:self failReason:kWeiBoSinaEngineFailReasonNoBind];
        }
        return;
	}
    
	// Step 2.
    // Check if the access token is expired.
    if ([[NSDate date] timeIntervalSince1970] > _expireTime)
    {
        if ([self.dataDelegate respondsToSelector:@selector(sendStatusFailWithEngine:failReason:)]) {
            [self.dataDelegate sendStatusFailWithEngine:self failReason:kWeiBoSinaEngineFailReasonExpire];
        }
        return;
    }
  
    
    [self.sendRequest disconnect];
    
    self.sendRequest = [WBRequest requestWithAccessToken:self.tokenKey
                                                     url:[NSString stringWithFormat:@"%@%@", kWBSDKAPIDomain, methodName]
                                              httpMethod:httpMethod
                                                  params:params
                                            postDataType:postDataType
                                        httpHeaderFields:httpHeaderFields
                                                delegate:self];
	
	[self.sendRequest connect];
}


- (void)sendWeiBoWithText:(NSString *)text image:(UIImage *)image
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    
    //NSString *sendText = [text URLEncodedString];
    
	[params setObject:(text ? text : @"") forKey:@"status"];
	
    if (image)
    {
		[params setObject:image forKey:@"pic"];
        
        [self loadRequestWithMethodName:@"statuses/upload.json"
                             httpMethod:@"POST"
                                 params:params
                           postDataType:kWBRequestPostDataTypeMultipart
                       httpHeaderFields:nil];
    }
    else
    {
        [self loadRequestWithMethodName:@"statuses/update.json"
                             httpMethod:@"POST"
                                 params:params
                           postDataType:kWBRequestPostDataTypeNormal
                       httpHeaderFields:nil];
    }
}


#pragma mark -
#pragma mark Auth V2 delegate
- (void)authorize:(WBAuthorizeV2 *)authorize didSucceedWithAccessToken:(NSString *)accessToken userID:(NSString *)userID expiresIn:(NSInteger)seconds{
    self.userID = userID;
    
    self.tokenKey = accessToken;
    self.tokenSecret = nil;
    self.expireTime = [[NSDate date] timeIntervalSince1970] + seconds;
    
    if ([self.authDelegate respondsToSelector:@selector(authOKWithEngine:)]) {
        [self.authDelegate authOKWithEngine:self];
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.userID forKey:@"uid"];
    
    [self.userInfoRequest disconnect];
    self.userInfoRequest = [WBRequest requestWithAccessToken:accessToken
                                                         url:[NSString stringWithFormat:@"%@users/show.json", kWBSDKAPIDomain]
                                                  httpMethod:@"GET" 
                                                      params:dic
                                                postDataType:kWBRequestPostDataTypeNormal
                                            httpHeaderFields:nil
                                                    delegate:self];
    [_userInfoRequest connect];
    
    [dic release];

}

- (void)authorize:(WBAuthorizeV2 *)authorize didFailWithError:(NSError *)error{
    if ([self.authDelegate respondsToSelector:@selector(authFailWithEngine:failReason:)]) {
        [self.authDelegate authFailWithEngine:self failReason:[error description]];
    }
}

#pragma mark-
#pragma mark WBRequest Delegate
- (void)requestLoading:(WBRequest *)request{

}			

- (void)request:(WBRequest *)request didFailWithError:(NSError *)error{
    if (request == self.sendRequest) {
        if ([self.dataDelegate respondsToSelector:@selector(sendStatusFailWithEngine:failReason:)]) {
            [self.dataDelegate sendStatusFailWithEngine:self failReason:[error localizedDescription]];
        }
        
        self.sendRequest = nil;
    }
    
}

- (void)request:(WBRequest *)request didReceiveRawData:(NSData *)data{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if (request == self.userInfoRequest) {
        NSDictionary *dataDic = [str JSONValue];
        
        if([dataDic isKindOfClass:[NSDictionary class]]){
            if ([self.dataDelegate respondsToSelector:@selector(userInfoWithEngine:resultDic:)]) {
                [self.dataDelegate userInfoWithEngine:self resultDic:dataDic];
            }
        }
        
        self.userInfoRequest = nil;
        
    }else if(request == self.sendRequest){
        if ([self.dataDelegate respondsToSelector:@selector(sendStatusOKWithEngine:)]) {
            [self.dataDelegate sendStatusOKWithEngine:self];
        }
        
        self.sendRequest = nil;
    }
    
    NSLog(@"data: %@", str);

}

- (void)request:(WBRequest *)request didFinishLoadingWithResult:(id)result{

}




@end
