//
//  UICustomActionAlertView.m
//  VoiceInput
//
//  Created by cszhan on 13-6-9.
//  Copyright (c) 2013年 DragonVoice. All rights reserved.
//

#import "UICustomActionAlertView.h"

#define kPengdingY   45.f
#define kLeftPendingX 30.f

#define kItemPendingX 35.f
#define kItemPendingY 18.f

#define iconItemTextPendingY 8.f


#define kAlertViewWidth           320.f
#define kAlertViewHeight          (556/2.f)

#define kAlertViewSubHeight       120.f

static NSString* iconItemTextArray[] = {@"微信",@"朋友圈",@"更多"};
//static NSString* funItemTextArray[] = {@"自动发送",@""};
static NSString* sharredArray[] = {@"wechatsime",@"Friends",@"add"};
static NSString* commonArray[] = {@"bar1_100stretch",@"bar2_100stretch"};
@interface UICustomActionAlertView(){
    UIImageView *alerActionView;
    UIButton *autoSendButton;
}
@end
@implementation UICustomActionAlertView
@synthesize delegate;
@synthesize subStatus;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (id )initMoreAlertActionView:(CGRect)frame  subViewStatus:(BOOL)status{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0 green:0. blue:0.f alpha:0.5];
        self.subStatus = status;
        if(status){
            [self initSubMoreAlertUI:frame];
        }
        else {
            [self initMoreAlertUI:frame];
        }
    }
    return self;
}

- (void)initSubMoreAlertUI:(CGRect)frame{
    alerActionView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,frame.size.height,kAlertViewWidth, kAlertViewSubHeight)];
    alerActionView.userInteractionEnabled = YES;
    UIImageWithFileName(UIImage *bgImage, @"more_bk@2x.png");
    assert(bgImage);
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(60.f,0.f,0.f,0.f)];
    alerActionView.image = bgImage;
    CGFloat currY = alerActionView.frame.size.height/2.f-21.f;
    CGFloat currX = 22.f;
    int len = sizeof(commonArray)/sizeof(commonArray[0]);
    for(int i = 0;i<len;i++){
        NSString *normalFileName = [NSString stringWithFormat:@"%@@2x.png",commonArray[i]];//
        NSString *hilightFileName = [NSString stringWithFormat:@"%@_hl@2x.png",commonArray[i]];
        UIImageWithFileName(UIImage *normalImage, normalFileName);
        UIImageWithFileName(UIImage *hilightImage, hilightFileName);
        
        assert(normalImage);
        assert(hilightImage);
        //NSLog(@"%lf",normalImage.size.height,normalImage.scale);
        normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.f,30,0.f,30.f)];
        hilightImage = [hilightImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.f,30,0.f,30.f)];
        //NSLog(@"%lf",normalImage.size.height,normalImage.scale);
        /*
         NSString *title = @"";
         UIColor *shwColor = kWhiteHalfColor;
         if(i == 1){
         title = @"取消";
         shwColor = kBlackHalfColor;
         }
                */
        
        
        NSString *title = @"开启";
        UIColor *shwColor = kWhiteHalfColor;
        if(i == 1){
             title = @"取消";
             shwColor = kBlackHalfColor;
        }
        UIButton *item = [UIComUtil createButtonWithNormalBGImage:normalImage withHightBGImage:hilightImage  withTitle:title withTag:i];
        [alerActionView addSubview:item];
        if(i== 0)
            autoSendButton = item;
        
        if(i == 0){
            
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        }
        [UIComUtil shadowUIButtonText:item withShowdowColor:shwColor withShadowOffset:CGSizeMake(1.f,1.f)];
        
        
        item.tag = i;
        item.frame = CGRectMake(currX,currY,123.f,43.f);
        currX+= item.frame.size.width + 30.f;
        [item addTarget:self action:@selector(didPressFunButton:)  forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:alerActionView];
    SafeRelease(alerActionView);

}
- (void)initMoreAlertUI:(CGRect)frame{

    alerActionView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,frame.size.height-kAlertViewHeight,kAlertViewWidth, kAlertViewHeight)];
    alerActionView.userInteractionEnabled = YES;
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"more_bk@2x.png");
    assert(bgImage);
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(60.f,0.f,0.f,0.f)];
    alerActionView.image = bgImage;
    
    UIButton *item = nil;
    CGFloat currX = 0.f;
    
    UILabel *sharedTitle = [[UILabel alloc]initWithFrame:CGRectZero];
    sharedTitle.text = @"分享软件给朋友";
    [UIComUtil shadowUILabelText:sharedTitle withShowdowColor:kBlackHalfColor withShadowOffset:CGSizeMake(-1.0, -1.0)];
    sharedTitle.font = [UIFont systemFontOfSize:18];
    sharedTitle.textAlignment = NSTextAlignmentLeft;
    sharedTitle.textColor = [UIColor whiteColor];
    [alerActionView addSubview:sharedTitle];
    SafeRelease(sharedTitle);
    sharedTitle.frame = CGRectMake(18.f,14.f,200,24.f);
    sharedTitle.backgroundColor = [UIColor clearColor];
    
    
    currX = currX + kLeftPendingX;
    int len = sizeof(sharredArray)/sizeof(sharredArray[0]);
    for(int i = 0;i< len ;i++){
        NSString *normalFileName = sharredArray[i];
        NSString *hilightFileName = [NSString stringWithFormat:@"%@_hl.png",normalFileName];
        item = [UIComUtil createButtonWithNormalBGImageName:[NSString stringWithFormat:@"%@.png",normalFileName] withHightBGImageName:hilightFileName withTitle:@"" withTag:i];
        [alerActionView addSubview:item];
        item.frame = CGRectMake(currX,kPengdingY,item.frame.size.width,item.frame.size.height);
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        textLabel.text = iconItemTextArray[i];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        [UIComUtil shadowUILabelText:textLabel withShowdowColor:kBlackHalfColor withShadowOffset:CGSizeMake(-1.0, -1.0)];
        [alerActionView addSubview:textLabel];
        SafeRelease(textLabel);
        textLabel.frame = CGRectMake(item.frame.origin.x,item.frame.origin.y+item.frame.size.height+ iconItemTextPendingY,item.frame.size.width,20.f);
        textLabel.backgroundColor = [UIColor clearColor];
        currX += item.frame.size.width + kItemPendingX;
        item.tag = i;
        [item addTarget:self action:@selector(didPressSharedButton:)  forControlEvents:UIControlEventTouchUpInside];
    }
    len = sizeof(commonArray)/sizeof(commonArray[0]);
    currX = 21.f;
    CGFloat currY = alerActionView.frame.size.height/2.f+10.f;
    for(int i = 0;i<len;i++){
        NSString *normalFileName = [NSString stringWithFormat:@"%@@2x.png",commonArray[i]];//
        NSString *hilightFileName = [NSString stringWithFormat:@"%@_hl@2x.png",commonArray[i]];
        UIImageWithFileName(UIImage *normalImage, normalFileName);
        UIImageWithFileName(UIImage *hilightImage, hilightFileName);
        
        assert(normalImage);
        assert(hilightImage);
        //NSLog(@"%lf",normalImage.size.height,normalImage.scale);
        normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.f,30,0.f,30.f)];
        hilightImage = [hilightImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.f,30,0.f,30.f)];
        //NSLog(@"%lf",normalImage.size.height,normalImage.scale);
        
        NSString *title = @"";
        UIColor *shwColor = kWhiteHalfColor;
        if(i == 1){
            title = @"取消";
            shwColor = kBlackHalfColor;
        }
        item = [UIComUtil createButtonWithNormalBGImage:normalImage withHightBGImage:hilightImage  withTitle:title withTag:i];
        if(i == 0){
        
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        }
        [UIComUtil shadowUIButtonText:item withShowdowColor:shwColor withShadowOffset:CGSizeMake(1.f,1.f)];
        
        [alerActionView addSubview:item];
        if(i== 0)
            autoSendButton = item;
        item.tag = i;
        item.frame = CGRectMake(currX,currY,kDeviceScreenWidth-2*currX,43.f);
        currY+= item.frame.size.height + kItemPendingY;
        [item addTarget:self action:@selector(didPressFunButton:)  forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:alerActionView];
    SafeRelease(alerActionView);

}
#pragma -
#pragma mark button action

- (void)didPressSharedButton:(UIButton*)sender{
    if(delegate && [delegate respondsToSelector:@selector(didTouchItem:)]){
        [delegate didTouchItem:sender];
    }
    [self disMissAlertView:YES];
}
- (void)didPressFunButton:(UIButton*)sender{
//NSMutableAttributedString
    [self disMissAlertView:YES];
    if(delegate && [delegate respondsToSelector:@selector(didTouchFunItem:withItem:)]){
        [delegate didTouchFunItem:self withItem:sender];
    }
    
}
- (void)showAlertActionViewStatus:(BOOL)isShow animated:(BOOL)animation{
    CGFloat dy = alerActionView.frame.size.height;
    if(isShow){
        dy = -dy;
    }
    else{
        
    }
    if(animation){
        [UIView animateWithDuration:0.3 animations:^(){
            alerActionView.frame = CGRectOffset(alerActionView.frame,0.f,dy);
            if(isShow)
                self.alpha = 1.f;
            else
                self.alpha = 0.f;
        }];
    }
    else{
        alerActionView.frame = CGRectOffset(alerActionView.frame,0.f,dy);
        if(isShow)
            self.alpha = 1.f;
        else
            self.alpha = 0.f;
    }
}
- (void)disMissAlertView:(BOOL)animatied{
    [self showAlertActionViewStatus:NO animated:animatied];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[touches allObjects ] objectAtIndex:0];
    CGPoint point = [touch locationInView:alerActionView];
    if(point.y<0){
        [self disMissAlertView:YES];
    }
    return;
   
}
- (void)didTouchOtherView:(NSString*)string{


}
- (void)setAutoSendButton:(NSString*)text{
    [autoSendButton setTitle:text forState:UIControlStateNormal];
    [autoSendButton setTitle:text forState:UIControlStateHighlighted];
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
