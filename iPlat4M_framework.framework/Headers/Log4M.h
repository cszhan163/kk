//
//  Log4M.h
//  iPlat4M_iPad
//
//  Created by baosight on 11-12-1.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Log4M : NSObject

/** 
 * 方法：instance
 * 功能： 
 * 描述：获得Log4M实例
 * 返回：
 **/
+(Log4M * ) instance;
/** 
 * 方法：
 * 功能： 
 * 描述：日志debug模式
 * 返回：
 **/
@property (nonatomic) BOOL deBug;
/** 
 * 方法：writeLogWithDescription:
 * 功能： 
 * 描述：写日志信息
 * 返回：
 **/
-(void) writeLogWithDescription:(NSString *) description 
                    controlType:(NSString *) controlType;
/** 
 * 方法：generateUuidString:
 * 功能： 
 * 描述：获取log的uuid
 * 返回：
 **/
-(NSString *)generateUuidString;
@end
