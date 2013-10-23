//
//  Cell2.m
//  kkshop
//
//  Created by apple on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlantTableViewCell.h"

@implementation PlantTableViewCell
@synthesize mDistanceImageView;
@synthesize mDistanceLabel;

@synthesize mTagImageView;
@synthesize mTagLabel;

@synthesize mOilImageView;
@synthesize mOilLabel;

@synthesize mTimeImageView;
@synthesize mTimeLabel;

@synthesize mStartLabel;
@synthesize mEndLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
