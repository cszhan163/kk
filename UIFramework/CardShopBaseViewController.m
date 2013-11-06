//
//  CardShopBaseViewController.m
//  CardShop
//
//  Created by cszhan on 12-9-5.
//  Copyright (c) 2012年 cszhan. All rights reserved.
//

#import "CardShopBaseViewController.h"
#define NO_BTNLABEL
@implementation CardShopBaseViewController
-(void)addObservers
{
    [super addObservers];
    [ZCSNotficationMgr addObserver:self call:@selector(scollerViewWillAppearFromMsg:) msgName:kScrollerViewWillAppear];
    [ZCSNotficationMgr addObserver:self call:@selector(scrollerViewWillDisappearFromMsg:) msgName:kScrollerViewWillDisappear];
}
-(void)viewDidLoad
{
	[super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

}
-(void)initHomePageTimelineNavBar:(CGRect)rect withIndex:(NSInteger)index
{
	//self draw
	NSMutableArray *arr = [NSMutableArray array];
	UIImage  *bgImage = nil;
	//NSString *imgPath = nil;
	/*
	 ＊post blog
	 */
	UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
	/*
	 imgPath = [[NSBundle mainBundle] pathForResource:@"postblog" ofType:@"png"];
	 assert(imgPath);
	 bgImage =  [UIImage imageWithContentsOfFile:imgPath];
	 */
	UIImageWithFileName(bgImage,@"btn-back.png");
	//UIImage *bgImageS = nil;
	//UIImageWithFileName(bg
	[btn setBackgroundImage:bgImage forState:UIControlStateNormal];
	UIImageWithFileName(bgImage,@"btn-back.png");
	[btn setBackgroundImage:bgImage forState:UIControlStateSelected];
	//|UIControlStateHighlighted|UIControlStateSelected
	btn.frame = CGRectMake(kMBAppTopToolXPending,kMBAppTopToolYPending,bgImage.size.width/kScale, bgImage.size.height/kScale);
	//[mainView.mainFramView addSubview:btn];
	NE_LOG(@"btn frame");
	NE_LOGRECT(btn.frame);
	//btn.hidden = YES;
    UILabel *btnTextLabel  = nil;
#ifdef NO_BTNLABEL
#else
#ifdef USE_LABEL
	btnTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(kTopNavItemLabelOffsetX,kTopNavItemLabelOffSetY, btn.frame.size.width,btn.frame.size.height)];
    btnTextLabel.backgroundColor = [UIColor clearColor];
    //btnTextLabel.center =
    btnTextLabel.text = NSLocalizedString(@"Return", @"");
    btnTextLabel.textColor = [UIColor whiteColor];
    btnTextLabel.font = kNavgationItemButtonTextFont;
    btnTextLabel.textAlignment = UITextAlignmentLeft;
    leftText = btnTextLabel;
    [btn addSubview:btnTextLabel];
	[btnTextLabel release];
    
#else
    [btn setTitle:NSLocalizedString(@"Return", @"") forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0.f,13, 0,0.f);
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.leftText = btn.titleLabel;
    self.leftText.font = kNavgationItemButtonTextFont;
#endif
#endif
	[arr addObject:btn];
	self.leftBtn = btn;
	/*
	 * camera
	 */
	btn = [UIButton buttonWithType:UIButtonTypeCustom];
	/*
	 imgPath = [[NSBundle mainBundle] pathForResource:@"camera" ofType:@"png"];
	 assert(imgPath);
	 bgImag =  [UIImage imageWithContentsOfFile:imgPath];
	 */
	//UIImageScaleWithFileName(bgImage,@"camera");
	UIImageWithFileName(bgImage,@"btn_complete.png");
	[btn setBackgroundImage:bgImage forState:UIControlStateNormal];
	
	UIImageWithFileName(bgImage,@"btn_complete.png");
	[btn setBackgroundImage:bgImage forState:UIControlStateSelected];
	
	//|UIControlStateHighlighted|UIControlStateSelected
	btn.frame = CGRectMake(kDeviceScreenWidth-bgImage.size.width/kScale-kMBAppTopToolXPending,kMBAppTopToolYPending,bgImage.size.width/kScale, bgImage.size.height/kScale);
	[arr addObject:btn];
	self.rightBtn = btn;
	//CGRect rect = CGRectMake(0.f, 0.f, kDeviceScreenWidth, kMBAppTopToolBarHeight);
	
#ifdef NO_BTNLABEL
#else
#ifdef USE_LABEL
    btnTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f,kTopNavItemLabelOffSetY, btn.frame.size.width,btn.frame.size.height)];
    btnTextLabel.backgroundColor = [UIColor clearColor];
    //btnTextLabel.center =
    btnTextLabel.text = NSLocalizedString(@"Next", @"");
    btnTextLabel.textColor = [UIColor whiteColor];
    btnTextLabel.font = kNavgationItemButtonTextFont;
    btnTextLabel.textAlignment = UITextAlignmentCenter;
    
    self.rightText = btnTextLabel;
    
    [btn addSubview:btnTextLabel];
    [btnTextLabel release];
#endif
#endif
    
    
	UIImageWithFileName(bgImage,@"titlebar.png");
	NETopNavBar  *tempNavBar= [[NETopNavBar alloc]
							   initWithFrame:rect withBgImage:bgImage withBtnArray:arr selIndex:-1];
	
	//tempNavBar.navTitle = ;
	tempNavBar.delegate = self;
	tempNavBar.navTitle = navBarTitle;
	NE_LOGRECT(tempNavBar.frame);
	//[mainView.topBarView addSubview:tempNavBar];
	//NE_LOG(@"tt:%0x",mainView.topBarView);
	mainView.topBarView = tempNavBar;
	//NE_LOG(@"tt:%0x",tempNavBar);
	//[topBarViewNavItemArr insertObject:tempNavBar atIndex:index];
	[tempNavBar release];
}
#pragma 
-(void)scollerViewWillAppearFromMsg:(NSNotification*)ntf
{

}
-(void)scollerViewWillDisappearFromMsg:(NSNotification*)ntf
{
    
}
@end
