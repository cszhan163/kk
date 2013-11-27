//
//  CarRouterMapViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UIBaseViewController.h"
#import "UISimpleNetBaseViewController.h"
@interface CarRouterDetailViewController : UISimpleNetBaseViewController
@property(nonatomic,strong) NSString            *mStartName;
@property(nonatomic,strong) NSString            *mEndName;
@property(nonatomic,assign)BOOL isLatest;
@property(nonatomic,assign)BOOL isRunning;
@property(nonatomic,assign)BOOL isFromDateView;
@property(nonatomic,strong) NSDictionary*mData;
@end
