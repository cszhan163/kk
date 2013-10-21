//
//  SettingTableViewCell.m
//  BodCarManger
//
//  Created by cszhan on 13-10-18.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageWithFileName(UIImage *bgImage, @"setting_cell_bg.png");
        UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
        bgView.frame = CGRectMake(0.f, 0.f,300.f,42.f);
        [self insertSubview:bgView belowSubview:self.contentView];
        self.clipsToBounds = YES;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
