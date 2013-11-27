//
//  CarSelectedViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-11-27.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UIImageNetBaseViewController.h"

@interface CarSelectedViewController :UIImageNetBaseViewController
@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSString *brandSeq;
@property(nonatomic,strong)NSString *seriesSeq;
@property(nonatomic,strong)NSString *modelSeq;
@property(nonatomic,strong)NSDictionary *carDataDict;
@end
