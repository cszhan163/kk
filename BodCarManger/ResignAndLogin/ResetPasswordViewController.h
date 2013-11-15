//
//  ResetPasswordViewController.h
//  DressMemo
//
//  Created by  on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIBaseViewController.h"
//#import "LoginViewController.h"
#import "CardShopBaseViewController.h"

#define KLoginAndResignPendingX     9.f
//#define kDeviceScreenWidth          320.f
#define kLoginAndSignupInputTextColor [UIColor grayColor]
@interface ResetPasswordViewController:UISimpleNetBaseViewController
@property(nonatomic,retain)UITextField *subClassInputTextField;
@property(nonatomic,retain)NSString *userEmail;
@property(nonatomic,assign)NSInteger type;
@end
