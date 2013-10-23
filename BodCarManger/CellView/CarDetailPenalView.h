//
//  CarDetailPenalView.h
//  BodCarManger
//
//  Created by cszhan on 13-9-18.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailPenalView : UIView
@property(nonatomic,strong)IBOutlet UILabel *mRunSpeedLabel;
@property(nonatomic,strong)IBOutlet UILabel *mRunDistanceLabel;
@property(nonatomic,strong)IBOutlet UILabel *mRotateSpeedLabel;
@property(nonatomic,strong)IBOutlet UILabel *mRunTemperatureLabel;
@property(nonatomic,strong)IBOutlet UIImageView *mOilCostAnalaysisImageView;
@property(nonatomic,strong)IBOutlet UIImageView *mDriveAnalaysisImageView;
@end
