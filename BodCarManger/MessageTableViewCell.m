//
//  MessageTableViewCell.m
//  BodCarManger
//
//  Created by cszhan on 13-10-3.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight:(NSDictionary*)data{

    return 50.f;
}
@end
