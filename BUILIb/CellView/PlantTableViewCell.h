//
//  Cell2.h
//  kkshop
//
//  Created by apple on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlantTableViewCell : UITableViewCell
{
    
}
@property(nonatomic,strong)IBOutlet UIImageView *mTagImageView;
@property(nonatomic,strong)IBOutlet UILabel     *mTagLabel;

@property(nonatomic,strong)IBOutlet UIImageView *mDistanceImageView;
@property(nonatomic,strong)IBOutlet UILabel *mDistanceLabel;

@property(nonatomic,strong)IBOutlet UIImageView *mTimeImageView;
@property(nonatomic,strong)IBOutlet UILabel *mTimeLabel;

@property(nonatomic,strong)IBOutlet UIImageView *mOilImageView;
@property(nonatomic,strong)IBOutlet UILabel *mOilLabel;


@property(nonatomic,strong)IBOutlet UILabel *mStartLabel;
@property(nonatomic,strong)IBOutlet UILabel *mEndLabel;

@end
