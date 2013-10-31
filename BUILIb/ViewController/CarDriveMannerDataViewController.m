//
//  CarDriveMannerDataViewController.m
//  BUILIb
//
//  Created by cszhan on 13-10-31.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "CarDriveMannerDataViewController.h"
#import "CarServiceNetDataMgr.h"

#import "CarDriveOilTableViewCell.h"
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
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *date = [NSString stringWithFormat:@"%2d-%2d",[[item objectForKey:@"day"]intValue]];
    NSString *speedUp = [NSString stringWithFormat:@"%@",[item objectForKey:@"accCount"]];
    NSString *speedDown = [NSString stringWithFormat:@"%@",[item objectForKey:@"breakCount"]];
    [cell setTableCellCloumn:0 withData:date];
    [cell setTableCellCloumn:1 withData:speedUp];
    [cell setTableCellCloumn:2 withData:speedDown];
    return cell;
}

#pragma mark -
#pragma mark
- (void)loadAnalaysisData{
    
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    kNetStartShow(@"数据加载...", self.view);
    NSString *month = [NSString stringWithFormat:@"%d",mCurrDate.month];
    NSString *year = [NSString stringWithFormat:@"%d",mCurrDate.year];
    self.request = [cardShopMgr  getDriveActionAnalysisDataByCarId:@"SHD05728" withMoth:month withYear:year];
    
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request ==respRequest && [resKey isEqualToString:kResDriveActionAnalysis])
    {
        self.data = data;
        self.dataArray = [data objectForKey:@"safeData"];
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO ];
        //[mDataDict setObject:netData forKey:mMothDateKey];
        //}
        kNetEnd(self.view);
        
    }
    
}
- (void)updateUIData:(NSDictionary*)data{
    
    [dataTableView reloadData];
}
@end
