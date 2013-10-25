//
//  TestViewController2.h
//  Controller
//
//  Created by baosight on 11-12-6.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EFMenu;
@class EiBlock;
@class EiInfo;
@interface EFMenuContent : UIViewController<UINavigationBarDelegate, UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic,retain) IBOutlet UITableView *myTableView;
@property (nonatomic,retain) UIScrollView * menuScrollView;
@property (nonatomic,retain) UIView * menuView;
@property (nonatomic,retain) NSMutableArray * buttonArray;
@property (nonatomic,retain) NSString * currentParentNodeId;
@property (nonatomic,retain) EFMenu * efMenu;

@property (nonatomic,retain) EiBlock * currentBlock;
@end
