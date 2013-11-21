//
//  UIShareActionAlertView.m
//  BodCarManger
//
//  Created by cszhan on 13-11-9.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UIShareActionAlertView.h"

#define kPengdingY   22.f
#define kLeftPendingX 28.f

#define kItemPendingX 47.f
#define kItemPendingY 18.f

#define iconItemTextPendingY 8.f


#define kAlertViewWidth           320.f
#define kAlertViewHeight          (556/2.f)

#define kAlertViewSubHeight       120.f

#define kBlackHalfColor         HexRGBA(0,0,0,0.5)
#define kWhiteHalfColor         HexRGBA(255,255,255,0.5)

static NSString* iconItemTextArray[] = {@"微信",@"新浪微博",@"腾讯微博"};
//static NSString* funItemTextArray[] = {@"自动发送",@""};
static NSString* sharredArray[] = {@"wechat",@"sina_weibo",@"tencent_weibo"};
static NSString* commonArray[] = {@"share_cancel_btn"};

@implementation UIShareActionAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)initMoreAlertUI:(CGRect)frame{
    
    alerActionView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,frame.size.height-kAlertViewHeight,kAlertViewWidth, kAlertViewHeight)];
    alerActionView.userInteractionEnabled = YES;
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"share_bg.png");
    assert(bgImage);
    //bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(60.f,0.f,0.f,0.f)];
    alerActionView.image = bgImage;
    UIButton *item = nil;
    CGFloat currX = 0.f;    
    
    currX = currX + kLeftPendingX;
    int len = sizeof(sharredArray)/sizeof(sharredArray[0]);
    for(int i = 0;i< len ;i++){
        NSString *normalFileName = sharredArray[i];
        NSString *hilightFileName = [NSString stringWithFormat:@"%@.png",normalFileName];
        item = [UIComUtil createButtonWithNormalBGImageName:[NSString stringWithFormat:@"%@.png",normalFileName] withHightBGImageName:hilightFileName withTitle:@"" withTag:i];
        [alerActionView addSubview:item];
        item.frame = CGRectMake(currX,kPengdingY,item.frame.size.width,item.frame.size.height);
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        textLabel.text = iconItemTextArray[i];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        //[UIComUtil shadowUILabelText:textLabel withShowdowColor:kWhiteHalfColor withShadowOffset:CGSizeMake(-1.0, -1.0)];
        [alerActionView addSubview:textLabel];
        SafeRelease(textLabel);
        textLabel.frame = CGRectMake(item.frame.origin.x,item.frame.origin.y+item.frame.size.height+ iconItemTextPendingY,item.frame.size.width,20.f);
        textLabel.backgroundColor = [UIColor clearColor];
        currX += item.frame.size.width + kItemPendingX;
        item.tag = i;
        [item addTarget:self action:@selector(didPressSharedButton:)  forControlEvents:UIControlEventTouchUpInside];
    }
    len = sizeof(commonArray)/sizeof(commonArray[0]);
    currX = 23.f;
    CGFloat currY = alerActionView.frame.size.height/2.f+10.f;
    for(int i = 0;i<len;i++){
        NSString *normalFileName = [NSString stringWithFormat:@"%@.png",commonArray[i]];//
        NSString *hilightFileName = [NSString stringWithFormat:@"%@.png",commonArray[i]];
        UIImageWithFileName(UIImage *normalImage, normalFileName);
        UIImageWithFileName(UIImage *hilightImage, hilightFileName);
        
        assert(normalImage);
        assert(hilightImage);
        //NSLog(@"%lf",normalImage.size.height,normalImage.scale);
        //normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.f,30,0.f,30.f)];
        //hilightImage = [hilightImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.f,30,0.f,30.f)];
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
        /*
        if(i== 0)
            autoSendButton = item;
         */
        item.tag = i;
        item.frame = CGRectMake(currX,currY,kDeviceScreenWidth-2*currX,43.f);
        currY+= item.frame.size.height + kItemPendingY;
        [item addTarget:self action:@selector(didPressFunButton:)  forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:alerActionView];
    SafeRelease(alerActionView);
    
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
