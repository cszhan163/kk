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
//@property(nonatomic,strong)UIColor *backgroundColor;
@property(nonatomic,strong)UIImage *bgImage;
@property(nonatomic,assign)CGFloat  xStep;
@property(nonatomic,assign)CGFloat  yStep;
@property(nonatomic,assign)CGFloat  offsetY;
@property(nonatomic,assign)CGFloat  offsetX;
@property(nonatomic,assign)CGFloat  maxLenY;
@property(nonatomic,strong)NSArray *pointsData;
@property(nonatomic,strong)NSMutableArray *linesArray;
@end
@implementation ZCSDrawLineView
@synthesize xStep   =_xStep;
@synthesize yStep   = _yStep;
@synthesize offsetY = _offsetY;
@synthesize offsetX = _offsetX;
@synthesize drawLineColors = _drawLineColors;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = [UIColor clearColor];
        _xStep = 1.0;
        _yStep = 1.0;
        //_backgroundColor = [UIColor clearColor];
        _drawLineColor = [UIColor whiteColor];
        //self.linesArray =
        // Initialization code
    }
    return self;
}
- (void)setBackgroundImage:(UIImage *)image{
    self.bgImage = image;
    [self setNeedsDisplay];
}
- (void)updateDrawLineData:(NSArray*)data{
    self.pointsData = data;
    //[self setNeedsDisplay];
}
- (void)addDrawLineData:(NSArray*)data{
    if(self.linesArray == nil){
        self.linesArray = [NSMutableArray array];
    }
    [self.linesArray addObject:data];
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
    CGContextSaveGState (context);
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    //CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    CGContextFillRect (context,self.bounds);
     
    CGContextSetBlendMode(context,kCGBlendModeCopy);
    [_bgImage drawInRect:rect];
    
    //[[UIColor brownColor] set];
    //CGPoint linePointsArr[5];
    CGFloat startX =  _offsetX;
    CGFloat  y = _offsetY;
    
    //CGPoint startPoint = CGPointMake(startX, y);
    //CGContextMoveToPoint(context, startX, y);
    for(int j = 0;j<[_linesArray count];j++){
        CGContextBeginPath (context);
        CGContextSetLineWidth(context,4.f);
        UIColor *lineColor = _drawLineColors[j];
        if(lineColor)
            CGContextSetStrokeColorWithColor(context,lineColor.CGColor);
        else
            CGContextSetStrokeColorWithColor(context,_drawLineColor.CGColor);
        _pointsData = [_linesArray objectAtIndex:j];
        for(int i =0;i<[_pointsData count];i++){
            id item = [_pointsData objectAtIndex:i];
            CGFloat xPointItem = [[item objectForKey:@"x"]floatValue];
            CGFloat yPointItem = [[item objectForKey:@"y"]floatValue];
            CGFloat xPoint = xPointItem *_xStep+_offsetX;
            CGFloat yPoint = _maxLenY-(yPointItem *_yStep)+_offsetY;
            //startX = startX+xPoint;
            y = yPoint;
            //linePointsArr[i] = CGPointMake(xPoint,y);
            if(i!=0)
                CGContextAddLineToPoint(context, xPoint, y);
            CGContextMoveToPoint(context, xPoint, y);
            
        }
        CGContextStrokePath(context);
    }
   
    CGContextRestoreGState(context);
    //CGContext
}
@end
