//
//  CardShopLoginViewController.m
//  kkshop
//
//  Created by apple  on 12-8-7.
//
//

#import "CardShopLoginViewController.h"
#import "ResetPasswordViewController.h"
#import "CardShopResignViewController.h"
#import "CarServiceNetDataMgr.h"

@interface CardShopLoginViewController ()

@end

@implementation CardShopLoginViewController
@synthesize txtusername;
@synthesize txtpassword;
@synthesize request;
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
    NSString  *username=@"";
    NSString  *password=@"";
    
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"login_bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    //self.txtpassword
    /*
    NSString   *filename=[self GetTempPath:@"username.txt"];
     NSError *err;
    if([self is_file_exist:filename]){
        
        username=[NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&err];
    }
    
    filename=[self GetTempPath:@"password.txt"];
    if([self is_file_exist:filename]){
        
        password=[NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&err];
    }
    */
    self.txtpassword.text = @"";
    self.txtusername.text = @"";
    if (![username isEqualToString:@""])
    {
        self.txtpassword.text=password;
        self.txtusername.text=username;
        
        //[self login_click:nil];
    }
    
  
    if(self.txtpassword)
    {
        NSMutableAttributedString *ms = [[NSMutableAttributedString alloc] initWithString:self.txtpassword.placeholder];
        UIFont *placeholderFont = self.txtpassword.font;
        NSRange fullRange = NSMakeRange(0, ms.length);
        NSDictionary *newProps = @{NSForegroundColorAttributeName: HexRGB(137, 137, 137), NSFontAttributeName:placeholderFont};
        [ms setAttributes:newProps range:fullRange];
        self.txtpassword.attributedPlaceholder = ms;
    }
    //self.txtpassword.placeholder
    self.txtpassword.textColor = HexRGB(137, 137, 137);
    if(self.txtusername)
    {
        
        NSMutableAttributedString *ms = [[NSMutableAttributedString alloc] initWithString:txtusername.placeholder];
        UIFont *placeholderFont = self.txtusername.font;
        NSRange fullRange = NSMakeRange(0, ms.length);
        NSDictionary *newProps = @{NSForegroundColorAttributeName: HexRGB(137, 137, 137), NSFontAttributeName:placeholderFont};
        [ms setAttributes:newProps range:fullRange];
        self.txtusername.attributedPlaceholder = ms;
        SafeRelease(ms);
    }
    
    self.txtusername.textColor = HexRGB(137, 137, 137);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)textFieldDidEndEditing:(id)sender
{
	[sender resignFirstResponder];

}
-(IBAction)login_click:(id)sender
{
    
    //[ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
    
    [self.txtusername resignFirstResponder];
    [self.txtpassword resignFirstResponder];
//    if([self.txtusername.text length]<11)
//    {
//        kUIAlertView(@"提示", @"输入的手机号码不对");
//        [self.txtusername becomeFirstResponder];
//        return;
//    }
    if([self.txtusername.text length] == 0|| [self.txtpassword.text length] ==0){
        kUIAlertView(@"提示", @"帐号或密码不能为空");
        [self.txtusername becomeFirstResponder];
        return;
    }
    [self startLogin];
}
-(IBAction)regist_click:(id)sender
{
#if 0
    ResetPasswordViewController *frmobj=[[ResetPasswordViewController alloc] init];
    frmobj.type = 0;
    [self.navigationController pushViewController:frmobj animated:YES];
    [frmobj release];
#else
    CardShopResignViewController *frmobj=[[CardShopResignViewController alloc] init];
    /*
    frmobj.mobilePhoneNumStr = subClassInputTextField.text;
    frmobj.type = self.type;
     */
    [self.navigationController pushViewController:frmobj animated:YES];
    [frmobj release];
#endif
}
-(IBAction)findpw_click:(id)sender
{
    ResetPasswordViewController *resPsVc=[[ResetPasswordViewController alloc] init];
    resPsVc.type = 1;//forget password
    [self.navigationController pushViewController:resPsVc animated:YES];
    [resPsVc release];

}

-(void)startLogin
{
    //if([self check])
    kNetStartShow(@"登录中...",self.view);
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.txtusername.text,@"name",
                              self.txtpassword.text,@"password",
                              nil];
   
    self.request = [cardShopMgr  carUserLogin:param];

}
-(IBAction)cancelLogin:(id)sender
{
    [ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
}
#pragma mark net work respond failed

-(void)didNetDataOK:(NSNotification*)ntf
{
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    if([resKey isEqualToString:kNetLoginRes])
    {
      
        self.request = nil;
        NE_LOG(@"%@",[data description]);
        //[self stopShowLoadingView];
        //[Ap]
         [AppSetting setCurrentLoginUser:self.txtusername.text];
        
        
        //[AppSetting setLoginUserDetailInfo:data userId:self.txtusername.text];
        //[AppSetting setLoginUserInfo:];
        [AppSetting setLoginUserId:self.txtusername.text];
        [AppSetting setLoginUserPassword:self.txtpassword.text];
        [ZCSNotficationMgr postMSG:kQueryCarInfoMSG obj:nil];
        
    }
    if([resKey isEqualToString:kCarInfoQuery]){
        if([data objectForKey:@"vin"]){
            NSString *userId = [AppSetting getCurrentLoginUser];
            [AppSetting setUserCarId:[data objectForKey:@"vin"] withUserId:userId];
            
        }
        kNetEnd(self.view);
        [ZCSNotficationMgr postMSG:kCheckCardRecentRun obj:nil];
        [ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
        //[ZCSNotficationMgr postMSG:kDidUserLoginOK obj:nil];
    }
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    NSDictionary *_data = [obj objectForKey:@"data"];
     NSString *resKey = [obj objectForKey:@"key"];
    if([resKey isEqualToString:kNetLoginRes])
    {
        kNetEnd(self.view);
        //NSDictionary * _data = [obj objectForKey:@"data"];
        kUIAlertView(@"提示",[_data objectForKey:@"msg"]);
        
    }
    if([resKey isEqualToString:kCarInfoQuery]){
        kNetEnd(self.view);
        //NSDictionary * _data = [obj objectForKey:@"data"];
        kUIAlertView(@"提示",[_data objectForKey:@"msg"]);
    }
    NE_LOG(@"warning not implemetation net respond");
}
@end
