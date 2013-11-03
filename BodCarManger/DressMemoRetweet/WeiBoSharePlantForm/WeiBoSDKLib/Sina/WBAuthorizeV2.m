//
//  WBAuthorizeV2.m
//  DressMemo
//
//  Created by Fengfeng Pan on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WBAuthorizeV2.h"
#import "WBSDKGlobal.h"

#define kWBAuthorizeURL     @"https://api.weibo.com/oauth2/authorize"
#define kWBAccessTokenURL   @"https://api.weibo.com/oauth2/access_token"

@implementation WBAuthorizeV2
@synthesize appKey;
@synthesize appSecret;
@synthesize redirectURI;
@synthesize request;
@synthesize delegate;


#pragma mark -memory
- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret redirectURI:(NSString *)url{
    self = [self init];
    
    if (self) {
        self.appKey = theAppKey;
        self.appSecret = theAppSecret;
        self.redirectURI = url;
    }
    
    return self;
}


-(void)dealloc{
    self.appKey = nil;
    self.appSecret = nil;
    self.redirectURI = nil;
   
    [self.request disconnect];
    self.request = nil;
    
    [super dealloc];
}

#pragma mark -Public API
- (NSURLRequest *)authURLRequest{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:appKey, @"client_id",
                            @"code", @"response_type",
                            redirectURI, @"redirect_uri", 
                            @"mobile", @"display", nil];
    NSString *urlString = [WBRequest serializeURL:kWBAuthorizeURL
                                           params:params
                                       httpMethod:@"GET"];
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

-(BOOL)parseQueryAndRedirect:(NSString *)query{
    NSRange range = [query rangeOfString:@"code="];
    
    if (range.location != NSNotFound && range.length)
    {
        NSString *code = [query substringFromIndex:range.location + range.length];
        
        [self requestAccessTokenWithAuthorizeCode:code];
        return NO;
    }
    
    return YES;
}

#pragma mark -Private API
- (void)requestAccessTokenWithAuthorizeCode:(NSString *)code
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:appKey, @"client_id",
                            appSecret, @"client_secret",
                            @"authorization_code", @"grant_type",
                            redirectURI, @"redirect_uri",
                            code, @"code", nil];
    [request disconnect];
    
    self.request = [WBRequest requestWithURL:kWBAccessTokenURL
                                  httpMethod:@"POST"
                                      params:params
                                postDataType:kWBRequestPostDataTypeNormal
                            httpHeaderFields:nil 
                                    delegate:self];
    
    [request connect];
}

#pragma mark -Request Delegate
#pragma mark - WBRequestDelegate Methods
- (void)request:(WBRequest *)theRequest didFinishLoadingWithResult:(id)result
{
    BOOL success = NO;
    if ([result isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary *)result;
        
        NSString *token = [dict objectForKey:@"access_token"];
        NSString *userID = [dict objectForKey:@"uid"];
        NSInteger seconds = [[dict objectForKey:@"expires_in"] intValue];
        
        success = token && userID;
        
        if (success && [delegate respondsToSelector:@selector(authorize:didSucceedWithAccessToken:userID:expiresIn:)])
        {
            [delegate authorize:self didSucceedWithAccessToken:token userID:userID expiresIn:seconds];
        }
    }
    
    // should not be possible
    if (!success && [delegate respondsToSelector:@selector(authorize:didFailWithError:)])
    {
        NSError *error = [NSError errorWithDomain:kWBSDKErrorDomain 
                                             code:kWBErrorCodeSDK 
                                         userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", kWBSDKErrorCodeAuthorizeError] 
                                                                              forKey:kWBSDKErrorCodeKey]];
        [delegate authorize:self didFailWithError:error];
    }
}

- (void)request:(WBRequest *)theReqest didFailWithError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(authorize:didFailWithError:)])
    {
        [delegate authorize:self didFailWithError:error];
    }
}



@end
