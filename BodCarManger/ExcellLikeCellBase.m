//
//  ExcellLikeCellBase.m
//  BodCarManger
//
//  Created by cszhan on 13-10-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "ExcellLikeCellBase.h"
@interface ExcellLikeCellBase(){
}
@property(nonatomic,strong)NSArray *mClounmWidthArray;

@end

@implementation ExcellLikeCellBase
@synthesize mClounmWidthArray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.mLineColor = [UIColor grayColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setClounmWidthArrays:(NSArray*)widthArray{
    self.mClounmWidthArray = widthArray;
}
- (void)setClounmLineColor:(UIColor*)color{
    self.mLineColor = color;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat currX = 0.f;
    for(id item in mClounmWidthArray){
        CGFloat lineOffsetX = [item floatValue];
        currX = currX+lineOffsetX;
        UIView  *seperateLine = [[UIView alloc]initWithFrame:CGRectMake(currX,0,1.f,self.frame.size.height)];
        seperateLine.backgroundColor = self.mLineColor;
        [self addSubview:seperateLine];
        
    }
}
- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
}
@end
