//
//  ExcellLikeCellBase.h
//  BodCarManger
//
//  Created by cszhan on 13-10-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcellLikeCellBase : UITableViewCell
@property(nonatomic,strong)UIColor *mLineColor;
- (void)setClounmLineColor:(UIColor*)color;
- (void)setClounmWidthArrays:(NSArray*)widhArray;
@end
