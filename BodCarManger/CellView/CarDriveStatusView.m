//
//  CarDriveStatusView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveStatusView.h"

#define kNumberLargeSize 16
#define kNumberMidSize   12

@implementation CarDriveStatusView

@synthesize mDriveAnalaysisImageView;
@synthesize mOilCostAnalaysisImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setTargetAndActionFun];
    }
    return self;
}
- (NSString*)getDateKey{
    return  _dateKey;
}
- (void)setTextFontSize{

    self.mRunDaysLabel.font = kUserDigiFontSize(kNumberLargeSize);
    self.mRunDistanceLabel.font = kUserDigiFontSize(kNumberLargeSize);
    
    self.mRunOilCostLabel.font = kUserDigiFontSize(kNumberMidSize);
    self.mRunStepLabel.font = kUserDigiFontSize(kNumberMidSize);
    self.mRunMoneyCostLabel.font = kUserDigiFontSize(kNumberMidSize);

}
- (void)awakeFromNib{

    for(id item in self.subviews){
        if([item isKindOfClass:[UILabel class]]){
            UILabel *labelItem = (UILabel*)item;
            labelItem.textColor = [UIColor whiteColor];
        }
    }
    [self setTextFontSize];

}
- (void)setTargetAndActionFun{

    for(id item in self.subviews){
        
        if([item isKindOfClass:[UIButton class]]){
            
            [(UIButton*)item  addTarget:self.target action:self.action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (void)setTarget:(id)target withAction:(SEL)action{
    self.target = target;
    self.action = action;
    [self setTargetAndActionFun];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
