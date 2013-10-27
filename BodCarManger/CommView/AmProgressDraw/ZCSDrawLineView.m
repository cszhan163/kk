//
//  ZCSDrawLineView.m
//  AMProgressView
//
//  Created by cszhan on 13-10-27.
//  Copyright (c) 2013年 Albert Mata. All rights reserved.
//

#import "ZCSDrawLineView.h"
@interface ZCSDrawLineView(){
}
@property(nonatomic,assign)CGFloat  xStep;
@property(nonatomic,assign)CGFloat  yStep;
@property(nonatomic,strong)NSArray *pointsData;
@end
@implementation ZCSDrawLineView
@synthesize xStep   =_xStep;
@synthesize yStep   = _yStep;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _xStep = 1.0;
        _yStep = 1.0;
        _backgroundColor = [UIColor whiteColor];
        _drawLineColor = [UIColor blackColor];
        // Initialization code
    }
    return self;
}
- (void)updateDrawLineData:(NSArray*)data{
    self.pointsData = data;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawLines:rect];
    //CGContextSetStrokeColor
	//CGContextAddLines(context,linePointsArr,5);
    
}
- (void)drawLines:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    // Drawing code
    CGContextSetFillColorWithColor(context, _backgroundColor.CGColor);
    //CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    CGContextFillRect (context,self.bounds);
    CGContextSetBlendMode(context,kCGBlendModeCopy);
    CGContextBeginPath (context);
    CGContextSetLineWidth(context,4.f);
    CGContextSetStrokeColorWithColor(context,_drawLineColor.CGColor);
    //[[UIColor brownColor] set];
    CGPoint linePointsArr[5];
    CGFloat startX = rect.origin.x;
    CGFloat  y = rect.size.height;
    //CGPoint startPoint = CGPointMake(startX, y);
    CGContextMoveToPoint(context, startX, y);
    for(int i =0;i<[_pointsData count];i++){
        id item = [_pointsData objectAtIndex:i];
        CGFloat xPointItem = [[item objectForKey:@"x"]floatValue];
        CGFloat yPointItem = [[item objectForKey:@"y"]floatValue];
        CGFloat xPoint = xPointItem *_xStep;
        CGFloat yPoint = yPointItem *_yStep;
        startX = startX+xPoint;
        y = yPoint;
        linePointsArr[i] = CGPointMake(startX,y);
        CGContextAddLineToPoint(context, startX, y);
        CGContextMoveToPoint(context, startX, y);
        
    }
    CGContextStrokePath(context);
    //CGContext
}
@end
