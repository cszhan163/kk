//
//  DAMultipleProgressLayer.m
//  DACircularProgressExample
//
//  Created by cszhan on 13-9-21.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "DAMultipleProgressLayer.h"
@interface DAMultipleProgressLayer()
@property(nonatomic,strong)NSMutableArray *mutiplePrecentTrackArray;
@end
@implementation DAMultipleProgressLayer
@synthesize mutiplePrecentTrackArray;
@synthesize thicknessRatio;
@synthesize trackTintColor;
@synthesize progressTintColor;
- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    
        self.mutiplePrecentTrackArray = [NSMutableArray array];
    }
    return self;
}
//+ (Class)layerClass
//{
//    return [DAMultipleProgressLayer class];
//}

- (DAMultipleProgressLayer *)circularProgressLayer
{
    return (DAMultipleProgressLayer *)self.layer;
}
- (void)addMutiplePecentTrackData:(NSDictionary*)data{


}
- (void)addMutiplePecentTrackWithPercent:(int)percent withColor:(UIColor*)color{

    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:percent],@"percent",
                          [NSNumber numberWithFloat:(3*M_PI_2)],@"angle",
                          
                          color,@"color",
                           nil];
    [self.mutiplePrecentTrackArray addObject:item];
}
- (void)addMutiplePecentTrackWithPercent:(int)percent withColor:(UIColor*)color withClocksize:(BOOL)tag{
    
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:percent],@"percent",
                          [NSNumber numberWithFloat:(3*M_PI_2)],@"angle",
                          [NSNumber numberWithBool:tag],@"clockwize",
                          color,@"color",
                          nil];
    [self.mutiplePrecentTrackArray addObject:item];
}
- (void)drawRect:(CGRect)rect{

     CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInContext:context];
}
- (void)drawInContext:(CGContextRef)context{
    

    //CGContextRef context = CGContext
    CGRect rect = self.bounds;
    CGPoint centerPoint = CGPointMake(rect.size.height / 2.0f, rect.size.width / 2.0f);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2.0f;
    
    //CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
   
    
    //for all
    CGContextSetFillColorWithColor(context, self.trackTintColor.CGColor);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, 3.0f * M_PI_2, -M_PI_2, NO);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    [self drawPercentPart:context];
//    if (progress > 0.0f)
//    {
//        CGContextSetFillColorWithColor(context, self.progressTintColor.CGColor);
//        CGMutablePathRef progressPath = CGPathCreateMutable();
//        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
//        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, 3.0f * M_PI_2, radians, NO);
//        CGPathCloseSubpath(progressPath);
//        CGContextAddPath(context, progressPath);
//        CGContextFillPath(context);
//        CGPathRelease(progressPath);
//    }
//    
//    if (progress > 0.0f && self.roundedCorners)
//    {
//        CGFloat pathWidth = radius * self.thicknessRatio;
//        CGFloat xOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * cosf(radians)));
//        CGFloat yOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * sinf(radians)));
//        CGPoint endPoint = CGPointMake(xOffset, yOffset);
//        
//        CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth / 2.0f, 0.0f, pathWidth, pathWidth));
//        CGContextFillPath(context);
//        
//        CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth / 2.0f, endPoint.y - pathWidth / 2.0f, pathWidth, pathWidth));
//        CGContextFillPath(context);
//    }
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGFloat innerRadius = radius * (1.0f - self.thicknessRatio);
    CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
    CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius * 2.0f, innerRadius * 2.0f));
    CGContextFillPath(context);

}
- (void)drawPercentPart:(CGContextRef)context {
    CGRect rect = self.bounds;
    CGPoint centerPoint = CGPointMake(rect.size.height / 2.0f, rect.size.width / 2.0f);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2.0f;
    CGFloat currAngle = -M_PI_2;
    for(NSDictionary *item in self.mutiplePrecentTrackArray){
        
        CGFloat progress = [[item objectForKey:@"percent"]intValue]/100.f;
        CGFloat startAngle = [[item objectForKey:@"angle"]floatValue];
        UIColor *tinitColor = [item objectForKey:@"color"];
        BOOL isClockWize = [[item objectForKey:@"clockwize"]boolValue];
        isClockWize = NO;
        //CGFloat radians = (progress * 2.0f * M_PI) - M_PI_2;
        CGFloat radians = currAngle+progress*2.f*M_PI;
        CGContextSetFillColorWithColor(context, tinitColor.CGColor);
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, currAngle, radians, isClockWize);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
        currAngle = currAngle+progress*2.f*M_PI;
//        if(currAngle>=2.f*M_PI){
//            currAngle = currAngle-2*M_PI;
//        }
    }

}

@end
