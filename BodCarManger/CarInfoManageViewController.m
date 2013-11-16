//
//  CarInfoManageViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarInfoManageViewController.h"
#import "CarInfoInputViewController.h"

static NSString *kCarInfoArray[] =
{
    @"车辆品牌",@"车牌型号",@"车牌号",
};
static NSString *kCarOtherInfoArray[] = {
    @"行驶总里程",@"上次保养里程",@"上次保养日期",@"保险到期日",
};
static NSString  *CarInfoKeyArray[] = {
   @"OBD",@"",@"",@"",
};
@interface CarInfoManageViewController (){
    NSInteger type ;
    BOOL isNeedFresh;
}
@end

@implementation CarInfoManageViewController

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
    
    
    [self setHiddenLeftBtn:NO];
    [self setNavgationBarTitle:@"车辆和设备信息"];
    self.data = [AppSetting getLoginUserCarData];
    //[self shouldLoadCarInfoData];
	// Do any additional setup after loading the view.
    isNeedFresh = YES;
    [self performSelectorInBackground:@selector(shouldLoadDataFromNet) withObject:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController popToRootViewControllerAnimated:NO];
    //[logInfo reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 2)
        return 4;
    else if (section == 0)
    {
        return 1;
    }
    else
    {
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *LabelTextFieldCell = @"LabelTextFieldCell";
	
	UITableViewCell *cell = nil;
    
	cell = [tableView dequeueReusableCellWithIdentifier:LabelTextFieldCell];
	
    
    if (cell == nil)
    {
#if 1
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LabelTextFieldCell];
        cell.backgroundColor = [UIColor clearColor];
        
        //cell.clipsToBounds = YES;
        //cell.contentView.clipsToBounds = YES;
        
        //cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.textLabel.textColor = HexRGB(64, 64, 64);
        
        
#else
        cell = [[SettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelTextFieldCell];
        SafeAutoRelease(cell);
#endif
	}
    /*
     
     [resultDict setValue:[info get:@"retType"] forKey:@"retType"];
     [resultDict setValue:[info get:@"milage"] forKey:@"milage"];
     [resultDict setValue:[info get:@"insureExpDate"] forKey:@"insureExpDate"];
     [resultDict setValue:[info get:@"model"] forKey:@"model"];
     [resultDict setValue:[info get:@"vin"] forKey:@"vin"];
     [resultDict setValue:[info get:@"brandy"] forKey:@"brandy"];
     [resultDict setValue:[info get:@"NO"] forKey:@"NO"];
     [resultDict setValue:[info get:@"lastmaintainDate"] forKey:@"lastmaintainDate"];
     [resultDict setValue:[info get:@"OBD"] forKey:@"OBD"];
     */
    
    
    
    
    int index = [indexPath row];
    NSString *bgImageName = nil;
    NSString *tempText = @"";
    NSString *dataText = @"";
    switch (indexPath.section)
    {
        
        case 0:
            bgImageName = @"setting_cell_one.png";
            cell.textLabel.text = @"OBD设备号";
            tempText = [self.data objectForKey:@"OBD"];
            if(tempText){
                dataText = tempText;
            }
            break;
        case 1:{
            cell.textLabel.text = kCarInfoArray[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    bgImageName = @"setting_cell_header.png";
                    tempText = [self.data objectForKey:@"brandy"];
                    if(tempText){
                        dataText = tempText;
                    }
                    break;
                case 2:
                    tempText = [self.data objectForKey:@"model"];
                    if(tempText){
                        dataText = tempText;
                    }
                    bgImageName = @"setting_cell_footer.png";
                    break;
                    
                default:
                    tempText = [self.data objectForKey:@"NO"];
                    if(tempText){
                        dataText = tempText;
                    }
                    bgImageName = @"setting_cell_middle.png";
                    break;
            }
            
        }
            break;
        case 2:{
            cell.textLabel.text = kCarOtherInfoArray[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    bgImageName = @"setting_cell_header.png";
                    tempText = [self.data objectForKey:@"milage"];
                    if(tempText){
                        dataText = [NSString stringWithFormat:@"%d",[tempText intValue]];
                    }
                    break;
                case 3:
                    tempText = [self.data objectForKey:@"insureExpDate"];
                    if(tempText &&[tempText intValue]){
                        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
                        [dateFormat setDateFormat:@"yyyyMMdd"];
                        
                        //NSString *dateString = [dateFormat dateFromString:tempText];
                        NSDate *date = [dateFormat dateFromString:tempText];
                        
                        [dateFormat setDateFormat:@"yyyy年MM月dd日"];
                        NSString *dateString = [dateFormat stringFromDate:date];
                        //self.subClassInputTextField.text = dateString;
                        dataText = dateString;
                        SafeRelease(dateFormat);
                    }
                    bgImageName = @"setting_cell_footer.png";
                    break;
                default:
                    switch (indexPath.row) {
                        case 1:
                            tempText = [self.data objectForKey:@"lastMilage"];
                            if(tempText&&[tempText intValue]){
                                dataText = [NSString stringWithFormat:@"%d",[tempText intValue]];
                            }
                            break;
                        case 2:
                            tempText = [self.data objectForKey:@"lastmaintainDate"];
                            if(tempText&&![tempText isEqualToString:@""]){
                                NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
                                [dateFormat setDateFormat:@"yyyyMMdd"];
                                
                                //NSString *dateString = [dateFormat dateFromString:tempText];
                                NSDate *date = [dateFormat dateFromString:tempText];
                                
                                [dateFormat setDateFormat:@"yyyy年MM月dd日"];
                                NSString *dateString = [dateFormat stringFromDate:date];
                                
                                dataText = dateString;
                                SafeRelease(dateFormat);
                            }
                            break;
                        default:
                            break;
                    }
                    bgImageName = @"setting_cell_middle.png";
                    break;
            }
        
        }
            
    }
    cell.detailTextLabel.text = dataText;
    UIImageWithFileName(UIImage *bgImage,bgImageName);
    UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
    bgView.frame = CGRectMake(0.f, 0.f,300.f,42.f);
    
    //[cell insertSubview:bgView belowSubview:cell.contentView];
    //[cell.contentView  addSubview: bgView];
    cell.backgroundView = bgView;
    SafeRelease(bgView);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.backgroundColor = [UIColor clearColor];
	return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    int type = 0;
    
    if(indexPath.section == 2){
        if(indexPath.row == 3||indexPath.row == 2){
//            NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//            [dateFormat setDateFormat:@"yyyyMMdd"];
//            NSDate *date = [dateFormat dateFromString:cell.detailTextLabel.text];
//            datePickView.hidden = NO;
//            [datePickView setDate:date animated:YES];
//            return;
            type  =1;
        }
        
    }
    CarInfoInputViewController *changeDataVc = [[CarInfoInputViewController alloc]init];
    changeDataVc.userEmail = cell.detailTextLabel.text;
    changeDataVc.barTitle = cell.textLabel.text;
    changeDataVc.type = type;
    changeDataVc.delegate = self;
    changeDataVc.indexPath = indexPath;
    [self.navigationController pushViewController:changeDataVc animated:YES];
    SafeRelease(changeDataVc);
}
#pragma mark -
#pragma mark net work
- (void)shouldLoadDataFromNet{
    if(!isNeedFresh){
        return;
    }
    kNetStartShow(@"数据加载...", self.view);
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    NSString *useName = [AppSetting getLoginUserId];
    [cardShopMgr carInforQuery:useName];
    isNeedFresh = NO;
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    id obj = [ntf object];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kCarInfoQuery])
    {
        self.data = data;
        if([[self.data objectForKey:@"retType"]intValue]== 0){
            /*
             [inInfo set:@"brandy" value:[param objectForKey:@"brandy"]];
             [inInfo set:@"model" value:[param objectForKey:@"model"]];
             [inInfo set:@"NO" value:[param objectForKey:@"NO"]];
             [inInfo set:@"milage" value:[param objectForKey:@"milage"]];
             [inInfo set:@"lastMilage" value:[param objectForKey:@"lastMilage"]];
             [inInfo set:@"lastmaintainDate" value:[param objectForKey:@"lastmaintainDate"]];
             //[inInfo set:@"type" value:[NSString stringWithFormat:@"%d",type]];
             [inInfo set:@"type" value:[param objectForKey:@"type"]];
             [inInfo set:@"insureExpDate" value:[param objectForKey:@"insureExpDate"]];
             */
            self.data = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"0",@"type",
                         @"",@"brandy",
                         @"",@"model",
                         @"",@"NO",
                         @"wwdbac2160132100397",@"OBD",
                         @"",@"milage",
                         @"",@"lastMilage",
                         @"",@"lastmaintainDate",
                         @"",@"insureExpDate",
                         nil];
        }
        if([self.data objectForKey:@"vin"]){
            NSString *userId = [AppSetting getCurrentLoginUser];
            [AppSetting setUserCarId:[self.data objectForKey:@"vin"] withUserId:userId];
        }
        [AppSetting setLoginUserCarData:self.data];
        [logInfo reloadData];
        kNetEnd(self.view);
        
    }
    if([resKey isEqualToString:kCarInfoUpdate]){
        
        kNetEnd(self.view);
        if([[data objectForKey:@"retType"]intValue]== 0){
            kUIAlertView(@"信息",@"车辆信息更新成功");
        }
        else{
            kUIAlertView(@"信息", @"车辆信息更新失败")
        }
        
        
    }
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEnd(@"", 2.f);
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request ==respRequest && [resKey isEqualToString:kCarInfoUpdate])
    {
        kNetEnd(self.view);
    }
   
}
- (void)addFonterView{
    
    //    logInfo.frame = CGRectMake(0,kMBAppTopToolBarHeight-self.mainContentViewPendingY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60 );
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f,0.f,300.f,80)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    
    CGFloat currY = kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60+10.f;
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"save.png" withHightBGImageName:@"save.png" withTitle:@"" withTag:0];
    
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    currY = 10.f;
    oilAnalaysisBtn.frame = CGRectMake(10.f,currY,btnsize.width,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(logOutConfirm:) forControlEvents:UIControlEventTouchUpInside];
    //[logInfo addSubview:oilAnalaysisBtn];
    //
    [bgView addSubview:oilAnalaysisBtn];
    [logInfo setTableFooterView:bgView];
}
- (void)logOutConfirm:(id)sender{
    kNetStartShow(@"数据保存中...", self.view);
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    NSString *useName = [AppSetting getLoginUserId];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:self.data];
    [param setValue:useName forKey:@"userName"];
    [cardShopMgr carInforUpdate:param withType:0];
}
- (void)setCellItemData:(NSString*)text withIndexPath:(NSIndexPath*)indexPath{
    
    //UITableViewCell *cell = [logInfo cellForRowAtIndexPath:indexPath];
    //cell.detailTextLabel.text = text;
    
    //int index = [indexPath row];
    NSString *key = nil;
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:self.data];
    switch (indexPath.section)
    {
            
        case 0:
            key = @"OBD";
            break;
        case 1:{
            
            switch (indexPath.row) {
                case 0:
                    key = @"brandy";
                    
                    break;
                case 2:
                    key =@"model";
                    
                    break;
                    
                default:
                    key = @"NO";
            }
            
        }
            break;
        case 2:{
            //cell.textLabel.text = kCarOtherInfoArray[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    key = @"milage";
                    
                    break;
                case 3:
                    key = @"insureExpDate";
                    
                    break;
                default:
                    switch (indexPath.row) {
                        case 1:
                            key = @"lastMilage"
                            ;
                            
                            break;
                        case 2:
                            key = @"lastmaintainDate";
                            
                            break;
                        default:
                            break;
                    }
                    //bgImageName = @"setting_cell_middle.png";
                    break;
            }
            
        }
            
    }
    if(key)
        [newDict setValue:text forKey:key];
    self.data = newDict;
    [logInfo reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationLeft];
}


@end
