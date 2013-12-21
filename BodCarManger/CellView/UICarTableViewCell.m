//
//  UICarTableViewCell.m
//  BodCarManger
//
//  Created by cszhan on 13-12-19.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UICarTableViewCell.h"

@implementation UICarTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        inset = 9.f;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame {
    inset = 9.f;
    if(kIsIOS7Check){
        frame.origin.x += inset;
        frame.size.width -= 2 * inset;
    }
    [super setFrame:frame];
}
@end
