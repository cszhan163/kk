//
//  CarServiceViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarServiceViewController.h"
#import "FriendItemCell.h"

#import "MesssageBoxViewController.h"
static NSString *kSectionOneArr[] =
{
    @"消息中心",@"汽车服务",@"常用电话",
};
static NSString *kImageTextArr[] ={
    @"server_mes.png",@"server_car.png",@"server_phone.png",
};

#define kCellItemHeight 51
@interface CarServiceViewController (){

    UIImageView *mesgeCoutView;
    UIButton *popup;
}
@end

@implementation CarServiceViewController

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
    [ZCSNotficationMgr addObserver:self call:@selector(popNewMSGNotify:) msgName:KNewMessageFromMSG];
//#if 1
//    UIImage *bgImage = nil;
//    UIImageWithFileName(bgImage, @"server_bg.png");
//    mainView.bgImage = bgImage;
//#else
//    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
//#endif
    //mainView.alpha = 0.;
    [self setNavgationBarTitle:NSLocalizedString(@"服务", @""
                                                 )];
    UIImage *bgImage = nil;
    /*
    UIImageWithFileName(bgImage, @"server_bg.png");
    mesgeCoutV = [[UIImageView alloc]initWithFrame:CGRectZero];
    mesgeCoutView.
    */
    [self setRightBtnHidden:YES];
     [self setHiddenLeftBtn:YES];
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
   
}

- (void)addFonterView{
    logInfo.scrollEnabled = NO;
    CGFloat currY = kMBAppTopToolBarHeight+10.f+52*3.f+10.f;
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"server_urge_btn.png" withHightBGImageName:@"server_urge_btn.png" withTitle:@"" withTag:0];
    [self.view addSubview:oilAnalaysisBtn];
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    
    oilAnalaysisBtn.frame = CGRectMake(10.f,currY,btnsize.width ,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark -

- (void)didTouchButton:(id)sender{

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.section == 1 &&
    //        (indexPath.row == 1 || indexPath.row == 2)) {
    //        return [UIShareCell cellHeight];
    //    }
    
    return  kCellItemHeight;
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
	
	FriendItemCell *cell = nil;
    
	cell = [tableView dequeueReusableCellWithIdentifier:LabelTextFieldCell];
	
    
    if (cell == nil)
    {
#if 1
		//cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelTextFieldCell];
        cell  = [FriendItemCell getFromNibFile];
        //cell.reuseIdentifier = LabelTextFieldCell;
        cell.backgroundColor = [UIColor whiteColor];
        
        //cell.clipsToBounds = YES;
        //cell.contentView.clipsToBounds = YES;
        
        //cell.contentView.backgroundColor = [UIColor clearColor];
        cell.indictTextLabel.font = [UIFont systemFontOfSize:17];
        
        cell.indictTextLabel.textColor = HexRGB(100, 100, 102);
        
        
        
#else
        cell = [[SettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelTextFieldCell];
        SafeAutoRelease(cell);
#endif
	}
    
    int index = [indexPath row];
    NSString *imageStr = [NSString stringWithFormat:@"table%d.png",index+1];
    cell.indictTextLabel.text = kSectionOneArr[index];
    UIImageWithFileName(UIImage *bgImage,imageStr);
    UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
    bgView.frame = CGRectMake(0.f, 0.f,300.f,42.f);
    
    UIImageWithFileName(bgImage,kImageTextArr[index]);
    cell.userIconImageView.image = bgImage;
    //cell.imageView.frame =
    [cell insertSubview:bgView belowSubview:cell.contentView];
    //[cell.contentView  addSubview: bgView];
    cell.backgroundView = bgView;
    SafeRelease(bgView);

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    if(indexPath.row == 0){
        if(popup == nil)
        {
            UIImage *bgImage = nil;
            UIImageWithFileName(bgImage,@"mes_bubble.png");
            popup = [[UIButton alloc]initWithFrame:CGRectZero];
            popup.titleLabel.adjustsFontSizeToFitWidth = YES;
            popup.titleLabel.textColor = [UIColor whiteColor];
            //popup.titleEdgeInsets = UIEdgeInsetsMake(0.f,2.f,6.f,2.f);
            popup.titleLabel.font = kAppTextBoldSystemFont(13);
            //popup.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter;
            [popup setBackgroundImage:bgImage forState:UIControlStateNormal];
            popup.userInteractionEnabled = NO;
            [cell addSubview: popup];
            popup.frame = CGRectMake(160.f, 20.f, bgImage.size.width/kScale+5, bgImage.size.height/kScale);
            SafeRelease(popup);
        }
        NSInteger num = [[[UIApplication sharedApplication]delegate]mesCount];
        if(num >0)
        {
            [popup setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
            popup.hidden = NO;
        }
        else
        {
            popup.hidden = YES;
        }
    }

    
	return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
    
        MesssageBoxViewController *msgVc = [[MesssageBoxViewController alloc]init];
        [self.navigationController pushViewController:msgVc  animated:YES];
        SafeRelease(msgVc);
    }
}
#pragma mark -
#pragma mark net work
- (void)shouldLoadUserInfoData{
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    NSString *userName = @"";
    NSString *userPassword = @"";
#if 1
    userName = [AppSetting getLoginUserId];
    userPassword = [AppSetting setLoginUserPassword];
#else
    userName = @"kkzhan";
    userPassword= @"123456";
#endif
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           userName,@"name",
                           userPassword,@"password",
                           nil];
    [cardShopMgr carUserLogin:param];
}
-(void)didNetDataOK:(NSNotification*)ntf{
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kResRouterDataDay]){
        //[AppSetting setLoginUserInfo:data withUserKey:[AppSetting getLoginUserId]];
        [logInfo reloadData];
    }
    
}
-(void)popNewMSGNotify:(NSNotification*)ntf
{
    UITableViewCell *cell = [logInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

#if 0
    CMPopTipView *popup = [[CMPopTipView alloc]initWithMessage:@"10"];
    popup.disableTapToDismiss  = YES;
    popup.hidden = NO;
#else
//    if(popup == nil)
//    {
//        UIImage *bgImage = nil;
//        UIImageWithFileName(bgImage,@"mes_bubble.png");
//        popup = [[UIButton alloc]initWithFrame:CGRectZero];
//        popup.titleLabel.adjustsFontSizeToFitWidth = YES;
//        popup.titleLabel.textColor = [UIColor whiteColor];
//        //popup.titleEdgeInsets = UIEdgeInsetsMake(0.f,2.f,6.f,2.f);
//        popup.titleLabel.font = kAppTextBoldSystemFont(13);
//        //popup.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter;
//        [popup setBackgroundImage:bgImage forState:UIControlStateNormal];
//        popup.userInteractionEnabled = NO;
//        //UIButton *view = [currentTabBar.navBarArr objectAtIndex:3];
//        CGRect rect = CGRectMake(0.f,80.f, bgImage.size.width/kScale+5,bgImage.size.height/kScale);
//        [cell addSubview:popup];
//        [popup release];
//        
//    }
    //NSString *num = [ntf object];
    [logInfo reloadData];
#endif
}
@end
