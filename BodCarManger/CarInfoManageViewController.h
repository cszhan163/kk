//
//  CarInfoManageViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-11-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UserSettingViewController.h"
#import "UserSettingViewController.h"
@interface CarInfoManageViewController : UserSettingViewController{

     UIDatePicker *datePickView;
}
- (void)setCellItemData:(NSString*)text withIndexPath:(NSIndexPath*)indexPath;
@property(nonatomic,strong)NSDictionary *data;
@end
