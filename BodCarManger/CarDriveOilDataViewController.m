//
//  CarDriveOilDataViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-10-5.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveOilDataViewController.h"
#import "CarDriveOilTableViewCell.h"
#import "DriveOilAnalysisView.h"
typedef enum  viewType{
    View_List,
    View_Graph,
}ViewType;


@interface CarDriveOilDataViewController (){

     ViewType viewType;
}
@end

@implementation CarDriveOilDataViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIImage *bgImage = nil;
    //tweetieTableView.hidden = YES;
    mainView.backgroundColor = [UIColor clearColor];
    //tweetieTableView.frame = CGRectMake(0.f,0.f,300.f,380.f);
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
#if 0
  
    //UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    //[self.view  addSubview:tableViewBg];
    //tableViewBg.frame = tweetieTableView.frame;
    //[tweetieTableView removeFromSuperview];
    //[tableViewBg addSubview:tweetieTableView];
    
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(50.f,0.f,0.f,0.f);
    tweetieTableView.frame = CGRectMake(0.f,0.f,bgImage.size.width/kScale,bgImage.size.height/kScale);
    //    tableViewBg.clipsToBounds = YES;
    //    tableViewBg.userInteractionEnabled = YES;
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    tweetieTableView.bounces = NO;
    tweetieTableView.showsVerticalScrollIndicator = NO;
    [tweetieTableView scrollsToTop];
  
    
#else
    tweetieTableView.hidden = YES;
    DriveOilAnalysisView *oilAnalysisView = [[DriveOilAnalysisView alloc]initWithFrame:
                                             CGRectMake(10.f,0.f,bgImage.size.width,bgImage.size.height)];
    [self.view addSubview:oilAnalysisView];
    oilAnalysisView.backgroundColor = [UIColor redColor];
    [oilAnalysisView updateUIByData:nil];
    return ;
    
    dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.f, 300.f,300)];
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    dataTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dataTableView];
    SafeRelease(dataTableView);
#endif
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[dataAnaylsisView setNeedsDisplay];
}

- (void)swithDataViewType{
   

}
#pragma mark -
#pragma mark tableview
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImage *bgImage = nil;
    mainView.backgroundColor = [UIColor clearColor];
    //tweetieTableView.frame = CGRectMake(0.f,0.f,300.f,380.f);
    UIImageWithFileName(bgImage, @"oil_table_header.png");
    /*UIView *tableSectionView = [UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, <#CGFloat width#>, <#CGFloat height#>)
        */
    UIImageView *tableHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, bgImage.size.width/kScale, bgImage.size.height/kScale)];
    tableHeaderView.image = bgImage;
    
    return SafeAutoRelease(tableHeaderView);;
}
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
        cell = [[CarDriveOilTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        SafeAutoRelease(cell);
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    if(indexPath.row == 10){
        [cell setSeperateLineHidden:YES];
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
    
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     CarRouterDetailViewController *vc = [[CarRouterDetailViewController alloc]initWithNibName:nil bundle:nil];
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = data;
     [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
     //[self.navigationController pushViewController:vc animated:YES];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     */
}
- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section{
    if(section == 0){
        
        
    }
}
@end
