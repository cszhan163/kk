//
//  UIBarBase.h
//  MP3Player
//
//  Created by cszhan on 12-1-16.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NETopNavBar.h"
#import "NEAppFrameView.h"
@class NETopNavBar;
@class NEAppFrameView;
//@protocol NETabNavBarDelegate;
@protocol NETopNavBarDelegate;
@protocol UIBaseViewControllerDelegate;
@interface UIBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NETopNavBarDelegate>
{
@public
		NEAppFrameView	*mainView;
		NSString	 *navBarTitle;
		NSMutableArray	*topBarViewNavItemArr;
        BOOL isFromViewUnload;
    id<UIBaseViewControllerDelegate> delegate;
    NSString                *objIDKey;
}

-(void)setBgImage:(UIImage*)image;
-(void)setHiddenRightBtn:(BOOL)hidden;
-(void)setRightBtnEnable:(BOOL)enable;
-(void)setRightTextContent:(NSString*)text;
-(void)setRightTextColor:(UIColor*)color;
-(void)setNavgationBarTitle:(NSString*)title;

@property(nonatomic,assign)CGFloat mainContentViewPendingY;
@property(nonatomic,assign)CGFloat mainContentViewPendingX;
@property(nonatomic,assign)int mainViewType;
@property(nonatomic,assign)id<UIBaseViewControllerDelegate> delegate;
@property(nonatomic,readonly)NEAppFrameView *mainView;
@property(nonatomic,assign) UIButton *leftBtn;
@property(nonatomic,assign) UIButton *rightBtn;

-(void)addObservers;
-(void)removeObservers;
@end
@protocol UIBaseViewControllerDelegate <NSObject>
-(void)didSelectorTopNavigationBarItem:(id)sender;
@end