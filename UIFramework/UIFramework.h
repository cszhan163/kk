//
//  UIFramework.h
//  DressMemo
//
//  Created by  on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef DressMemo_UIFramework_h
#define DressMemo_UIFramework_h

#import "UIFrameworkMSG.h"


//the tabBabview will offset Y ,if we don't offset Y then we should  0,this app we offset 10 ,as the select status
#define kTabBarViewOffsetY                              0.f//-10.f
#define kTabItemNarmalImageFileNameFormart              @"tableitem%d"
#define kTabItemSelectImageFileNameFormart              @"tableitemsel%d"
#define kTabBarViewBGImageFileName                      @"tabbarbg.png"
//if we don't use tabBar view offset ,we can use as follow to implement 

//the image between the tab and content view
#define kTabBarAndViewControllerSepratorImageFileName   @"none.png" //@"tabitemtopsplit.png"
//the select mask image
#define kTabBarItemMaskImageFileName                    @"tableitemselmask.png"

#define kMBAppRealViewYPending                          9.f

#define kTabItemTextShow            0

//if all the button is the same ,the offset should be all 0
#define kTabAllItemTextCenterXOffset    @"0,0,0,0,0"
#define kTabAllItemTextCenterYOffset    @"0,0,0,0,0"

#define kTabAllItemText                 @"行程,驾驶,车况,服务,设置"
//for tabItem text
#define kTabItemTextPendingY            5.f
#define kTabItemTextHeight              12
#define kTabItemTextFont            [UIFont systemFontOfSize:12]


#define kTabCountMax                              5
#define kTabItemImageSubfix                       @"png"




#endif
