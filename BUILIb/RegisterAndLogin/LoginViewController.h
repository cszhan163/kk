//
//  LoginViewController.h
//  DressMemo
//
//  Created by  on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UISimpleNetBaseViewController.h"

@interface LoginViewController : UISimpleNetBaseViewController<UITableViewDelegate>
{

    UIImageView *cloudView;
    
    UIButton *loginButton;
    UIButton *regButton;
    
    UITableView *logInfo;
    UINavigationController *gnv;
}
@property(nonatomic,retain)UITableViewCell *reSetPwdcell;
@end
