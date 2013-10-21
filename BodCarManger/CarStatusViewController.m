//
//  CarStatusViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#define kCheckViewPendingX  10.f
#define kCheckViewPendingY  10.f

#import "CarDriveOilTableViewCell.h"


#import "CarStatusViewController.h"


#import "CarCheckTableViewCell.h"

@interface CarStatusViewController ()

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
    UIImageWithFileName(bgImage, @"BG.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    [self setNavgationBarTitle:NSLocalizedString(@"", @""
                                                 )];
    [self setRightBtnHidden:YES];
    
    
    CGFloat currY =  kMBAppTopToolBarHeight;
    
    UIImageWithFileName(bgImage, @"car_check_header.png");
    
    UIImageView *headerView = [[UIImageView alloc]initWithImage:bgImage];
    
    headerView.frame = CGRectMake(kCheckViewPendingX,currY+kCheckViewPendingY ,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:headerView];
    
    SafeRelease(headerView);
    
    currY = currY+headerView.frame.size.height+kCheckViewPendingX;
    
    
    UIImageWithFileName(bgImage, @"car_check_tag.png");
    
    UIImageView *tagView = [[UIImageView alloc]initWithImage:bgImage];
    
    tagView.frame = CGRectMake(23,currY+12,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:tagView];
    SafeRelease(tagView);
    
    currY = currY+184/2.f;
    
  
    
    tweetieTableView.frame = CGRectMake(kCheckViewPendingX,currY,kDeviceScreenWidth-2*kCheckViewPendingX,202.f);
    UIImageWithFileName(bgImage, @"car_check_gridtable_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
    tableViewBg.frame = tweetieTableView.frame;
    [tweetieTableView removeFromSuperview];
    [tableViewBg addSubview:tweetieTableView];
    tweetieTableView.frame = CGRectMake(0.f,0.f,tableViewBg.frame.size.width,tableViewBg.frame.size.height);
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = YES;
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    
    
#if 0
    UIImageWithFileName(bgImage, @"car_check_gridtable_header.png");
    
    UIImageView *tbHeaderView = [[UIImageView alloc]initWithImage:bgImage];
    
    tbHeaderView.frame = CGRectMake(kCheckViewPendingX-1,currY,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:tbHeaderView];
    SafeRelease(tbHeaderView);
#endif
    CGFloat height = 22.f;//tbHeaderView.frame.size.height;
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
