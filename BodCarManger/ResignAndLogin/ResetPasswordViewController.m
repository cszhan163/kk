//
//  ResetPasswordViewController.m
//  DressMemo
//
//  Created by  on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResetPasswordViewController.h"
//#import "LoginAndSignupConfig.h"
#import "CarServiceNetDataMgr.h"
//#import "ZCSNetClientDataMgr.h"
#import "SVProgressHUD.h"

#import "CardShopResignViewController.h"



@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController
@synthesize subClassInputTextField;
@synthesize userEmail;
@synthesize type;
- (void)dealloc
{
    self.subClassInputTextField = nil;
    
    [super dealloc];
}
- (void)loadView
{
    [super loadView];
    //
    //change the background
	//self.view = mainView;
    //mainView.backgroundColor = kLoginAndSignupCellImageBGColor;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self addObservers];
   
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, kMBAppTopToolBarHeight,kDeviceScreenWidth, kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    
   
    
    
    
    [self setHiddenRightBtn:NO];
    //mainView.topBarView.frame = CGRectMake(0.f,0.f,320.f,44.f);
   
    
    self.subClassInputTextField = [[[UITextField alloc]initWithFrame:CGRectMake(KLoginAndResignPendingX,KLoginAndResignPendingX+kMBAppTopToolBarHeight,kDeviceScreenWidth-2*KLoginAndResignPendingX,44.f)]autorelease];
    subClassInputTextField.borderStyle = UITextBorderStyleRoundedRect;
    subClassInputTextField.delegate = self;
    subClassInputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    subClassInputTextField.font = kAppTextSystemFont(16);//[UIFont systemFontOfSize:40];
    subClassInputTextField.textColor = kLoginAndSignupInputTextColor;
    subClassInputTextField.adjustsFontSizeToFitWidth = NO;
    subClassInputTextField.text = @"";
    subClassInputTextField.delegate = self;
    //subClassInputTextField.keyboardType = UIKeyboardTypeNumberPad;
    if(userEmail)
    {
        subClassInputTextField.text = userEmail;
    }
    subClassInputTextField.placeholder = NSLocalizedString(@"请输入内容", @"");
    subClassInputTextField.returnKeyType = UIReturnKeyDone;
    //UIImageWithFileName(bgImage, @"inputboxL.png");
    UIImageWithFileName(bgImage, @"inputboxL.png");
#if 0
    UIEdgeInsets resizeEdgeInset = UIEdgeInsetsMake(10.f,10.f,10.f,10.f);
    if([bgImage respondsToSelector:@selector(resizableImageWithCapInsets:)]&&1)
    {
        bgImage =[bgImage resizableImageWithCapInsets:resizeEdgeInset];
        
    }
    else 
    {
        bgImage = [bgImage stretchableImageWithLeftCapWidth:10.f topCapHeight:10.f];
    }
#endif
    //self.view = subClassInputTextField;
    [self.view addSubview:subClassInputTextField];
    
    //UIButton *btn = [UIButton buttonWithType:];
    
    [subClassInputTextField becomeFirstResponder];
    
    [self.view insertSubview:bgView belowSubview:self.subClassInputTextField];
    SafeRelease(bgView);
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark nav item selector
-(void)didSelectorTopNavItem:(id)navObj
{
	NE_LOG(@"select item:%d",[navObj tag]);
    
	switch ([navObj tag])
	{
		case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];// animated:
        }
			break;
		case 1:
		{
            [self startNetwork];
			break;
		}
	}
    
}
-(void)startRestPassword
{

    if([subClassInputTextField.text isEqualToString:@""])
    {
        [subClassInputTextField becomeFirstResponder];
        return;
    }
    [SVProgressHUD showWithStatus:NSLocalizedString(@"", @"") networkIndicator:YES];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           subClassInputTextField.text,@"mobi",
                           nil];
    CarServiceNetDataMgr *netClientMgr = [CarServiceNetDataMgr getSingleTone];
    if(type == 0)
    {
        self.request = [netClientMgr  userResignRandomCode:param];
    }
    else
    {
        self.request = [netClientMgr  userResetPwdRadomCode:param];
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
    NSString *resKey = [respRequest resourceKey];
   if(self.request == respRequest&&([resKey isEqualToString:@"getsms"]|| [resKey isEqualToString:@"getsmsfindpassword"]))
    {
        self.request = nil;
        [self performSelector:@selector(startDoAction) withObject:nil afterDelay:0.3];
      
        //[self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)startDoAction
{
    kUIAlertView(@"提示",@"验证码已发送，稍后请查看短信");
    CardShopResignViewController *frmobj=[[CardShopResignViewController alloc] init];
    frmobj.mobilePhoneNumStr = subClassInputTextField.text;
    frmobj.type = self.type;
    [self.navigationController pushViewController:frmobj animated:YES];
    [frmobj release];
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    [SVProgressHUD dismissWithError:@""];
}
@end
