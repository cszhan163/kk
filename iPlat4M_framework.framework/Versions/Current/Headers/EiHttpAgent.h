//
//  EiHttpAgent.h
//  iPlat4M_iPad
//
//  Created by liuxi on 11-10-24.
//  Copyright 2011年 BaoSight. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "EiASIHttpDelegate.h"
#import "ASIFormDataRequest.h"
@class EiInfo;
@class UserSession;
@interface EiHttpAgent : NSObject
{
}
@property (nonatomic,assign) SEL eiHttpAgentSuccussAction;
@property (nonatomic,assign) SEL eiHttpAgentFailAction;
@property (nonatomic,assign) SEL WebHttpAgentSuccussAction;
@property (nonatomic,assign) SEL WebHttpAgentFailAction;
@property (nonatomic,retain) id eiASIHttpDelegate;

@property (nonatomic,retain) UserSession* userSession;

-(void) startAsyRequest:(EiInfo *) eiInfo  
        succussFunction:(SEL)suAction 
           failFunction:(SEL) faAction;

-(void) startLoginAsyRequest:(EiInfo *) eiInfo  
             succussFunction:(SEL)suAction 
                failFunction:(SEL) faAction;

-(void) startWebAsyRequest:(id) request  
           succussFunction:(SEL)suAction 
              failFunction:(SEL) faAction;

-(void) exeDelegateMethod:(SEL)action 
                   eiInfo:(EiInfo *) eiInfo;



-(NSString*) getParameterCompressdataFromEiInfo: (EiInfo *)eiinfo;
-(NSString*) getParameterEncryptdataFromEiInfo: (EiInfo *)eiinfo;
-(NSString*) getParameterURLFromEiInfo: (EiInfo *)eiinfo;
-(NSString*) getParameterCompressdataFromRequestDict: (NSDictionary *)requestDict;
-(NSString*) getParameterURLFromRequestDict: (NSDictionary *)requestDict;
-(NSString*) getParameterEncryptdataFromRequstDict: (NSDictionary *)requestDict;
@end
