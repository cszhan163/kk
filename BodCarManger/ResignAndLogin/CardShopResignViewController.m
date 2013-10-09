//
//  frmRegist.m
//  kkshop
//
//  Created by apple  on 12-8-7.
//
//

#import "CardShopResignViewController.h"
//#import "AppDelegate.h"
#import "AppSetting.h"
@interface CardShopResignViewController ()

@end

@implementation CardShopResignViewController
@synthesize navTitleLabel;
@synthesize confirmPasswordTextFied;
@synthesize mobilePhoneTextFied;
@synthesize passwordTextFied;
@synthesize radomCodeTextFied;
@synthesize mobilePhoneNumStr;
@synthesize type;

-(void)dealloc
{
    self.navTitleLabel = nil;
    self.mobilePhoneTextFied = nil;
    self.passwordTextFied = nil;
    self.confirmPasswordTextFied = nil;
    self.radomCodeTextFied  = nil;
    self.mobilePhoneNumStr = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(type ==0)
    {
        navTitleLabel.text = @"注册";
    }
    else
    {
        navTitleLabel.text = @"找回密码";
    }
    mobilePhoneTextFied.text = self.mobilePhoneNumStr;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mobilePhoneTextFied = nil;
    self.passwordTextFied = nil;
    self.confirmPasswordTextFied = nil;
    self.radomCodeTextFied  = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)goBack:(id)sender
{
    /*
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int count=[delegate.navi.viewControllers  count ]-1;
	[delegate.navi popToViewController: [self.navigationController.viewControllers objectAtIndex: count-1] animated:YES];
    */
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)login_click:(id)sender
{
    
    [self.mobilePhoneTextFied resignFirstResponder];
    [self.radomCodeTextFied resignFirstResponder];
    [self.passwordTextFied resignFirstResponder];
    [self.confirmPasswordTextFied resignFirstResponder];
    if([self.mobilePhoneTextFied.text length]<11)
    {
        kUIAlertView(@"提示", @"输入的手机号码不对");
        [self.mobilePhoneTextFied becomeFirstResponder];
        return;
    }
    [self startLogin];
}
/*
 *username	用户名	必须 ，格式是手机号
 password	密码	必须
 repassword	密码	必须
 captcha	验证码	必须，验证码
 */

-(void)startLogin
{
    //if([self check])
    if(type == 0){
        kNetStartShow(@"注册中...",self.view);
    }
    else
    {
        kNetStartShow(@"发送中...",self.view);
    }
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    NSDictionary *param = nil;
    if(type == 0)
    {
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.mobilePhoneTextFied.text,@"username",
                           self.passwordTextFied.text,@"password",
                           self.confirmPasswordTextFied.text,@"repassword",
                           self.radomCodeTextFied.text,@"captcha",
                           nil];
         self.request = [cardShopMgr  userResign:param];
    }
    else
    {
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.mobilePhoneTextFied.text,@"username",
                 self.passwordTextFied.text,@"password",
                 self.confirmPasswordTextFied.text,@"repassword",
                 self.radomCodeTextFied.text,@"sms",
                 nil];
        self.request = [cardShopMgr userResetPassword:param];
    }
   
    
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
    id _data = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    if(self.request == respRequest&&([resKey isEqualToString:@"register"]|| [resKey isEqualToString:@"findpassword"]))
    {
        self.request = nil;
        kNetEnd(self.view);
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.mobilePhoneTextFied.text,@"username",
                               self.passwordTextFied.text,@"password",nil];
        [AppSetting setLoginUserInfo:param];
        [AppSetting setLoginUserId:self.mobilePhoneTextFied.text];
        NE_LOG(@"%@",[_data description]);
        //[self stopShowLoadingView];
        //[Ap]
        [ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
    }
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    kNetEnd(self.view);
    NE_LOG(@"warning not implemetation net respond");
}
-(void)textFieldDidEndEditing:(id)sender
{
    if(sender == self.confirmPasswordTextFied)
        [sender resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.confirmPasswordTextFied)
        [textField resignFirstResponder];
    return YES;
}
@end
