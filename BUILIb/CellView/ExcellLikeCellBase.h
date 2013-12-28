//
//  ExcellLikeCellBase.h
//  BodCarManger
//
//  Created by cszhan on 13-10-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcellLikeCellBase : UITableViewCell
@property(nonatomic,strong)NSMutableArray *mCellItemArray;
@property(nonatomic,strong)UIColor *mLineColor;

- (void)setRowLineHidden:(BOOL)status;
- (void)setClounmLineHidden:(BOOL)status;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setTableCellCloumn:(int)clum withData:(NSString*)text;
- (void)setClounmLineColor:(UIColor*)color;
- (void)setTableCellCloumn:(int)clum withColor:(UIColor*)color;
- (void)setClounmWidthArrays:(NSArray*)widhArray;
- (UILabel*)getClounmWithIndex:(int)index;
@end
