//
//  CarDriveActionTableViewCell.m
//  BUILIb
//
//  Created by cszhan on 13-11-5.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "CarDriveActionTableViewCell.h"

#define kDriveActionMaxItemClounm 4
#define kDriveActionColounmItemWidthArray @[@50.f,@80.f,@80.f,@80.f]

@implementation CarDriveActionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
#if 1
        // Initialization code
        CGFloat currX = 0.f;
        //NSArray *widthArray = ;
        for(int i = 0;i<kDriveActionMaxItemClounm;i++){
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,6.f,[kDriveActionColounmItemWidthArray[i]floatValue],20)];
            itemLabel.font = [UIFont systemFontOfSize:15];
            itemLabel.textColor = [UIColor whiteColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"10-02";
            currX = currX+[kDriveActionColounmItemWidthArray[i]floatValue]+1;
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
        }
        //        UIView  *seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1)];
        //        seperateLine.backgroundColor = self.mLineColor;
        //        [self addSubview:seperateLine];
        //        SafeRelease(seperateLine);
#endif
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        [self setClounmWidthArrays:kDriveActionColounmItemWidthArray];
        
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
