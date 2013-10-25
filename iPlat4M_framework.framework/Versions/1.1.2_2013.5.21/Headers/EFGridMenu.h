//
//  EFGridMenu.h
//  iPlat4M_iPad
//
//  Created by baosight on 12-2-20.
//  Copyright (c) 2012年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFFoundation.h"
#import "MBProgressHUD.h"
@class EFGridMenuContent;
@interface EFGridMenu : UIView {
    
}

@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,retain) UINavigationController * navController;
@property (nonatomic,retain) NSString * nodeId;
@property (nonatomic,retain) NSString * parentNodeId;
@property (nonatomic,retain) NSString * nodeName;
@property (nonatomic,retain) NSString * selectedNode;
@property (nonatomic,retain) NSString * isLeaf;
@property (nonatomic,retain) NSString * eBlockName;
@property (nonatomic,retain) NSString * eName;
@property (nonatomic,retain) NSString * iconId;
@property (nonatomic,retain) EiInfo * innerEiInfo;
@property (nonatomic,retain) EFGridMenuContent *menuContent;
@property (nonatomic,copy) EiInfo * (^getChildData)(NSString *,id);
@property (nonatomic,copy) void (^leafNodeOnClick)(NSMutableDictionary *);


- (void)refreshwithEiInfo:(EiInfo *)inInfo toMenuContent :(EFGridMenuContent *)menuContent ;
-(void) addLoading;
-(void) removeLoading;
-(void) refreshMenu;

@end
