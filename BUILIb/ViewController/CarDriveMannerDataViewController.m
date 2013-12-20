//
//  CarDriveMannerDataViewController.m
//  BUILIb
//
//  Created by cszhan on 13-10-31.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "CarDriveMannerDataViewController.h"
#import "CarServiceNetDataMgr.h"
#import "CarDriveActionTableViewCell.h"
#import "CarDriveOilTableViewCell.h"

static NSString *kActionTableHeaderTextArray[] = {@"日期",@"超速",@"急加速",@"急减速"};


@interface CarDriveMannerDataViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation CarDriveMannerDataViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    CarDriveOilTableViewCell *cell = [[CarDriveOilTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headercell"];
    cell.backgroundView = tableHeaderView;
    //SafeAutoRelease(cell);
    [cell setTableCellCloumn:0 withData:kActionTableHeaderTextArray[0]];
    [cell setTableCellCloumn:1 withData:kActionTableHeaderTextArray[1]];
    [cell setTableCellCloumn:2 withData:kActionTableHeaderTextArray[2]];
    [cell setTableCellCloumn:3 withData:kActionTableHeaderTextArray[3]];
    return SafeAutoRelease(cell);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"CarDriveActionTableViewCell";
    
    CarDriveActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"CarDriveOilTableViewCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[CarDriveOilTableViewCell class]])
                cell = (CarDriveOilTableViewCell*)oneObject;
        [cell setClounmLineColor:[UIColor greenColor]];
#else
        cell = [[CarDriveActionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        SafeAutoRelease(cell);
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSString *bgImageName = @"";
   
    if(indexPath.row == [self.dataArray count]){
        //[cell setSeperateLineHidden:YES];
        bgImageName = @"oil_table_footer.png";
    }
    else{
        bgImageName = @"oil_table_cell.png";
       
    }
    
    UIImageWithFileName(UIImage *bgImage,bgImageName);
    UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
    bgView.frame = CGRectMake(0.f, 0.f,300.f,42.f);
    
    //[cell insertSubview:bgView belowSubview:cell.contentView];
    //[cell.contentView  addSubview: bgView];
    cell.backgroundView = bgView;
    SafeRelease(bgView);
    
#if !Header
    if(indexPath.row == 0){
        
        [cell setTableCellCloumn:0 withData:kOilTableHeaderTextArray[0]];
        [cell setTableCellCloumn:1 withData:kOilTableHeaderTextArray[1]];
        [cell setTableCellCloumn:2 withData:kOilTableHeaderTextArray[2]];
        [cell setTableCellCloumn:3 withData:kOilTableHeaderTextArray[3]];
        return cell;
    }
#endif
    int realIndex = indexPath.row;
#if !Header
    realIndex = realIndex -1;
#else
    
#endif
    
    NSDictionary *item = [self.dataArray objectAtIndex:realIndex];
    NSString *date = [NSString stringWithFormat:@"%02d-%02d",self.mCurrDate.month,[[item objectForKey:@"day"]intValue]];
    NSString *speedUp = [NSString stringWithFormat:@"%@",[item objectForKey:@"accCount"]];
    NSString *speedDown = [NSString stringWithFormat:@"%@",[item objectForKey:@"breakCount"]];
    NSString *overSpeed = [NSString stringWithFormat:@"%@",[item objectForKey:@"overSpeedCount"]];
    [cell setTableCellCloumn:0 withData:date];
    [cell setTableCellCloumn:2 withData:speedUp];
    [cell setTableCellCloumn:3 withData:speedDown];
    [cell setTableCellCloumn:1 withData:overSpeed];
    return cell;
}
- (void)updateUIData:(NSDictionary*)data{
    
    self.dataArray   = [data objectForKey:@"safeData"];
    [dataTableView reloadData];
}
@end
