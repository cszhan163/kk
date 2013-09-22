
//
//  NEAlertTextView.m
//  MP3Player
//
//  Created by cszhan on 12-2-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ZCSAlertInforView.h"
#import <QuartzCore/QuartzCore.h>
#include "UIParamsCfg.h"
#define kLeftPendingX 10.f
#define kTopPendingY 5.f
@interface ZCSAlertInforView()
@property(nonatomic,assign)BOOL isWindowAlert;
@property(nonatomic,retain)UIImageView *animationView;
@property(nonatomic,retain)UILabel *label;
@end
@implementation ZCSAlertInforView
//@synthesize label;
@synthesize isTextCenter;
@synthesize delegate;
@synthesize text;
@synthesize isHiddenAuto;
@synthesize isWindowAlert;
@synthesize animationView;
@synthesize isTouchHidden;
@synthesize hiddenAfterTimerDuration;
@synthesize label;
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        hiddenAfterTimerDuration = 2.5;
        isTouchHidden = NO;
        isTextCenter =  NO;
    }
    return self;
}
- (void)setBGContent:(UIImage*)image{
    self.layer.contents = (id)[image CGImage];
}
-(id)initWithFrame:(CGRect)frame withText:(NSString*)text{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.frame = CGRectMake(0.f, 0.f, 160.f, 40.f);
		self.text = text;
		label = [[UILabel alloc]initWithFrame:CGRectMake(kLeftPendingX, kTopPendingY, self.frame.size.width-kLeftPendingX*2, self.frame.size.height-kTopPendingY*2)];
		label.text = text;
        label.numberOfLines = 0;
		label.font = kPlayViewTopBarTileFont;//[UIFont b:14];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		label.center = self.center;
		self.backgroundColor = [UIColor blackColor];
		self.alpha = 1;
        // if(isWindow)
        {
            //self.windowLevel = UIWindowLevelAlert;
            isWindowAlert  = YES;
        }
        isHiddenAuto = YES;
		[self addSubview:label];
		[label release];
    }
    return self;
    
}
-(id)initWithFrame:(CGRect)frame withText:(NSString*)text isWindow:(BOOL)isWindow{
	self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		//self.frame = CGRectMake(0.f, 0.f, 160.f, 40.f);
		self.text = text;
		label = [[UILabel alloc]initWithFrame:CGRectMake(kLeftPendingX, kTopPendingY, self.frame.size.width-kLeftPendingX*2, self.frame.size.height-kTopPendingY*2)];
		label.text = text;
		label.font = kPlayViewTopBarTileFont;//[UIFont b:14];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		label.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        label.numberOfLines = 0;
		self.backgroundColor = [UIColor blackColor];
		self.alpha = 0;
        if(isWindow)
        {
            //self.windowLevel = UIWindowLevelAlert;
            isWindowAlert  = YES;
        }
		[self addSubview:label];
		[label release];
    }
    return self;
	
}
-(id)initWithFrame:(CGRect)frame withText:(NSString *)_text withImages:(NSArray*)imageArr
{
    self.text = _text;
    if(self = [self initWithFrame:frame withText:self.text isWindow:NO])
    {
        self.frame = frame;
        label.frame = CGRectMake(40+9.f,36.f/2.f,46.f,18.f/2.f);
        label.textAlignment = UITextAlignmentLeft;
        //label.font = kAppTextBoldSystemFont(9.f);
        label.textColor = [UIColor whiteColor];
        self.animationView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
        self.animationView.image = [imageArr objectAtIndex:0];
        animationView.animationImages = imageArr;
        animationView.userInteractionEnabled = YES;
        animationView.frame = CGRectMake(24.f/2.f,18.f/2.f, 56./2.f, 36/2.f);
        [self addSubview:animationView];
        //[animationView release];
        self.frame = CGRectOffset(self.frame,0.f, self.frame.size.height);
        self.alpha = 0.77;
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 5.f;
        self.clipsToBounds = YES;
        isTextCenter = NO;
    }
    return self;

}
-(void)startShowImageAnimation:(NSTimeInterval)duration
{
    [animationView startAnimating];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
					 animations:^
     {
         self.frame = CGRectOffset(self.frame, 0.f,-self.frame.size.height);
     } 
					 completion:^(BOOL finished)
     { 
         
         
     }
	 ];
    
}
-(void)stopShowImageAnimation:(NSTimeInterval)duration
{
    [animationView stopAnimating];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
					 animations:^
     {
         self.frame = CGRectOffset(self.frame, 0.f,self.frame.size.height);
     } 
					 completion:^(BOOL finished)
     { 
         
         [self removeFromSuperview];
     }
	 ];
    
}

-(void)setTextFont:(UIFont*)font
{
    label.font = font;
}
-(void)show
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if(isWindowAlert)
    {
        [self makeKeyWindow];
        [self makeKeyAndVisible];
    }
	self.alpha = 0.f;
	//[[UIApplication sharedApplication]keyWindow]
	[UIView animateWithDuration:0.5
                    delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
					 animations:^
     {
         self.alpha = 0.9f;
         //self.layer.cornerRadius = 5.f;
     }
					 completion:^(BOOL finished)
     { 
         
         
     }
	 ];
    if(isHiddenAuto)
        [self performSelector:@selector(hiddenAuto) withObject:nil afterDelay:hiddenAfterTimerDuration];
}
- (void)dissMiss
{
    self.alpha = 0.f;
}
- (void)hiddenAfterDelay:(NSTimeInterval)duration
{
    //[self performSelector:@selector(hiddenAuto) withObject:nil afterDelay:duration];
    [self performSelector:@selector(hiddenUpAnimation) withObject:nil afterDelay:duration];
}
-(void)hiddenAuto
{
	[UIView animateWithDuration:0.8
                     delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
					 animations:^
	 {  
         self.alpha = 0;
         
     } 
					 completion:^(BOOL finished)
	 { 
         if(delegate&&[delegate respondsToSelector:@selector(didAutoDissMiss:)])
         {
             [delegate didAutoDissMiss:self];
         }
	 }
	 ];
    if(isWindowAlert)
    {
        [self resignKeyWindow];
    }
}
-(void)hiddenUpAnimation
{
    [UIView animateWithDuration:0.8
                    delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
					 animations:^
	 {  
        
         self.frame = CGRectOffset(self.frame, 0,-self.frame.size.height);
        } 
					 completion:^(BOOL finished)
	 { 
        
          self.alpha = 0;
         
	 }
	 ];
}
-(void)layoutSubviews
{
	[super layoutSubviews];
    label.text = text;
	//self.center = CGPointMake(kDeviceScreenWidth/2, kDeviceScreenHeight/2);
	//label.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
//	NE_LOGRECT(label.frame);
//    NE_LOGRECT(self.frame);
    if(isTextCenter)
    {
        CGSize size = [label.text sizeWithFont:label.font
                             constrainedToSize:self.frame.size];
        label.bounds = CGRectMake(0, 0, size.width, size.height);
        label.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code.
	//[UIFont ];
	[super drawRect:rect];
}

- (void)dealloc {
    self.animationView = nil;
	self.text = nil;
    [super dealloc];
}
#if 0
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    /*
    UIView *parent = [self superview];
    if(parent == self)
    {
        return  [[[parent superview] hitTest:point withEvent:event] ;]
    }
    */
    //if(CGRectContainsPoint(, point))
    //return  [parent hitTest:point withEvent:event];
}
#endif
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    if(isTouchHidden)
        [self dissMiss];
    if(delegate&&[delegate respondsToSelector:@selector(didAutoDissMiss:)])
    {
        [delegate didAutoDissMiss:self];
    }
    //[super touchesBegan:touches withEvent:event];
    
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
