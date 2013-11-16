//
//  UserChangePasswordViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-16.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UserChangePasswordViewController.h"

@implementation UserChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.type == 0){
        self.subClassInputTextField.secureTextEntry = YES;
        self.subClassInputTextField.text = @"";
        self.subClassInputTextField.placeholder = @"请输入旧密码";
    }
    else{
        self.subClassInputTextField.text = self.srcText;
    }
    UIImage *bgImage;
    //[self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    UIImageWithFileName(bgImage, @"item_default_btn.png");
    assert(bgImage);
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
    UIImageWithFileName(bgImage, @"item_change_btn.png");
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateSelected];
    
    //self.rightBtn.titleLabel
    /*
     self.rightBtn = [UIComUtil createButtonWithNormalBGImageName:@"item_default_btn.png" withHightBGImageName:@"item_change_btn.png" withTitle:@"确定" withTag:0];
     */
    self.rightBtn.frame = CGRectMake(kDeviceScreenWidth-10-bgImage.size.width/kScale, self.rightBtn.frame.origin.y, bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.subClassInputTextField  addTarget:self action:@selector(didchangeInputText:) forControlEvents:UIControlEventEditingChanged];
    //self.rightBtn.titleLabel.text = @"确定";
    self.rightBtn.font = [UIFont systemFontOfSize:13];
    [self setNavgationBarRightBtnText:@"确定"forStatus:UIControlStateNormal];
    [self setNavgationBarRightBtnText:@"确定" forStatus:UIControlStateSelected];
    
    
    if(self.type == 0){
        self.newPasswordInputTextField = [[[UITextField alloc]initWithFrame:CGRectMake(KLoginAndResignPendingX,KLoginAndResignPendingX+kMBAppTopToolBarHeight+53,kDeviceScreenWidth-2*KLoginAndResignPendingX,44.f)]autorelease];
        self.newPasswordInputTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.newPasswordInputTextField .delegate = self;
        self.newPasswordInputTextField .contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.newPasswordInputTextField .font = kAppTextSystemFont(16);//[UIFont systemFontOfSize:40];
        self.newPasswordInputTextField .textColor = kLoginAndSignupInputTextColor;
        self.newPasswordInputTextField.placeholder = @"请输入新密码";
        self.newPasswordInputTextField .adjustsFontSizeToFitWidth = NO;
        self.newPasswordInputTextField .text = @"";
        self.newPasswordInputTextField .delegate = self;
        [self.newPasswordInputTextField addTarget:self action:@selector(didchangeInputText:) forControlEvents:UIControlEventEditingChanged];
        self.newPasswordInputTextField.secureTextEntry = YES;
        [self.view addSubview:self.newPasswordInputTextField];
        //[self.newPasswordInputTextField ]
        SafeRelease(self.newPasswordInputTextField);
    }
}
- (void)didchangeInputText:(UITextField*)textField{
    BOOL checkTag = YES;
    if(self.type == 0){
        checkTag = [self.newPasswordInputTextField.text isEqualToString:@""];
    }
    else{
        checkTag = [self.subClassInputTextField.text isEqualToString:self.srcText];
    }
    if(checkTag){
        self.rightBtn.selected = NO;
    }
    else{
        self.rightBtn.selected = YES;
    }
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
    if([self.newPasswordInputTextField.text isEqualToString:@""])
    {
        [self.newPasswordInputTextField becomeFirstResponder];
        return;
    }
    [SVProgressHUD showWithStatus:NSLocalizedString(@"数据更新中", @"") networkIndicator:YES];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.newPasswordInputTextField.text,@"password",
                           [AppSetting getLoginUserId],@"name",
                           nil];
    CarServiceNetDataMgr *netClientMgr = [CarServiceNetDataMgr getSingleTone];
    if(self.type == 0)
    {
        self.request = [netClientMgr  carUserPasswordUpdate:param];
    }
    else
    {
        //self.request = [netClientMgr  userResetPwdRadomCode:param];
    }
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
    if(self.request == respRequest && [resKey isEqualToString:kCarUserUpdatePhone]){
        self.request = nil;
        //[self performSelector:@selector(startDoAction) withObject:nil afterDelay:0.3];
        if([[data objectForKey:@"retType"]intValue]==0){
            kUIAlertView(@"提示",@"手机号码更新成功");
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
