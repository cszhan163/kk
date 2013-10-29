//
//  EFMenu.h
//  Controller
//
//  Created by baosight on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDataContext.h"
#import "MBProgressHUD.h"
@class EiInfo;
@class EFMenuContent;
@interface EFMenu : UIView<UINavigationControllerDelegate,UINavigationBarDelegate>
{
    NSString * eBlockName;

}
@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,copy) EiInfo * (^getChildData)(NSString *,id);
@property (nonatomic,copy) void (^leafNodeOnClick)(NSMutableDictionary *);
@property (nonatomic,retain) IBOutlet UINavigationController * navController;
@property (nonatomic,retain) NSString * nodeId;
@property (nonatomic,retain) NSString * parentNodeId;
@property (nonatomic,retain) NSString * nodeName;
@property (nonatomic,retain) NSString * selectedNode;
@property (nonatomic,retain) NSString * isLeaf;
@property (nonatomic,retain) NSString * eBlockName;
@property (nonatomic,retain) EFMenuContent * efMenuContent;
@property (nonatomic,retain) NSString * eName;
@property (nonatomic,retain) EiInfo * innerEiInfo;
-(void) reloadData:(EiInfo *) inInfo efMenuContent:(EFMenuContent *) content;
-(void) addLoading;

-(void) refreshMenu ;

@end
