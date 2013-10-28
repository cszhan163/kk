//
//  DriveOilAnalysisView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-29.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "DriveOilAnalysisView.h"
#import "ZCSDrawLineView.h"
#import "DriveDataModel.h"
@implementation DriveOilAnalysisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bgImage = [UIImage imageNamed:@"oil_data_graph.png"];
        CGRect rect = CGRectMake(0.f,40.f+20.f, bgImage.size.width/kScale, bgImage.size.height/kScale);
        CGFloat currY = rect.origin.y+rect.size.height;
        [self addLineChartView:rect withBGImage:bgImage];
    }
    return self;
}

- (void)addLineChartView:(CGRect)rect withBGImage:(UIImage*)image{
    
    drawLineView = [[ZCSDrawLineView alloc]initWithFrame:rect];
    [drawLineView setBackgroundColor:[UIColor clearColor]];
    [drawLineView setBackgroundImage:image];
    
    [drawLineView setOffsetX:30.f];
    [drawLineView setOffsetY:24.f];
    
    [drawLineView setMaxLenY:212.f];//y
    
    [drawLineView setXStep:253/30.f];//208 x len
    [drawLineView setYStep:212/50.f];
    
    [self addSubview:drawLineView];
    
}
- (void)updateUIByData:(OilAnalysisData*)data{
    //self.oilData = data;
    //@[@32,@28,@40];
    //NSArray *percentArray = self.oilData.percentDataArray;

    [self updateLinesUIByData:nil];
}
- (void)updateLinesUIByData:(NSMutableArray*)data{
    
    NSMutableArray *linesArray = [NSMutableArray array];
    int lastx = 0;
    int lasty = 10;
    for(int i = 1;i<=5;i++){
        NSMutableDictionary *item = [NSMutableDictionary dictionary];
        
        int x = rand()%3+lastx+1;
        int y = rand()%6+lasty+3;
        [item setValue:[NSString stringWithFormat:@"%d",x] forKey:@"x"];
        [item setValue:[NSString stringWithFormat:@"%d",y] forKey:@"y"];
        [linesArray addObject:item];
        lastx = x;
        lasty = y;
    }
    NE_LOG(@"%@",linesArray);
    [self  setDisplayLineChart:linesArray];
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
