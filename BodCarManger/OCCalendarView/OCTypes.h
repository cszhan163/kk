//
//  OCTypes.h
//  OCCalendar
//
//  Created by Dermot Daly on 17/05/2012.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

typedef enum {
    OCSelectionSingleDate = 0,
    OCSelectionDateRange
} OCSelectionMode;

@interface StructPoint:NSObject{
}
 @property(assign)    int mStartX;
 @property(assign)    int mStartY;
 @property(assign)    int mEndX;
 @property(assign)    int mEndY;
@property(assign) int mTag;
@property(strong) UIColor *color;
@end


#define kDayCellHeight 14
#define kDayCellWidth 21