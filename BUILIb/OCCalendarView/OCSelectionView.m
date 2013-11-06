//
//  OCSelectionView.m
//  OCCalendar
//
//  Created by Oliver Rickard on 3/30/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OCSelectionView.h"
@implementation StructPoint
@synthesize mEndX;
@synthesize mStartX;
@synthesize mEndY;
@synthesize mStartY;
@synthesize mTag;
@synthesize color;
@end
@interface OCSelectionView()

@property(nonatomic,strong)  NSMutableArray *colorArray;
@end

@implementation OCSelectionView
@synthesize  colorArray;
@synthesize selectionMode = _selectionMode;
@synthesize selected;
@synthesize selectorPoints;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.colorArray = [NSMutableArray array];
        selected = YES;
        startCellX = -1;
        startCellY = -1;
        endCellX = -1;
        endCellY = -1;
        
		hDiff = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 41 : 43;
        vDiff = 30;
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.selectorPoints = [NSMutableArray array];
        [self initColorData];
    }
    return self;
}
- (void)initColorData{

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor* color = [UIColor blueColor];//[UIColor colorWithPatternImage:image];//[UIColor colorWithRed: 0.82 green: 0.08 blue: 0 alpha: 0.86];
    UIColor* color2 = color;//[UIColor colorWithPatternImage:image];//[UIColor colorWithRed: 0.66 green: 0.02 blue: 0.04 alpha: 0.88];
    NSArray* gradient3Colors = [NSArray arrayWithObjects:
                                (id)color.CGColor,
                                (id)color2.CGColor, nil];
    CGFloat gradient3Locations[] = {0, 1};
    CGGradientRef gradient3 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradient3Colors, gradient3Locations);
    [colorArray addObject:gradient3];
    CGGradientRelease(gradient3);
    
    
    UIColor* color3 = [UIColor yellowColor];
    UIColor* color4 = [UIColor yellowColor];
    NSArray* gradient4Colors = [NSArray arrayWithObjects:
                                (id)color3.CGColor,
                                (id)color4.CGColor, nil];
    CGFloat gradient4Locations[] = {0, 1};
    
    
    
    CGGradientRef gradient4 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient4Colors, gradient4Locations);
    [colorArray addObject:(__bridge id)(gradient4)];
    CGGradientRelease(gradient4);
    
    
    
    color3 = [UIColor whiteColor];
    color4 = [UIColor whiteColor];
    gradient4Colors = [NSArray arrayWithObjects:
                       (id)color3.CGColor,
                       (id)color4.CGColor, nil];
    //CGFloat gradient4Locations= {0, 1};
    
    
    
    gradient4 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradient4Colors, gradient4Locations);
    [colorArray addObject:(__bridge id)(gradient4)];
    CGGradientRelease(gradient4);
     CGColorSpaceRelease(colorSpace);
}
- (BOOL) selected {
    return selected;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NE_LOGFUN;
    if(selected)
    {
        NE_LOG(@"doing selector");
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGColorRef backgroundShadow = [UIColor blackColor].CGColor;
        CGSize backgroundShadowOffset = CGSizeMake(2, 3);
        CGFloat backgroundShadowBlurRadius = 5;
        
        
        UIColor* darkColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.72];
        
      
        
        UIImageWithFileName(UIImage*image, @"ragular_day-mid.png");
    
        
        
       
#if 1
        for(int i = 0;i<[self.selectorPoints count];i++)
        {
            
            
            StructPoint *item = [self.selectorPoints objectAtIndex:i];
            startCellY = item.mStartY;
            endCellY = item.mEndY;
            startCellX = item.mStartX;
            endCellX = item.mEndX;
            CGGradientRef gradientColor = (__bridge CGGradientRef)([self.colorArray objectAtIndex:item.mTag]);
            //gradientColor = item.color;
#else
            {
             CGGradientRef gradientColor = [colorArray objectAtIndex:0];
            
            
#endif
            int tempStart = MIN(startCellY, endCellY);
            int tempEnd = MAX(startCellY, endCellY);
            for(int i = tempStart; i <= tempEnd; i++) {
                //// selectedRect Drawing
                int thisRowEndCell;
                int thisRowStartCell;
                if(startCellY == i) {
                    thisRowStartCell = startCellX;
                    if (startCellY > endCellY) {
                        thisRowStartCell = 0; thisRowEndCell = startCellX;
                    }
                } else {
                    thisRowStartCell = 0;
                }
                
                if(endCellY == i) {
                    thisRowEndCell = endCellX;
                    
                    if (startCellY > endCellY) {
                        thisRowStartCell = endCellX; thisRowEndCell = 6;
                    }
                } else if (!(startCellY > endCellY)) {
                    thisRowEndCell = 6;
                }
                CGFloat cornerRadius;
                if(_selectionMode == OCSelectionSingleDate) {
                    cornerRadius = 0.0;
                } else {
                    cornerRadius = 10.0;
                }
                //// selectedRect Drawing
                float width_offset= UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 25 : 20; //device specific width offset i.e., iPhone vs iPad
                UIBezierPath* selectedRectPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(MIN(thisRowStartCell, thisRowEndCell)*hDiff, i*vDiff, (ABS(thisRowEndCell-thisRowStartCell))*hDiff+width_offset, 21) cornerRadius: cornerRadius];
                CGContextSaveGState(context);
                [selectedRectPath addClip];
                CGContextDrawLinearGradient(context, gradientColor, CGPointMake((MIN(thisRowStartCell, thisRowEndCell)+.5)*hDiff, (i+1)*vDiff), CGPointMake((MIN(thisRowStartCell, thisRowEndCell)+.5)*hDiff, i*vDiff), 0);
                CGContextRestoreGState(context);
                
                CGContextSaveGState(context);
                CGContextSetShadowWithColor(context, backgroundShadowOffset, backgroundShadowBlurRadius, backgroundShadow);
                [darkColor setStroke];
                selectedRectPath.lineWidth = 0.5;
                [selectedRectPath stroke];
                CGContextRestoreGState(context);
            }
            
            //CGGradientRelease(gradientColor);
           
            
            
        }
        
    }
}

-(void) singleSelection:(NSSet *)touches {
    self.selected = YES;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    startCellX = MIN((int)(point.x)/hDiff,6);
    startCellY = (int)(point.y)/vDiff;
    
    endCellX = MIN(startCellX,6);
    endCellY = startCellY;
    
    [self setNeedsDisplay];
    
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self singleSelection:touches];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    if(_selectionMode == OCSelectionSingleDate) {
//        [self singleSelection:touches];
//        return;
//    }
//    UITouch *touch = [touches anyObject];
//    
//    CGPoint point = [touch locationInView:self];
//    
//    if(CGRectContainsPoint(self.bounds, point)) {
//        endCellX = MIN((int)(point.x)/hDiff,6);
//        endCellY = (int)(point.y)/vDiff;
//        
//        [self setNeedsDisplay];
//    }
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    if(_selectionMode == OCSelectionSingleDate) {
//        [self singleSelection:touches];
//        return;
//    }
//    UITouch *touch = [touches anyObject];
//    
//    CGPoint point = [touch locationInView:self];
//    
//    if(CGRectContainsPoint(self.bounds, point)) {
//        endCellX = MIN((int)(point.x)/hDiff,6);
//        endCellY = (int)(point.y)/vDiff;
//        
//        [self setNeedsDisplay];
//    }
//}

-(void)resetSelection {
    startCellX = -1;
    startCellY = -1;
    endCellY = -1;
    endCellX = -1;
    selected = NO;
    [self.selectorPoints removeAllObjects];
    [self setNeedsDisplay];
}

-(CGPoint)startPoint {
    return CGPointMake(startCellX, startCellY);
}

-(CGPoint)endPoint {
    return CGPointMake(endCellX, endCellY);
}

- (void)setStartPoint:(CGPoint)sPoint {
    startCellX = sPoint.x;
    startCellY = sPoint.y;
    selected = YES;
    [self setNeedsDisplay];
}
- (void)addPointSetWithStartPoint:(CGPoint)sPoint andEndPoint:(CGPoint)ePoint withTag:(int)tag{
    StructPoint *points = [[StructPoint alloc]init];
    points.mStartX = sPoint.x;
    points.mStartY = sPoint.y;
    points.mEndX = ePoint.x;
    points.mEndY = ePoint.y;
    points.mTag = tag;
    [self.selectorPoints addObject:points];
    SafeRelease(points);
}
-(void)setEndPoint:(CGPoint)ePoint {
    endCellX = ePoint.x;
    endCellY = ePoint.y;
    selected = YES;
    [self setNeedsDisplay];
}

@end
