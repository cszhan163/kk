//
//  CarRouterDateViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-9-18.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UISimpleNetBaseViewController.h"
#import "BaoMonthBaseViewController.h"
@interface CarRouterDateViewController : BaoMonthBaseViewController
- (void)checkAdjustDate:(int)offset withMonth:(int*)month withYear:(int*)year;
@end
