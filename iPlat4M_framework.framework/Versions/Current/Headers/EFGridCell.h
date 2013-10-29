//
//  EFGridCell.h
//  iPlat4M_iPad
//
//  Created by Fei Ye on 11-12-1.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//

#import "EFFoundation.h"

@interface EFGridCell : UITableViewCell
{
    NSMutableDictionary * row;
    UITableViewCellStyle cellStyle;
}

@property (nonatomic,retain) NSMutableDictionary * row;
@property (nonatomic,assign) UITableViewCellStyle  cellStyle;

@end
