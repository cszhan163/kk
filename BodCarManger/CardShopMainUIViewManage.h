//
//  CardShopMainUIViewManage.h
//  CardShop
//
//  Created by cszhan on 12-8-31.
//  Copyright (c) 2012年 cszhan. All rights reserved.
//

#import "AppMainUIViewManage.h"
@class UIScrollerMainViewController;
@interface CardShopMainUIViewManage : AppMainUIViewManage
+(id)getMainViewController;
+(UIScrollerMainViewController*)getMainScrollerViewController;
-(void)shouldAdjustViewFrame;
@end
