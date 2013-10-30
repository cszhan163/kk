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
#import "BSPreviewScrollView.h"


#define kOilDataViewWidth   300

#define kOilDataViewHeight  400

typedef enum  viewType{
    View_List,
    View_Graph,
}ViewType;


@interface CarDriveOilDataViewController ()<UIBaseViewControllerDelegate>{
    DriveOilAnalysisView *oilAnalysisGraphView;
     ViewType viewType;
}
@end

@implementation CarDriveOilDataViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = [UIColor clearColor];
    UIImage *bgImage = nil;
    //tweetieTableView.hidden = YES;
    mainView.backgroundColor = [UIColor clearColor];
    //tweetieTableView.frame = CGRectMake(0.f,0.f,300.f,380.f);
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
#if ScrollerView
  
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
    tweetieTableView.hidden = YES;
    
    
    oilAnalysisGraphView = [[DriveOilAnalysisView alloc]initWithFrame:
                                             CGRectMake(10.f,35.f,bgImage.size.width,bgImage.size.height)];
    oilAnalysisGraphView.backgroundColor = [UIColor redColor];
    [self.view addSubview:oilAnalysisGraphView];
    [oilAnalysisGraphView updateUIByData:nil];
    viewType = View_Graph ;
    
#else
    CGFloat currY = 0.f;
    CGRect viewRect = CGRectMake(0.f,0.f,bgImage.size.width/kScale,bgImage.size.height/kScale);
    
    
    CGSize size = viewRect.size;//CGSizeMake(viewRect.size, bgImage.size.height/kScale);
    BSPreviewScrollView *scrollerView = [[BSPreviewScrollView alloc]initWithFrameAndPageSize:CGRectMake(0.f, 0.f,size.width, size.height) pageSize:size];
    scrollerView.delegate = self;
    [scrollerView setBoundces:NO];
    scrollerView.backgroundColor = [UIColor clearColor];
    scrollerView.layer.cornerRadius = 5.f;
    scrollerView.frame =  viewRect;
    scrollerView.clipsToBounds = YES;
    [self.view addSubview:scrollerView];
    [scrollerView setPageControlHidden:NO];
    
    currY = currY+scrollerView.frame.size.height;
    StyledPageControl *pageControl = [scrollerView getPageControl];
    pageControl.diameter = 5.0;
    pageControl.strokeWidth = 2.f;
    
    CGRect rect = pageControl.frame;
    //[self.scrollViewPreview setPageControlFrame:CGRectMake(0.f,rect.size.height-80.f,kDeviceScreenWidth, 40.f)];
    pageControl.frame = CGRectOffset(rect, 0.f, -40.f+38-5);
    
    [scrollerView bringSubviewToFront:pageControl];
    /*
    dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.f, 300.f,300)];
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    dataTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dataTableView];
    SafeRelease(dataTableView);
     */
#endif
    
}
- (void)flipViewFromLeftToRight:(BOOL)status{
    UIViewAnimationOptions viewAnimationOpt = UIViewAnimationOptionShowHideTransitionViews;
    
#if ScrollerView
    if(status){
        viewAnimationOpt|=UIViewAnimationOptionTransitionFlipFromLeft;
        [UIView transitionFromView:tweetieTableView   toView:oilAnalysisGraphView duration:0.5 options:viewAnimationOpt completion:^(BOOL isFinished){
            
        }];
    }
    else{
        viewAnimationOpt|=UIViewAnimationOptionTransitionFlipFromRight;
        [UIView transitionFromView:oilAnalysisGraphView toView:tweetieTableView duration:0.5 options:viewAnimationOpt completion:^(BOOL isFinished){
           
            
        }];
    }
#endif
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[dataAnaylsisView setNeedsDisplay];
}

- (void)swithDataViewType:(UIButton*)btn{
  
    switch (viewType) {
        case View_Graph:
            
            [self flipViewFromLeftToRight:NO];
            viewType = View_List;
            break;
        case View_List:
            [self flipViewFromLeftToRight:YES];
            viewType = View_Graph;
            break;
        default:
            break;
    }
}
-(void)didSelectorTopNavigationBarItem:(id)sender withButton:(UIButton*)btn{
    [self swithDataViewType:btn];
}
- (void)setButton:(UIButton*)btn withStatus:(BOOL)status{
      UIImage *bgImage = nil;
    if(status){
        UIImageWithFileName(bgImage, @"list_btn.png");
    }
    else{
        UIImageWithFileName(bgImage, @"graph_btn.png");
    }
    [btn setImage:bgImage forState:UIControlStateNormal];
}

#pragma mark -
-(UIView*)viewForItemAtIndex:(BSPreviewScrollView*)scrollView index:(int)index{
    UIImageWithFileName(UIImage *bgImage, @"car_plant_bg.png");
    UIView *maskView =[[UIView alloc]initWithFrame:CGRectMake(0.,0.f,kOilDataViewWidth, kOilDataViewHeight)];
    maskView.backgroundColor = [UIColor clearColor];
    // maskView.frame =
    //[maskView addSubview:maskView];
    if(index == 1){
        dataTableView= [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        dataTableView.dataSource = self;
        dataTableView.delegate = self;
        dataTableView.backgroundColor = [UIColor clearColor];
        dataTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        dataTableView.contentInset = UIEdgeInsetsMake(50.f,0.f,0.f,0.f);
        dataTableView.frame = CGRectMake(0.f,0.f,bgImage.size.width/kScale,bgImage.size.height/kScale);
        [maskView addSubview:dataTableView];
        [dataTableView reloadData];
        //[carDriveStatusView setTarget:self withAction:@selector(didTouchButton:)];
    }
    else{
        oilAnalysisGraphView = [[DriveOilAnalysisView alloc]initWithFrame:
                                CGRectMake(10.f,35.f,bgImage.size.width,bgImage.size.height)];
        oilAnalysisGraphView.backgroundColor = [UIColor clearColor];
        [maskView addSubview:oilAnalysisGraphView];
        [oilAnalysisGraphView updateUIByData:nil];
    }
    //SafeRelease(carDriveStatusView);
    return maskView;
}
-(int)itemCount:(BSPreviewScrollView*)scrollView{
    return  2;
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
   
    NSString *bgImageName = @"";
    if(indexPath.row == 0){
        
    }
    if(indexPath.row == 10){
        [cell setSeperateLineHidden:YES];
        bgImageName = @"oil_table_footer.png";
    }
    else{
        bgImageName = @"oil_table_cell.png";
        if(indexPath.row == 10){
           
        }
    }
    
    UIImageWithFileName(UIImage *bgImage,bgImageName);
    UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
    bgView.frame = CGRectMake(0.f, 0.f,300.f,42.f);
    
    //[cell insertSubview:bgView belowSubview:cell.contentView];
    //[cell.contentView  addSubview: bgView];
    cell.backgroundView = bgView;
    SafeRelease(bgView);
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
