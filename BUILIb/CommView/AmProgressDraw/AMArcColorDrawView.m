//
//  AMColorDrawView.m
//  AMProgressView
//
//  Created by cszhan on 13-10-24.
//  Copyright (c) 2013年 Albert Mata. All rights reserved.
//

#import "AMArcColorDrawView.h"

@interface AMArcColorDrawView(){
    CGGradientRef gradient;
}
@property(nonatomic,strong)NSArray *colorArray;
@end
@implementation AMArcColorDrawView

@synthesize colorArray;

- (void)setRadius:(CGFloat)radius{
    _radius = radius;
}
-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self != nil)
	{
        
	}
	return self;
}

-(void) gradientColorWithRed:(CGFloat)aRed green:(CGFloat)aGreen blue:(CGFloat)aBlue
{
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	colorArray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:aRed],[NSNumber numberWithFloat:aGreen],[NSNumber numberWithFloat:aBlue],nil] ;
#if __has_feature(objc_arc)
#else
    [colorArray retain];
#endif
	CGFloat colors[] =
	{
		aRed, aGreen, aBlue, 1,
        aRed, aGreen, aBlue, 1,
		//1, 1, 1, 1.0,
	};
	gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*3));
	CGColorSpaceRelease(rgb);
	self.backgroundColor = [UIColor clearColor];
}
- (void)setGradientColor:(CGFloat*)gradientColors{

    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(rgb, gradientColors, NULL, sizeof(gradientColors)/(sizeof(gradientColors[0])*3));
	CGColorSpaceRelease(rgb);
	self.backgroundColor = [UIColor clearColor];
    
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext(); //1
	
    CGPoint  startPoint, endPoint;
	
    CGAffineTransform myTransform;
	
	float width = self.bounds.size.width;
	
    float height = self.bounds.size.height;
	
	
    startPoint = CGPointMake(0,0.5*height); // Set start point in a scale of 0-1 for x and 0-1 for y. This will be scaled later to the context's width and height.
	
    endPoint = CGPointMake(1*width,0.5*height);// Set ending point in same 0-1 scale. As you can see the gradient will follow a vertical line.
	
//    myTransform = CGAffineTransformMakeScale (width, height);// Create a new scale based on the context's width and height
//    
//    CGContextConcatCTM (context, myTransform);// Concatenates your transform with the actual drawing context
//	
   // myTransform = CGAffineTransformMakeTranslation(0, 1);
	
    CGContextSaveGState (context);// Save the state so you can restore to it later
    
    //CGContextRef c = UIGraphicsGetCurrentContext();
    //CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    //CGContextFillRect (context, CGRectMake(0, 0, 1, 1));
    //CGContextSetRGBStrokeColor(context, 1.0, 0.0f, 0.f, 1.f);
//    CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
//    CGContextSetStrokeColor(context, red);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, 5.0f, 5.0f);
//    CGContextAddLineToPoint(context, 50.0f, 50.0f);
//    CGContextStrokePath(context);
//    CGContextClosePath(context);
#if 1
    
#if 0
    CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    CGContextFillRect (context,self.bounds);
    CGContextSetBlendMode(context,kCGBlendModeCopy);
    CGContextBeginPath (context);
    CGContextSetLineWidth(context,4.f);
    CGContextSetStrokeColorWithColor(context,[UIColor blackColor].CGColor);
    //[[UIColor brownColor] set];
    CGPoint linePointsArr[5];
    CGFloat startX = rect.origin.x;
    int  y = rect.size.height;
    //CGPoint startPoint = CGPointMake(startX, y);
    CGContextMoveToPoint(context, startX, y);
    for(int i =0;i<5;i++){
        int step = rand()%60+10;
        y = rect.size.height-rand()%50;
        startX = startX+step;
        linePointsArr[i] = CGPointMake(startX,y);
        CGContextAddLineToPoint(context, startX, y);
        CGContextMoveToPoint(context, startX, y);
       
    }
    //CGContextSetStrokeColor
	//CGContextAddLines(context,linePointsArr,5);
    CGContextStrokePath(context);
    CGContextClosePath (context);
    //CGContextClip (context);
   // CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
#else
   
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    //CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    //CGContextFillRect (context,self.bounds);
    //CGContextSetStrokeColorWithColor(context,[UIColor yellowColor].CGColor);
//    CGContextStrokeEllipseInRect(context,rect);
    
    //CGContextSetLineWidth(context, _radius);
    CGContextBeginPath (context); // Creates a path and on the next three lines you create the circle, clipping the context so the linear gradient
    // gets drwan only inside the circle.
    CGContextAddArc (context, width/2.f,height/2.f, _radius, 0,
					 
                     2*M_PI, 0); //6.28318531 corresponds to 2*pi which is a whole circle
	//CGContextStrokePath(context);
    CGContextClosePath (context);
    CGContextClip (context);
    
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);// draws the gradient
#endif
#endif	
    CGContextRestoreGState (context); 	//Restore the context to the previously saved state in case you want to do something else.
}

#if __has_feature(objc_arc)
#else
- (void)dealloc {
    [super dealloc];
}
#endif

@end
