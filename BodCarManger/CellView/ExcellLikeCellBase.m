//
//  ExcellLikeCellBase.m
//  BodCarManger
//
//  Created by cszhan on 13-10-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "ExcellLikeCellBase.h"
#define kCellSplitLineColor    HexRGB(96, 95, 95)  
@interface ExcellLikeCellBase(){
    BOOL isHiddenLine;
    UIView  *seperateLine;
}
@property(nonatomic,strong)NSArray *mClounmWidthArray;

@end

@implementation ExcellLikeCellBase
@synthesize mCellItemArray;
@synthesize mClounmWidthArray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.mCellItemArray = [NSMutableArray array];
        self.mLineColor = kCellSplitLineColor;
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
    //if(isHiddenLine)
    {
        seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1)];
        seperateLine.backgroundColor = self.mLineColor;
        [self addSubview:seperateLine];
        SafeRelease(seperateLine);
    }
}
- (void)setSeperateLineHidden:(BOOL)status{
    seperateLine.hidden = status;
}
- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
}
@end
