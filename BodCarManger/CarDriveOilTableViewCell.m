//
//  CarDriveOilTableViewCell.m
//  BodCarManger
//
//  Created by cszhan on 13-10-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveOilTableViewCell.h"

#define kMaxItemClounm 4
#define kColounmItemWidthArray @[@60.f,@80.f,@80.f,@80.f]

@implementation CarDriveOilTableViewCell
@synthesize mDate;
@synthesize mSpeedDown;
@synthesize mSpeedUp;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat currX = 0.f;
        //NSArray *widthArray = ;
        for(int i = 0;i<kMaxItemClounm;i++){
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,6.f,[kColounmItemWidthArray[i]floatValue],20)];
            itemLabel.font = [UIFont systemFontOfSize:15];
            itemLabel.textColor = [UIColor whiteColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"10-02";
            currX = currX+[kColounmItemWidthArray[i]floatValue]+1;
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            
        }
        UIView  *seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1)];
        seperateLine.backgroundColor = self.mLineColor;
        [self addSubview:seperateLine];
        SafeRelease(seperateLine);
        
        [self setClounmWidthArrays:kColounmItemWidthArray];
        
    }
    return self;
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    
//}
- (void)layoutSubviews{
    [super layoutSubviews];
   
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
