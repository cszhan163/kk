//
//  CarInfoInputViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-11-6.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface CarInfoInputViewController : ResetPasswordViewController{
    
     UIDatePicker *datePickView;
}
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSString *barTitle;
@end
