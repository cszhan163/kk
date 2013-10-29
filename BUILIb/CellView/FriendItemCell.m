//
//  FriendItemCell.m
//  DressMemo
//
//  Created by  on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendItemCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation FriendItemCell
@synthesize userIconImageView;
@synthesize locationLabel;
@synthesize nickNameLabel;
@synthesize relationBtn;
@synthesize indictTextLabel;
-(void)dealloc{
    self.userIconImageView = nil;
    self.locationLabel = nil;
    self.nickNameLabel = nil;
    self.relationBtn = nil;
    [super dealloc];
}
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
+(id)getFromNibFile
{
    NSArray *nibItems = [[NSBundle mainBundle] loadNibNamed:@"FriendItemCell" owner:nil options:nil];
    FriendItemCell *instance = [nibItems objectAtIndex:0];
    /*
    instance.userIconImageView.layer.borderWidth = 2.5f;
    instance.userIconImageView.layer.borderColor = [[UIColor whiteColor]CGColor];
     */
    instance.selectionStyle = UITableViewCellSelectionStyleNone;
    instance.backgroundColor = [UIColor clearColor];
    return instance;

    //return instance;

}

@end
