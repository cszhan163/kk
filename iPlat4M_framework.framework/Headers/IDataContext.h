//
//  IDataContext.h
//  iPlat4M
//
//  Created by Fu Yiming on 11-11-15.
//  Copyright 2011年 baosight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EiInfo.h"


@protocol IDataContext 


//控件从EIInfo中读取数据
-(void) updateFromData:(EiInfo *)eiinfo;

//控件更新数据到EIInfo中
-(void) updateToData:(EiInfo *)eiinfo;

-(void) updateFromRow:(NSDictionary *) row;

-(void) updateToRow:(NSDictionary *) row;

-(EiInfo *) getEiInfo;

@end
