//
//  EFGridMenuContent.h
//  iPlat4M_iPad
//
//  Created by baosight on 12-2-21.
//  Copyright (c) 2012年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFFoundation.h"
@class ASINetworkQueue;
@class EFGridMenu;
@interface EFGridMenuContent : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *menuScrollView;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic) NSUInteger numberOfPages;
@property (nonatomic, retain) NSMutableArray *menuViews;
@property (nonatomic) BOOL pageControlUsed;
@property (nonatomic,retain) EFGridMenu *efGridMenu;
@property (nonatomic,retain) EiBlock * currentBlock;
@property (nonatomic,retain) NSString * currentParentNodeId;
@property (nonatomic, retain) ASINetworkQueue *networkQueue;

-(void)freshMenu;
@end
