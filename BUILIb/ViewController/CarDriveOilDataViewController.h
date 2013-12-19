//
//  CarDriveOilDataViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-10-5.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageNetBaseViewController.h"
#import "UISimpleNetBaseViewcontroller.h"
#import "BaoMonthBaseViewController.h"

#define Header  1

//@interface CarDriveOilDataViewController:UIImageNetBaseViewController
@interface CarDriveOilDataViewController:BaoMonthBaseViewController
{
    BSPreviewScrollView *scrollerView;
    UITableView *dataTableView;
}
- (void)setNeedDisplaySubView;
@end
