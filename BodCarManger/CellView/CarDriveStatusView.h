//
//  CarDriveStatusView.h
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDriveStatusView : UIView
@property(weak)id target;
@property(weak)SEL action;
@property(nonatomic,strong)IBOutlet UILabel *mRunDaysLabel;
@property(nonatomic,strong)IBOutlet UILabel *mRunDistanceLabel;
@property(nonatomic,strong)IBOutlet UILabel *mRunStepLabel;
@property(nonatomic,strong)IBOutlet UILabel *mRunMoneyCostLabel;
@property(nonatomic,strong)IBOutlet UILabel *mRunOilCostLabel;
@property(nonatomic,strong)IBOutlet UIImageView *mOilCostAnalaysisImageView;
@property(nonatomic,strong)IBOutlet UIImageView *mDriveAnalaysisImageView;
- (void)setTarget:(id)target withAction:(SEL)action;
@end
