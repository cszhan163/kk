//
//  CarDriveAnalysisView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-27.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarMaintainanceView.h"
#import "AMProgressView.h"
#import "AMArcColorDrawView.h"
@interface  CarMaintainanceView(){
    AMProgressView      *leftProcessView;
    AMProgressView      *rightProcessView;
    AMArcColorDrawView    *circleProcessView;
}
@end
@implementation CarMaintainanceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *image = [UIImage imageNamed:@"drive_matainance_bg.png"];
        UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f,image.size.width/2.f, image.size.height/2.f)];
        bgView.image = image;
        [self addSubview:bgView];
        SafeRelease(bgView);
        CGFloat currX = 3.f;
        CGFloat currY = 17.f;
        AMArcColorDrawView *leftCircleView = [[AMArcColorDrawView alloc]initWithFrame:CGRectMake(currX,currY,20,20)];
        leftCircleView.radius = 8;
        leftCircleView.backgroundColor = [UIColor clearColor];
        [leftCircleView gradientColorWithRed:44.f green:100.f  blue:0.f];
        [self addSubview:leftCircleView];
        SafeRelease(leftCircleView);
       
        currX = currX + 225.f;
        AMArcColorDrawView *rightCircleView = [[AMArcColorDrawView alloc]initWithFrame:CGRectMake(currX,currY,20,20)];
        rightCircleView.radius = 8;
        rightCircleView.backgroundColor = [UIColor clearColor];
        [rightCircleView gradientColorWithRed:44.f green:100.f  blue:0.f];
        [self addSubview:rightCircleView];
        SafeRelease(rightCircleView);
        
        CGFloat leftLen = 60.f;
        CGFloat rightLen = 80.f;
        CGFloat dy      = 8.f;
        CGFloat startY = bgView.frame.size.height/2.f -dy/2.f;
        leftProcessView = [[AMProgressView alloc] initWithFrame:CGRectMake(3.f+leftCircleView.frame.size.width,startY, leftLen, dy)
                                                  andGradientColors:[NSArray arrayWithObjects:[UIColor redColor], [UIColor yellowColor], nil]
                                                   andOutsideBorder:YES
                                                        andVertical:NO];
        // Display
        [self addSubview:leftProcessView];
        
        rightProcessView = [[AMProgressView alloc] initWithFrame:CGRectMake(230-rightLen,startY,rightLen, dy)
                                              andGradientColors:[NSArray arrayWithObjects:[UIColor redColor], [UIColor yellowColor], nil]
                                               andOutsideBorder:YES
                                                    andVertical:NO];
        // Display
        [self addSubview:rightProcessView];
        
        
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
