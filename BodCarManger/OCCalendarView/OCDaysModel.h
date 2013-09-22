//
//  OCDaysModel.h
//  BodCarManger
//
//  Created by cszhan on 13-9-18.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDaysModel : NSObject
@property(nonatomic,assign)id mapPointView;
@property(nonatomic,assign)int month;
@property(nonatomic,assign)int year;
@property(nonatomic,assign) int itemWidth;
@property(nonatomic,assign) int itemHeight;
@property(nonatomic,strong)NSMutableDictionary* pointDataMapDict;
- (void)updatePointDaysMapForKey:(NSString*)key Value:(id)value;
- (NSDictionary*)getPointDayValueByPoint:(CGPoint)point toView:(UIView*)hitView;
-(NSDictionary*)getPointDayValueByPoint:(CGPoint)point fromView:(UIView*)hitView toView:(UIView*)targetView;
- (NSDictionary*)getPointDayValueByPoint:(CGPoint)point;
@end
