//
//  UserChangePasswordViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-11-16.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResetPasswordViewController.h"
@interface UserChangePasswordViewController : ResetPasswordViewController
@property(nonatomic,strong)NSString *srcText;
@property(nonatomic,strong)UITextField *newPasswordInputTextField;
@end
