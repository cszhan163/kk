//
//  CarStatusViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#define kCheckViewPendingX  10.f
#define kCheckViewPendingY  10.f

#import "DDProgressView.h"
#import "CarDriveOilTableViewCell.h"


#import "CarStatusViewController.h"


#import "CarCheckTableViewCell.h"

@interface CarStatusViewController (){

    UIProgressView *checkProcessView;
    UILabel        *rotateSpeedLabel;
    UILabel           *temperatureLabel;
    UIImageView         *checkTagImageView ;
    UILabel         *checkProcessLabel;
}
@end

@implementation CarStatusViewController

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
    
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    [self setNavgationBarTitle:NSLocalizedString(@"车辆健康监测", @""
                                                 )];
    [self setRightBtnHidden:YES];
    [self setHiddenLeftBtn:YES];
    
    CGFloat currY =  kMBAppTopToolBarHeight;
    
    UIImageWithFileName(bgImage, @"car_check_header.png");
    
    UIImageView *headerView = [[UIImageView alloc]initWithImage:bgImage];
    
    headerView.frame = CGRectMake(kCheckViewPendingX,currY+kCheckViewPendingY ,bgImage.size.width/kScale, bgImage.size.height/kScale);
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    UIButton *checkButton = [UIComUtil createButtonWithNormalBGImageName:@"car_check_btn.png" withHightBGImageName:@"car_check_btn.png" withTitle:@"" withTag:0];
    
    [checkButton addTarget:self action:@selector(startCarHealthCheck:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:checkButton];
    checkButton.frame = CGRectMake(headerView.frame.size.width-100-16,7,checkButton.frame.size.width,checkButton.frame.size.height);
    
    CGFloat  headerY = 5.f;
    rotateSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(38,headerY, 120.f, 20)];
    rotateSpeedLabel.font = [UIFont fontWithName:@"DIGIFACEWIDE" size:12];
    rotateSpeedLabel.text = @"3200 转";
    rotateSpeedLabel.textColor = [UIColor whiteColor];
    rotateSpeedLabel.backgroundColor = [UIColor clearColor];
    
    
    [headerView addSubview:rotateSpeedLabel];
    SafeRelease(rotateSpeedLabel);
    
    temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(38,headerY+20, 120.f, 20)];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.font = kUserDigiFontSize(12);
    temperatureLabel.text = @"90 C";
    temperatureLabel.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:temperatureLabel];
    SafeRelease(temperatureLabel);
    
    
    currY = currY+headerView.frame.size.height+kCheckViewPendingX;
    
#if 0
    checkProcessView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    checkProcessView.progress = 0.4;
    //checkProcessView.progressTintColor = [UIColor blackColor];
    //checkProcessView.trackImage = [UIImage imageWith]HexRGB(44, 45, 47);
    checkProcessView.frame = CGRectMake(106,currY+57,186,5);
    [self.view addSubview:checkProcessView];
    KokSafeRelease(checkProcessView);
#else
    DDProgressView *processView = [[DDProgressView alloc]initWithFrame:CGRectMake(106,currY+57,186,10)];
    processView.innerColor = [UIColor greenColor];
    processView.outerColor = [UIColor whiteColor];
    processView.emptyColor = [UIColor blackColor];
    processView.progress = 0.4;
    [self.view addSubview:processView];
    
    UIImageWithFileName(bgImage, @"car_check_header.png");
    

    
#endif
    //for headerLabel
    UIImageWithFileName(bgImage, @"car_check_label.png");
    UIImageView *checkProcessImageView = [[UIImageView alloc]initWithImage:bgImage];
    
    checkProcessImageView.frame = CGRectMake(106,currY+30 ,bgImage.size.width/kScale, bgImage.size.height/kScale);
    checkProcessImageView.userInteractionEnabled = YES;
    [self.view addSubview:checkProcessImageView];
    SafeRelease(checkProcessImageView);
    CGRect textRect = CGRectMake(checkProcessImageView.frame.size.width+106+5,currY+30, 150, 15);
    checkProcessLabel  = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:8] withTextColor:HexRGB(36, 220, 0) withText:@"监测燃油导轨轨压力" withFrame:textRect];
    checkProcessLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:checkProcessLabel];
    SafeRelease(checkProcessLabel);
    
    
    
    
    UIImageWithFileName(bgImage, @"car_check_status_low.png");
    
    checkTagImageView = [[UIImageView alloc]initWithImage:bgImage];
    
    checkTagImageView.frame = CGRectMake(23,currY+12,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:checkTagImageView];
    SafeRelease(checkTagImageView);
    currY = currY+184/2.f;
    
  
    tweetieTableView.frame = CGRectMake(kCheckViewPendingX,currY,kDeviceScreenWidth-2*kCheckViewPendingX+1,202.f);
    UIImageWithFileName(bgImage, @"car_check_gridtable_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
    tableViewBg.frame = tweetieTableView.frame;
    [tweetieTableView removeFromSuperview];
    [tableViewBg addSubview:tweetieTableView];
    tweetieTableView.frame = CGRectMake(0.f,0.f,tableViewBg.frame.size.width,tableViewBg.frame.size.height);
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = NO;
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    
    
#if 1
    UIImageWithFileName(bgImage, @"car_check_gridtable_header.png");
    
    UIImageView *tbHeaderView = [[UIImageView alloc]initWithImage:bgImage];
    
    tbHeaderView.frame = CGRectMake(kCheckViewPendingX,currY,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:tbHeaderView];
    SafeRelease(tbHeaderView);
    //[tweetieTableView setTableHeaderView:tbHeaderView];
#endif
    CGFloat height = tbHeaderView.frame.size.height;
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(height,0.f,0.f,0.f);
    
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark
- (void)startCarHealthCheck:(id)sender{
    
    
}

#pragma mark -
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  10;
    //return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    CarDriveOilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"CarDriveOilTableViewCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[CarDriveOilTableViewCell class]])
                cell = (CarDriveOilTableViewCell*)oneObject;
        [cell setClounmLineColor:[UIColor greenColor]];
#else
        cell = [[CarCheckTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        SafeAutoRelease(cell);
        
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        
    }
    if(indexPath.row == 9){
        [cell setRowLineHidden:YES];
    }
    [cell setTableCellCloumn:0 withData:@"第一条"];
    [cell setTableCellCloumn:1 withData:@"0~100"];
    [cell setTableCellCloumn:2 withData:@"50"];
    /*
     "driveflg": "1",
     "starttime": "17:54",
     "distance": "12",
     "time": "43",
     "oil": "25",
     "startadr": "张江地铁",
     "endadr": "人民广场",
     "startadr2": "121.607931, 31.211412",
     "endadr2": "121.48117, 31.236416",
     "rotate": "86",
     "speed": "34",
     "water temp": "64",
     "oiltest": "8",
     "drivetest": "7"
     */
    UIImage *bgImage = nil;
    
    //
    //    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    //    NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    //cell = (PlantTableViewCell*)cell;
    
	//cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 18.f;
}

@end
