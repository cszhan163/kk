//
//  MesssageBoxViewController.m
//  DressMemo
//
//  Created by  on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MesssageBoxViewController.h"
#import "CarServiceNetDataMgr.h"
#import "MessageBoxCell.h"
//#import "DBManage.h"
//#import "MyProfileViewController.h"
//#import "DressMemoCommentController.h"

@interface MesssageBoxViewController ()
@property(nonatomic,assign)id clearRequest;
@end

@implementation MesssageBoxViewController
@synthesize clearRequest;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.mainContentViewPendingY = -3.f;
        self.isVisitOther = NO;
    }
    return self;
}
- (void)setEmptyDataUI
{
    
    
    //NSString *defaultBGStr = @"";
    NSString *firstString = @"你没关注任何人";
    NSString *secondString = @"点击,";
    NSString *thirdString = @"就可以关注你喜欢的人!";
    //upload bg image
    UIImage *bgImage = nil;
	UIImageWithFileName(bgImage,@"textblock.png");
    UIImageView *bgImageView = [[UIImageView alloc ]initWithImage:bgImage];
    bgImageView.frame = CGRectMake(0,(404-40)/2.f,bgImage.size.width/kScale, bgImage.size.height/kScale);
    NE_LOGRECT(bgImageView.frame);
    
	UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, bgImage.size.width/kScale, bgImage.size.height/kScale)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = kAppTextItalicSystemFont(18);
    textLabel.textColor = HexRGB(134, 134, 134);
    textLabel.text = @"您暂时没有任何消息";
    textLabel.textAlignment = UITextAlignmentCenter;
    [bgImageView addSubview:textLabel];
    [textLabel release];
    [mainView addSubview:bgImageView];
    [bgImageView release];
    self.myEmptyBgView = bgImageView;
    self.myEmptyBgView.hidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"BG-regis&login.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    
    tweetieTableView.frame = CGRectMake(9.f,kMBAppBottomToolBarHeght+18.f,302,400);
    tweetieTableView.layer.cornerRadius = 8.f;
    [self setNavgationBarTitle:NSLocalizedString(@"Message", @""
                                                )];
    [self setHiddenRightBtn:NO];
    [self setRightTextContent:NSLocalizedString(@"Clear", @"")];
    [self shouldLoadOlderData:tweetieTableView];
	// Do any additional setup after loading the view.
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (void) shouldLoadNewerData:(NTESMBTweetieTableView *) tweetieTableView
{
    NSLog(@"loader new data");
    //    if(isRefreshing)
    //        return;
    [super shouldLoadNewerData:tweetieTableView];
}
- (void)shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
#if 0 
    if(isRefreshing)
        return;
#endif  
    [super shouldLoadOlderData:tweetieTableView];
    NSLog(@"loader old data");
    //[self startShowLoadingView];
    [self getUserMessageList];
    //[self getPostMemos];
    //[memoTimelineDataSource getOldData];
}
#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return 10;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *cellId = @"FriendCell";

    MessageBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) 
    {
        //cell = [[MessageBoxCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"MessageBoxCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[MessageBoxCell class]])
                cell = (MessageBoxCell*)oneObject;
    }
	//cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    [self setItemCell:cell withIndex:indexPath];
    UIImage *bgImageName = nil;
    
    int max = [self.dataArray count]-1;
    
    if(indexPath.row == 0)
        bgImageName = @"msg_table_header.png";
    else if(indexPath.row == max)
        bgImageName = @"msg_table_footer.png";
    else
        bgImageName = @"msg_table_middle.png";
    
    UIImageWithFileName(UIImage *bgImage,bgImageName);
    UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
    bgView.frame = CGRectMake(0.f, 0.f,300.f,42.f);
    cell.backgroundView = bgView;
    SafeRelease(bgView);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    /*
     int pushMesType;               //消息类型
     //0:系统消息 1:行程消息
     //2：报警消息 3：故障消息
     //4：需回复消息
     */
    
    
    
    cell.mMsgTextLabel.text = [item objectForKey:@"pushMesCon"];
    cell.mDateLabel.text = [item objectForKey:@"createdTime"];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSDictionary *itemData = [self.dataArray objectAtIndex:indexPath.row];
    return [MessageTableViewCell cellHeight:itemData];
     */
    return 94;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSDictionary *itemData= [self.dataArray objectAtIndex:indexPath.row];
    MyProfileViewController *userProfileVc = [[MyProfileViewController alloc]init];
    userProfileVc.userId = [itemData objectForKey:@"uid"];
    userProfileVc.isVisitOther = YES;
    assert(userProfileVc.userId);
    [self.navigationController pushViewController:userProfileVc animated:YES];
    [userProfileVc release];
    */
}
-(void)setItemCell:(MessageTableViewCell*)cell  withIndex:(NSIndexPath*)indexPath
{
    /*
    DBManage *dbMgr = [DBManage getSingleTone];
    NSDictionary *itemData = [self.dataArray objectAtIndex:indexPath.row];
    [cell.nickNameBtn addTarget:self action:@selector(didTouchNickNameTitle:)  forControlEvents:UIControlEventTouchUpInside];
    cell.nickNameBtn.tag = indexPath.row;
    //cell.locationLabel.text = [itemData objectForKey:@"city"];
    NSString *msgTimeStr = [itemData objectForKey:@"addtime"];
    NSDate  *resignTime = [NSDate  dateWithTimeIntervalSince1970:[msgTimeStr longLongValue]];
    cell.timeLabel.text = [resignTime memoFormatTime:@"YYYY-MM-dd HH:mm"];
    //cell.timeLabel.text =
   // NSString *iconUrl = [itemData objectForKey:@"avatar"];
    
   // if(iconUrl == nil||[iconUrl isEqualToString:@""])
    {
        [cell.userIconImageView setImage:[dbMgr getItemCellUserIconImageDefault]];
    }

    if([[itemData objectForKey:@"type"] isEqualToString:@"follow"])
    {
        cell.cellType = MessageCell_Follow;
    }else if([[itemData objectForKey:@"type"] isEqualToString:@"comment"])
    {
        cell.cellType = MessageCell_Comment;
        [cell.memoThumbImage loadPicWithPath:[itemData objectForKey:@"picpath"]];
        
    }else if([[itemData objectForKey:@"type"] isEqualToString:@"reply"])
    {
        cell.cellType = MessageCell_ReComment;
    }
    
    
    [self startloadInitCell:cell  withIndexPath:indexPath];
    cell.msgData = itemData;
    cell.userInteractionEnabled = YES;
    cell.delegate = self;
    [cell setNeedsLayout];
     */
}

#pragma mark icon image data source
-(NSString*)userIconNameForIndexPath:(NSIndexPath*)indexPath
{
    NSString *iconImageName = nil;
    if([self.dataArray count]>indexPath.row)
    {
        id cellItem = [self.dataArray objectAtIndex:indexPath.row];
        
        iconImageName = [cellItem objectForKey:@"favatar"];
    }
    return iconImageName;
}
-(void)setCellUserIcon:(UIImage*)iconImage withIndexPath:(NSIndexPath*)indexPath
{
    //NSString *iconUrl = [itemData objectForKey:@"avatar"];
    //if(iconUrl == nil||[iconUrl isEqualToString:@""])
//    FriendItemCell *cell = (FriendItemCell*)[tweetieTableView cellForRowAtIndexPath:indexPath];
//    if(iconImage)
//    {
//        [cell.userIconImageView setImage:iconImage];
//        //[cell.userIconImageView setNeedsDisplay];
//    }
}
-(void)setCell:(id)cell withImageData:(UIImage*)imageData withIndexPath:(NSIndexPath*)indexPath
{
//    FriendItemCell *realCell = (FriendItemCell*)cell;
//    
//    if(imageData)
//    {
//        [realCell.userIconImageView setImage:imageData];
//        //[cell.userIconImageView setNeedsDisplay];
//    }
}
#pragma mark -
#pragma mark net work

-(void)getUserMessageList
{
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",currentPageNum];
    
    
    CarServiceNetDataMgr *netMgr = [CarServiceNetDataMgr getSingleTone];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AppSetting getLoginUserId],@"userName",
                           nil];
    
    self.request = [netMgr getMessageList:param];
     
    
}
-(void)alterClearConfirm
{
    UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示", @"")message:NSLocalizedString(@"是否确认全部清除?",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",@"") otherButtonTitles:NSLocalizedString(@"Ok",@""),nil]autorelease];
    [alertErr show];


}
-(void)didTouchNickNameTitle:(id)sender
{
    int index = [sender tag];
    NSDictionary *itemData = [self.dataArray objectAtIndex:index];
    NSMutableDictionary *newitemData = [NSMutableDictionary dictionaryWithDictionary:itemData];
    //[newitemData setValue:@"1" forKey:@"status"];
//    MyProfileViewController *userProfileVc = [[MyProfileViewController alloc]init];
//    userProfileVc.userId = [itemData objectForKey:@"fuid"];
//    
//    userProfileVc.userData = newitemData;
//    userProfileVc.isVisitOther = YES;
//    assert(userProfileVc.userId);
//    [self.navigationController pushViewController:userProfileVc animated:YES];
//    [userProfileVc release];
    
}
#pragma mark 
-(void)didSelectorTopNavItem:(id)navObj{
	NE_LOG(@"select item:%d",[navObj tag]);
    
	switch ([navObj tag])
	{
		case 0:
        {
            //if(self.isVisitOther)
            {
                [self.navigationController popViewControllerAnimated:YES];// animated:
            }
            
        }
			break;
		case 1:
		{
            
			[self alterClearConfirm];
			break;
		}
	}
}
#pragma mark  -
#pragma mark logout confir delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        
        //[self.navigationController popToRootViewControllerAnimated:NO];
        kNetStartShow(NSLocalizedString(@"清除中", @""),self.view);
        /*
        ZCSNetClientDataMgr *netMgr = [ZCSNetClientDataMgr getSingleTone];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        self.clearRequest = [netMgr     clearMSGNotify:param];
         */
    }
}

#pragma mark -tableview cell delegate
- (void)btnPressedInCell:(MessageTableViewCell *)cell{
//    DressMemoCommentController *tc = [[DressMemoCommentController alloc] init];
//    tc.type = Comment_Relpy;//for comment;
//    
//    NSString *messgeID = nil;
//    if([[cell.msgData objectForKey:@"type"] isEqualToString:@"comment"]){
//        messgeID = [cell.msgData objectForKey:@"commentid"];
//        
//    }else if([[cell.msgData objectForKey:@"type"] isEqualToString:@"reply"]){
//        messgeID = [cell.msgData objectForKey:@"replyid"];
//    }
//    
//    tc.data = [NSDictionary dictionaryWithObjectsAndKeys:
//               messgeID ,@"commentid",
//               nil];
//    [tc showWithController:self];
//    [tc release];
}
#pragma mark -reflush
-(void)didNetDataOK:(NSNotification*)ntf
{
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj  objectForKey:@"key"];
    if([resKey isEqualToString:resKey])
    {
        self.request = nil;
        //[self stopShowLoadingView];
        /*
        [self processReturnData:data];
        if([data count])
        currentPageNum++;
        [self reloadAllData];
        if([self.dataArray count]==0)
        {
            self.myEmptyBgView.hidden = NO;
            tweetieTableView.hidden = YES;
        }
        else
        {
            self.myEmptyBgView.hidden  = YES;
            tweetieTableView.hidden = NO;
        }
        if (self.reflushType == Reflush_OLDE)
        {
            [tweetieTableView closeBottomView];
        }
        else
        {
            [tweetieTableView closeInfoView];
        }
         */
        self.dataArray = [data objectForKey:@"messageBox"];
        [self reloadAllData];
    }
    if(self.clearRequest == respRequest)
    {
        kNetEndSuccStr(@"消息已清空",self.view);
        tweetieTableView.hidden = YES;
        self.myEmptyBgView.hidden = NO;
        //[self.navigationController popViewControllerAnimated:YES];
    }
   
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    [super didNetDataFailed:ntf];
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    if(self.clearRequest ==respRequest && [resKey isEqualToString:@"clear"])
    {
        kNetEnd(self.view);
        if (self.reflushType == Reflush_OLDE)
        {
            [tweetieTableView closeBottomView];
        }
        else
        {
            [tweetieTableView closeInfoView];
        }
    }
    //NE_LOG(@"warning not implemetation net respond");
}
@end
