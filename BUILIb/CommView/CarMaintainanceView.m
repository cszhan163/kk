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

#define kMaxProcessLen  84.f

#define kMaxDayLen      120
#define kMaxDistance    1000

#define kPendingX   3.f
#define kProcessHeight  5.f
#define kRadius         8.f
#define kRightProcessX  (245.f-2*kRadius-kPendingX)
@interface  CarMaintainanceView(){
    AMProgressView      *leftProcessView;
    AMProgressView      *rightProcessView;
    AMArcColorDrawView    *circleProcessView;
    UIImageView           *centerView;
    CGFloat             rightLen;
    CGFloat             leftLen;
    UILabel         *runDistanceLabel;
    UILabel         *runDaysLabel;
}
@end
@implementation CarMaintainanceView

//- (id)getCircleViewController{
//    return
//}
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
        CGFloat startX = 3.f;
        CGFloat currX = startX;
        CGFloat currY = 17.f;
        AMArcColorDrawView *leftCircleView = [[AMArcColorDrawView alloc]initWithFrame:CGRectMake(currX,currY,20,20)];
        leftCircleView.radius = 8;
        leftCircleView.backgroundColor = [UIColor clearColor];
        [leftCircleView gradientColorWithRed:44.f green:100.f  blue:0.f];
        CGFloat colors[] = {
            44./255.f,100.f/255,0,
        };
        //[leftCircleView setGradientColor:colors];
        [self addSubview:leftCircleView];
        SafeRelease(leftCircleView);
       
        currX = kRightProcessX;
        AMArcColorDrawView *rightCircleView = [[AMArcColorDrawView alloc]initWithFrame:CGRectMake(currX,currY,20,20)];
        rightCircleView.radius = 8;
        rightCircleView.backgroundColor = [UIColor clearColor];
        [rightCircleView gradientColorWithRed:44.f green:100.f  blue:0.f];
        [self addSubview:rightCircleView];
        SafeRelease(rightCircleView);
        
        //CGFloat leftLen = 60.f;
       
        CGFloat startY = bgView.frame.size.height/2.f -kProcessHeight/2.f;
        leftProcessView = [[AMProgressView alloc] initWithFrame:CGRectMake(startX+leftCircleView.radius*2+1,startY, leftLen, kProcessHeight)
                                                  andGradientColors:[NSArray arrayWithObjects:[UIColor yellowColor], [UIColor redColor], nil]
                                                   andOutsideBorder:YES
                                                        andVertical:NO];
        // Display
        [self addSubview:leftProcessView];
        SafeRelease(leftProcessView);
        
        rightProcessView = [[AMProgressView alloc] initWithFrame:CGRectMake(kRightProcessX-rightLen+5.f,startY,rightLen, kProcessHeight)
                                              andGradientColors:[NSArray arrayWithObjects:[UIColor redColor], [UIColor yellowColor], nil]
                                               andOutsideBorder:YES
                                                    andVertical:NO];
        // Display
        [self addSubview:rightProcessView];
        SafeRelease(rightProcessView);
        
        
#if 0
        circleProcessView = [[AMArcColorDrawView alloc]initWithFrame:CGRectMake(0.f,0.f,50,50)];
        circleProcessView.radius = 22;
        circleProcessView.backgroundColor = [UIColor clearColor];
        [circleProcessView gradientColorWithRed:100.f green:0.f  blue:0.f];
        [self addSubview:circleProcessView];
        circleProcessView.center = CGPointMake(image.size.width/4.f, image.size.height/4.f);
        SafeRelease(circleProcessView);
        [self bringSubviewToFront:circleProcessView];
#else
        centerView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f,45,45)];
        centerView.center = CGPointMake(image.size.width/4.f, image.size.height/4.f);
        UIImageWithFileName(UIImage *bgImage, @"matain_normal.png");
        centerView.image = bgImage;
        [self addSubview:centerView];
        SafeRelease(centerView);
#endif
        
        [self bringSubviewToFront:leftCircleView];
        [self bringSubviewToFront:rightCircleView];
        
        
        CGFloat textWidth = 80.f;
        CGFloat textHeight = 80.f;
        currY = currY+leftCircleView.frame.size.height-20; //10.f;
        CGRect rect = CGRectMake(rightCircleView.frame.origin.x-30.f,currY ,textWidth,textHeight);
        runDistanceLabel = [UIComUtil createLabelWithFont:kUserDigiFontSize(12) withTextColor:[UIColor whiteColor] withText:@"000\nkm" withFrame:rect];
        [self addSubview:runDistanceLabel];
        SafeRelease(runDistanceLabel);
        rect = CGRectMake(leftCircleView.frame.origin.x-30.f,currY,textWidth,textHeight);
        runDaysLabel = [UIComUtil createLabelWithFont:kUserDigiFontSize(12) withTextColor:[UIColor whiteColor] withText:@"000\n天" withFrame:rect];
        [self addSubview:runDaysLabel];
        SafeRelease(runDaysLabel);
        
    }
    return self;
}
- (void)setLeftProcessDay:(CGFloat)lLen rightDistance:(CGFloat)rLen{
    [runDaysLabel setText:[NSString stringWithFormat:@"%d\n天",(int)lLen]];
    [runDistanceLabel setText:[NSString stringWithFormat:@"%0.02lf\nkm",rLen]];
}
/*
- (void)setLeftGraydientColors:(NSArray*)larray rightGrayDientColors:(NSArray*)rarray{
    leftProcessView.gradientColors = larray;
    [leftProcessView setNeedsDisplay];

}
*/
- (void)setCenterImageView:(UIImage*)image{
    centerView.image = image;

}
- (void)setLeftProcessLen:(CGFloat)lLen rightLen:(CGFloat)rLen{
    leftLen = lLen/kMaxProcessLen *kMaxProcessLen;
    if(leftLen>=kMaxProcessLen) leftLen = kMaxProcessLen;
    rightLen = rLen/kMaxProcessLen *kMaxProcessLen;
    if(rightLen>=kMaxProcessLen) rightLen = kMaxProcessLen;
    //[self setNeedsDisplay];
     
    CGRect leftRect = leftProcessView.frame;
    leftProcessView.frame = CGRectMake(leftRect.origin.x, leftRect.origin.y, leftLen, leftRect.size.height);
    CGRect rightRect = rightProcessView.frame;
    rightProcessView.frame = CGRectMake(kRightProcessX-rightLen+2.f, rightRect.origin.y, rightLen, rightRect.size.height);
    [rightProcessView setNeedsDisplay];
    [leftProcessView setNeedsDisplay];
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
