//
//  CarCheckTableView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-21.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarCheckTableViewCell.h"

#define kMaxItemClounm 3
#define kColounmItemWidthArray @[@165.f,@66.f,@68.f]
#define kCellHeight  18.f;
@implementation CarCheckTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat currX = 0.f;
        self.clipsToBounds = YES;
        //NSArray *widthArray = ;
        for(int i = 0;i<kMaxItemClounm;i++){
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,0.f,[kColounmItemWidthArray[i]floatValue],18)];
            itemLabel.font = [UIFont systemFontOfSize:10];
            itemLabel.textColor = [UIColor whiteColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"";
            currX = currX+[kColounmItemWidthArray[i]floatValue]+1;
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
        }
        [self setClounmWidthArrays:kColounmItemWidthArray];
        
    }
    return self;
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
