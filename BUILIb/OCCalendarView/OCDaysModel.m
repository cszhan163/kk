//
//  OCDaysModel.m
//  BodCarManger
//
//  Created by cszhan on 13-9-18.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "OCDaysModel.h"

@implementation OCDaysModel
@synthesize itemHeight;
@synthesize itemWidth;
@synthesize month;
@synthesize year;
@synthesize pointDataMapDict;
@synthesize mapPointView;

- (void)dealloc{
    self.pointDataMapDict = nil;
    [super dealloc];
  
}
- (id)init{
    if(self = [super init]){
    
        self.pointDataMapDict = [NSMutableDictionary dictionary];
    }
    return  self;
}
- (void)updatePointDaysMapForKey:(NSString*)key Value:(id)value{
    [self.pointDataMapDict setValue:value forKey:key];
}
- (NSDictionary*)getPointDayValueByPoint:(CGPoint)point atView:(UIView*)hitView{
    
    CGPoint newPoint = [hitView convertPoint:point toView:mapPointView];
    int col = newPoint.x/itemWidth;
    int row = newPoint.y/itemHeight;
    int key = col+ row*7;
    NSString *keyValue = [NSString stringWithFormat:@"%d",key];
    return [self.pointDataMapDict objectForKey:keyValue];
}
- (NSDictionary*)getPointDayValueByPoint:(CGPoint)point fromView:(UIView*)hitView toView:(UIView*)targetView{
    CGPoint newPoint = [hitView convertPoint:point toView:targetView];
    int col = newPoint.x/itemWidth;
    int row = newPoint.y/itemHeight;
    int key = col+ row*7;
    NSString *keyValue = [NSString stringWithFormat:@"%d",key];
    return [self.pointDataMapDict objectForKey:keyValue];
}
- (NSDictionary*)getPointDayValueByPoint:(CGPoint)point{
    int col = point.x/itemWidth;
    int row = point.y/itemHeight;
    int key = col+ row*7;
    NSString *keyValue = [NSString stringWithFormat:@"%d",key];
    return [self.pointDataMapDict objectForKey:keyValue];
}
@end
