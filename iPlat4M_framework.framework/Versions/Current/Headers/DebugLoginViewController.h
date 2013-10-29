//
//  DebugLoginViewController.h
//  iPlat4M_iPad
//
//  Created by baosight  on 13-5-20.
//  Copyright (c) 2013年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebugLoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,retain) UIViewController *targetVC;
@property (nonatomic,retain) IBOutlet UITextField *userIDTextField;
@property (nonatomic,retain) IBOutlet UITextField *serviceURLTextField;
@property (nonatomic,retain) IBOutlet UIButton *resetPWDButton;
@property (nonatomic,retain) IBOutlet UIButton *loginButton;

-(IBAction)doDebugLogin:(id)sender;
-(IBAction)clickResetButton:(id)sender;
@end
