//
//  OCDaysView.h
//  OCCalendar
//
//  Created by Oliver Rickard on 3/30/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCDaysModel.h"
#import "OCCalendarDelegate.h"
@protocol OCDayViewDelegate;

@interface OCDaysView : UIView{
    int startCellX;
    int startCellY;
    int endCellX;
    int endCellY;
    
    float xOffset;
    float yOffset;
    
    float hDiff;
    float vDiff;
    
    int currentMonth;
    int currentYear;
    
    BOOL didAddExtraRow;
    OCDaysModel *mDaysModel;
}

- (void)setMonth:(int)month;
- (void)setYear:(int)year;

- (void)resetRows;

- (BOOL)addExtraRow;
@property(nonatomic,unsafe_unretained)id<OCDaysViewDelegate> delegate;
- (void)setDayItemRowHeight:(CGFloat)h rowWidth:(CGFloat)w;
- (NSDictionary*)getTouchDayViewByPoint:(CGPoint)point withParentView:(UIView*)parentView;
@end
