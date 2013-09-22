//
//  UserSettingViewController.m
//  DressMemo
//
//  Created by  on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserSettingViewController.h"
//
//////#import "FriendInvitationViewController.h"
//////#import "UserInforEditViewController.h"
//////#import "AppSetting.h"
//////#import "LoginAndResignMainViewController.h"
////#import "SharePlatformCenter.h"
////#import "UIShareCell.h"
////#import "CancelBindViewController.h"
//
//#import "AboutViewController.h"

static NSString *kSectionOneArr[] =
{
    @"个人信息",@"新浪微博",@"腾讯微博的绑定",
};
@interface UserSettingViewController ()

@end

@implementation UserSettingViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mainContentViewPendingY = -3.f;
    }
    return self;
}
- (void)loadView{
    [super loadView];
    /*
     CGFloat bgWidth = kDeviceScreenWidth-2*KLoginAndResignPendingX;
     CGFloat bgHeight = 2*kLoginCellItemHeight+KLoginAndResignPendingX*2;
     */
    logInfo = [[UITableView alloc] initWithFrame:CGRectMake(0,kMBAppTopToolBarHeight-self.mainContentViewPendingY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght)
                                                         style:UITableViewStyleGrouped];
	//logInfo.contentInset
    
	logInfo.allowsSelectionDuringEditing = NO;
	logInfo.backgroundColor = [UIColor clearColor];
	logInfo.delegate = self;
	logInfo.dataSource = self;
	logInfo.scrollEnabled = NO;
	logInfo.allowsSelection = YES;
    //logInfo.clipsToBounds = YES;
    logInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
	//logInfo.separatorColor = kLoginAndSignupCellLineColor;
    //logInfo.layer.cornerRadius = kLoginViewRadius;
    //CGPoint origin = bgView.frame.origin;
    //bgView.frame = logInfo.frame;
    //logInfo.contentSize = CGSizeMake(bgWidth,bgHeight);
    [self.view addSubview:logInfo];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"BG.png");
    mainView.bgImage = bgImage;
#else
     mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    [self setNavgationBarTitle:NSLocalizedString(@"Setting", @""
                                                 )];
    [self setRightBtnHidden:YES];
       //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [logInfo reloadData];
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

- (void)dealloc{
    Safe_Release(logInfo);
    
    [super dealloc];
}
#pragma mark -
#pragma mark tableView dataSource
//- (NSInteger)tableView:(UITableView *)tableView section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 2)
        return 2;
    else if (section == 1)
    {
        return 3;
    } 
    else 
    {
        return 1;
    }
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 1 &&
//        (indexPath.row == 1 || indexPath.row == 2)) {
//        return [UIShareCell cellHeight];
//    }
    
    return  44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *LabelTextFieldCell = @"LabelTextFieldCell";
	
	UITableViewCell *cell = nil;
    
	cell = [tableView dequeueReusableCellWithIdentifier:LabelTextFieldCell];
	
    
    if (cell == nil) 
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelTextFieldCell];
	}
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:70/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    
    
    int index = [indexPath row];
    switch (indexPath.section) 
    {
        case 0:
            
            cell.textLabel.text = @"邀请好友";
            break;
        case 1:
        {
        
            cell.textLabel.text = kSectionOneArr[index];
            
            if (indexPath.row == 1 || indexPath.row == 2)
            {
//                static NSString *shareCellIdentifier = @"shareCell";
//                
//                UIShareCell *shareCell = [tableView dequeueReusableCellWithIdentifier:shareCellIdentifier];
//                
//                if (![shareCell isKindOfClass:[UIShareCell class]])
//                {
//                    shareCell = [[UIShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shareCellIdentifier];
//                }
//                
//
//                if (indexPath.row == 1)
//                {
//                    [shareCell reloadData:K_PLATFORM_Sina];
//                }else{
//                    [shareCell reloadData:K_PLATFORM_Tencent];
//                }
//                
//                return shareCell;
            }
            
            
        }
            break;
        case 2:
        {
        
            //int index = [indexPath row];
            switch (index)
            {
                case 0:
                    cell.textLabel.text = @"关于DressMemo";
                    break;
                case 1:
                      cell.textLabel.text = @"退出登陆";
                    break;
            }
        
        }
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int index = [indexPath row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.section) 
    {
       case 0:{
//            FriendInvitationViewController *frInviteVc = [[FriendInvitationViewController alloc]init];
//            [frInviteVc setNavgationBarTitle:cell.textLabel.text];
//            [self.navigationController pushViewController:frInviteVc animated:YES];
//            [frInviteVc release];
//            //cell.textLabel.text = @"邀请好友";
//        }
//            break;
//        case 1:
//        {
//            switch (index)
//            {
//                case 0:{
//                
//                    UserInforEditViewController *userEditVc = [[UserInforEditViewController alloc]init];
//                    NSDictionary *userData = [AppSetting getLoginUserDetailInfo:[AppSetting getLoginUserId]];
//                    userEditVc.userData = userData;
//                    userEditVc.delegate  = self;
//                    [self.navigationController pushViewController:userEditVc animated:YES];
//                    [userEditVc release];
//                
//                }
//                    break;
//                case 1: //新浪微博
//                case 2: //腾讯微博
//                {
//                    NSString *type = nil;
//                
//                    if (index == 1) {
//                        type = K_PLATFORM_Sina;
//                    }else{
//                        type = K_PLATFORM_Tencent;
//                    }
//                    
//                    if ([[SharePlatformCenter defaultCenter] modelDataWithType:type]) {
//                        CancelBindViewController *tc = [[CancelBindViewController alloc] init];
//                        tc.platformType = type;
//                        [self.navigationController pushViewController:tc animated:YES];
//                        
//                    }else
//                        [[SharePlatformCenter defaultCenter] bindPlatformWithKey:type WithController:self];
//                    
//                    break;
////                }
//            }
            //cell.textLabel.text = kSectionOneArr[index];
        }
            break;
        case 2:
        {
            
            //int index = [indexPath row];
            switch (index)
            {
                case 0:
                {
                    //cell.textLabel.text = @"关于DressMemo";
//                    AboutViewController *abVc = [[AboutViewController alloc]init];
//                    
//                    [self.navigationController pushViewController:abVc animated:YES];
//                    [abVc release];
                }
                    break;
                case 1:
                {
                    
                    //cell.textLabel.text = @"退出登陆";//a)	ALERT提示“是否真的要退出” 按钮两个“确定”“取消”，点击确定退出到登陆页面。
                    /*
                    kUIAlertConfirmView(NSLocalizedString(@"提示", @""),NSLocalizedString(@"是否真的要退出",@""),NSLocalizedString(@"Cancel",@""),NSLocalizedString(@"Ok",@""))
                    */
                    UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示", @"")message:NSLocalizedString(@"是否真的要退出",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",@"") otherButtonTitles:NSLocalizedString(@"Ok",@""),nil]autorelease];
                                                                                                                                      [alertErr show];
                }
                    break;
            }
            
        }
        default:
            break;
    }
}
#pragma mark  -
#pragma mark logout confir delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
    
        [self.navigationController popToRootViewControllerAnimated:NO];
//#if 1
//        [AppSetting  clearCurrentLoginUser];
//#else
//        [AppSetting setCurrentLoginUser:@""];
//#endif
       /*
        NSString *loginUserId = [AppSetting getLoginUserId];
        [AppSetting setLoginUserInfo:[NSD] withUserKey:loginUserId];
         */
//        [AppSetting setUserLoginStatus:NO];
//        LoginAndResignMainViewController *loginVc = [[LoginAndResignMainViewController alloc]init];
//        //[self.navigationController pushViewController:tagchooseBrandVc animated:YES];
//        UINavigationController *loginNav  = [[UINavigationController alloc]initWithRootViewController:loginVc];
//        loginNav.navigationBarHidden = YES;
//        /*
//         [navCtrl presentModalViewController:loginNav animated:YES];
//         */
//        [ZCSNotficationMgr postMSG:kUserDidLogOut obj:nil];
//        [ZCSNotficationMgr postMSG:kPresentModelViewController obj:loginNav];
//        [loginVc release];

    }
}
@end
