//
//  EFComboBoxTable.h
//  iPlat4M_iPad
//
//  Created by Yiming Fu on 11-11-21.
//  Copyright 2011年 BaoSight. All rights reserved.
//

#import "EFFoundation.h"
@class EFComboBox;

@interface EFComboBoxTable : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    EFComboBox * parentComboBox;
    EiBlock * block;
}

@property (nonatomic,retain) EFComboBox * parentComboBox; 
@property (nonatomic,retain) EiBlock * block;


@end
