//
//  MessageDetailViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-12-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController (){

    UITextView *msgShowTextView;
}
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
    //[super viewDidLoad];
    [self setNavgationBarTitle:self.barTitle];
    //[self setHiddenRightBtn:NO];
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, kMBAppTopToolBarHeight,kDeviceScreenWidth, kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    
    [self.view addSubview:bgView];
    SafeRelease(bgView);
    
	// Do any additional setup after loading the view.
    self.subClassInputTextField.hidden = YES;
    msgShowTextView = [[UITextView alloc]initWithFrame:CGRectMake(10.f,kMBAppTopToolBarHeight+20.f, 300.f,160.f)];
    msgShowTextView.layer.cornerRadius = 5.f;
    msgShowTextView.text = self.userEmail;
    msgShowTextView.font = [UIFont systemFontOfSize:15];
    
    if(self.type == 1){
        msgShowTextView.editable = NO;
        UIImageWithFileName(bgImage, @"item_default_btn.png");
        assert(bgImage);
        [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
        UIImageWithFileName(bgImage, @"item_default_btn.png");
        [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateSelected];
        [self setNavgationBarRightBtnText:@"回复"forStatus:UIControlStateNormal];
        [self setNavgationBarRightBtnText:@"回复" forStatus:UIControlStateSelected];
        self.rightBtn.frame = CGRectMake(kDeviceScreenWidth-10-bgImage.size.width/kScale, self.rightBtn.frame.origin.y, bgImage.size.width/kScale, bgImage.size.height/kScale);
        self.rightBtn.font = [UIFont systemFontOfSize:13];

    }
    else if(self.type == 2){
        [msgShowTextView becomeFirstResponder];
        UIImageWithFileName(bgImage, @"item_default_btn.png");
        assert(bgImage);
        [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
        UIImageWithFileName(bgImage, @"item_change_btn.png");
        self.rightBtn.frame = CGRectMake(kDeviceScreenWidth-10-bgImage.size.width/kScale, self.rightBtn.frame.origin.y, bgImage.size.width/kScale, bgImage.size.height/kScale);
         self.rightBtn.font = [UIFont systemFontOfSize:13];
        [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateSelected];
        [self setNavgationBarRightBtnText:@"确定"forStatus:UIControlStateNormal];
        [self setNavgationBarRightBtnText:@"确定" forStatus:UIControlStateSelected];
    }
    else {
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
    
//    if(self.type == 0)
//        [self startRestPassword];
//    else
        [self startUpdatePhone];
}
- (void)startUpdatePhone{
    
    if([msgShowTextView.text isEqualToString:@""]){
        kUIAlertView(@"提示", @"请输入反馈内容");
        [msgShowTextView becomeFirstResponder];
        return;
    }
    
    //NSString *replyDate = [date ];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self.data objectForKey:@"createdTime"],@"createdTime",
                           dateString,@"ackTime",
                            msgShowTextView.text,@"ackMesCon",
                           [AppSetting getLoginUserId],@"userName",
                           nil];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"数据更新中", @"") networkIndicator:YES];
    CarServiceNetDataMgr *netClientMgr = [CarServiceNetDataMgr getSingleTone];
    
    self.request = [netClientMgr  replyMessageList:param];
    
    
}
-(void)startRestPassword
{
  
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    //save use name and passwor;
    [SVProgressHUD dismiss];
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request == respRequest&&([resKey isEqualToString:kResReplyMessageData]))
    {
        self.request = nil;
        //[self performSelector:@selector(startDoAction) withObject:nil afterDelay:0.3];
        //if([[data objectForKey:@"retType"]intValue]==0)
        {
            kUIAlertView(@"提示",@"回复成功");
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
            if(self.type == 1){
            
                MessageDetailViewController *detailVc = [[MessageDetailViewController alloc]init];
                detailVc.barTitle = @"回复";
                detailVc.type = 2;
                detailVc.data = self.data;
                [self.navigationController pushViewController:detailVc animated:YES];
                SafeRelease(detailVc);
                    
            }
            else if(self.type == 2){
                [self startNetwork];
            }
			break;
		}
	}
    
}
@end
