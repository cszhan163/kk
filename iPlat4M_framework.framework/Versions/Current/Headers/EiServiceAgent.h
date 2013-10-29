//
//  EiServiceAgent.h
//  iPlat4M_iPad
//
//  Created by liuxi on 11-10-24.
//  Copyright 2011年 BaoSight. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EiInfo;
@class EiHttpAgent;
@class UserSession;
@interface EiServiceAgent : NSObject{
}
@property (nonatomic,retain) EiHttpAgent * httpAgent;
@property (nonatomic,retain) NSMutableDictionary * serviceInfo;
@property (nonatomic,retain) NSMutableDictionary * blockEiserviceInfo;
@property (nonatomic,retain) NSMutableDictionary * blockWebserviceInfo;

@property (nonatomic,retain) UserSession * userSession;


-(void) callServiceWithObject:(id) sender
                       inInfo:(EiInfo *) info 
                       target:(id) delegate
              successCallBack:(SEL) sucAction 
                failCallBack :(SEL) failAction;

-(void) callService:(EiInfo *) info 
             target:(id) delegate 
    successCallBack:(SEL) sucAction 
      failCallBack :(SEL) failAction;

-(void) callWebServiceWithObject:(id) sender
                     requestDict:(NSMutableDictionary *) requestDic 
                          target:(id) delegate
                 successCallBack:(SEL) sucAction 
                   failCallBack :(SEL) failAction;

-(void) callLoginService:(EiInfo *) info 
                  target:(id) delegate 
         successCallBack:(SEL) sucAction 
           failCallBack :(SEL) failAction;

-(void)callService:(EiInfo *)info 
        successWithCallbackBlock:(void (^)(EiInfo *))successBlock 
        failWithCallbackBlock:(void (^)(EiInfo *))failBlock;

-(void) callWebServiceWithObject:(id) sender
                     requestDict:(NSMutableDictionary *) requestDic
        successWithCallbackBlock:(void (^)(NSMutableDictionary *))successBlock
           failWithCallbackBlock:(void (^)(NSMutableDictionary *))failBlock;
@end
@interface EiServiceAgent(private)
-(void) exeDelegateMethod:(id) delegate
                 function:(SEL)action 
                   eiInfo:(EiInfo *) eiInfo;
-(void) exeDelegateMethodWithObject:(id) sender 
                             target:(id) delegate 
                           function:(SEL)action 
                             eiInfo:(EiInfo *) eiInfo;
-(NSString *)generateUuidString;

-(void) releaseDelegate:(id) deallocedDelegate ;


@end
