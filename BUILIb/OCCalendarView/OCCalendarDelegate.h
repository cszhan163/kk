//
//  OCCalendarDelegate.h
//  BodCarManger
//
//  Created by cszhan on 13-9-19.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OCDaysViewDelegate <NSObject>
@optional
- (void)didChooseViewDay:(NSDictionary*)day;
@end
@protocol OCCalendarViewDelegate <NSObject>
@optional
- (void)didChooseCalendarDay:(NSDictionary*)day;
- (void)didTouchPreMoth:(NSDictionary*)day;
- (void)didTouchAfterMoth:(NSDictionary *)day;
@end
@protocol OCCalendarDelegate <NSObject>
@optional
-(void)completedWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

-(void)completedWithNoSelection;

@end