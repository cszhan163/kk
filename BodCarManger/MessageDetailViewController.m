//
//  MessageDetailViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-12-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.subClassInputTextField.hidden = YES;
    UITextView *msgShowTextView = [[UITextView alloc]initWithFrame:CGRectMake(10.f,kMBAppTopToolBarHeight+20.f, 300.f,160.f)];
    msgShowTextView.layer.cornerRadius = 5.f;
    msgShowTextView.text = self.userEmail;
    if(self.type == 1){
        msgShowTextView.editable = YES;
    }
    else{
        msgShowTextView.editable  = NO;
        [self setHiddenRightBtn:YES];
    }
    [self.view addSubview:msgShowTextView];
    SafeRelease(msgShowTextView);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)startNetwork{
    
    if(self.type == 0)
        [self startRestPassword];
    else
        [self startUpdatePhone];
}
- (void)startUpdatePhone{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"数据更新中", @"") networkIndicator:YES];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.subClassInputTextField.text,@"phoneNumber",
                           [AppSetting getLoginUserId],@"name",
                           nil];
    CarServiceNetDataMgr *netClientMgr = [CarServiceNetDataMgr getSingleTone];
    
    self.request = [netClientMgr  carUserPhoneUpdate:param];
    
    
}
-(void)startRestPassword
{
    
    
    if(![self.subClassInputTextField.text isEqualToString:[AppSetting getLoginUserPassword]]){
        kUIAlertView(@"提示",@"旧密码错误");
        return;
    }

    [SVProgressHUD showWithStatus:NSLocalizedString(@"数据更新中", @"") networkIndicator:YES];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           self.newPasswordInputTextField.text,@"password",
//                           self.subClassInputTextField.text,@"oldpassword",
//                           [AppSetting getLoginUserId],@"name",
//                           nil];
//    CarServiceNetDataMgr *netClientMgr = [CarServiceNetDataMgr getSingleTone];
//    if(self.type == 0)
//    {
//        self.request = [netClientMgr  carUserPasswordUpdate:param];
//    }
//    else
//    {
//        //self.request = [netClientMgr  userResetPwdRadomCode:param];
//    }
    //[self ];
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    //save use name and passwor;
    [SVProgressHUD dismiss];
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request == respRequest&&([resKey isEqualToString:kCarUserUpdatePass]))
    {
        self.request = nil;
        //[self performSelector:@selector(startDoAction) withObject:nil afterDelay:0.3];
        if([[data objectForKey:@"retType"]intValue]==0){
            kUIAlertView(@"提示",@"密码更新成功");
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
   
    
}

//-(void)startDoAction
//{
//    kUIAlertView(@"提示",@"验证码已发送，稍后请查看短信");
//    CardShopResignViewController *frmobj=[[CardShopResignViewController alloc] init];
//    frmobj.mobilePhoneNumStr = subClassInputTextField.text;
//    frmobj.type = self.type;
//    [self.navigationController pushViewController:frmobj animated:YES];
//    [frmobj release];
//}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    [SVProgressHUD dismissWithError:@""];
}

@end
