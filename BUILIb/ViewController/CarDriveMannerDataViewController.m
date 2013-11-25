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

static NSString *kActionTableHeaderTextArray[] = {@"日期",@"急加速",@"急减速"};


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
        bgImageName = @"drive_habit_table_footer.png";
    }
    else{
        bgImageName = @"drive_habit_table_cell.png";
       
    }
    
    UIImageWithFileName(UIImage *bgImage,bgImageName);
    UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
    bgView.frame = CGRectMake(0.f, 0.f,300.f,42.f);
    
    //[cell insertSubview:bgView belowSubview:cell.contentView];
    //[cell.contentView  addSubview: bgView];
    cell.backgroundView = bgView;
    SafeRelease(bgView);
    
    if(indexPath.row == 0){
        
        [cell setTableCellCloumn:0 withData:kActionTableHeaderTextArray[0]];
        [cell setTableCellCloumn:1 withData:kActionTableHeaderTextArray[1]];
        [cell setTableCellCloumn:2 withData:kActionTableHeaderTextArray[2]];
        //[cell setTableCellCloumn:3 withData:kOilTableHeaderTextArray[3]];
        return cell;
        
    }
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row-1];
    NSString *date = [NSString stringWithFormat:@"%02d-%02d",self.mCurrDate.month,[[item objectForKey:@"day"]intValue]];
    NSString *speedUp = [NSString stringWithFormat:@"%@",[item objectForKey:@"accCount"]];
    NSString *speedDown = [NSString stringWithFormat:@"%@",[item objectForKey:@"breakCount"]];
    [cell setTableCellCloumn:0 withData:date];
    [cell setTableCellCloumn:1 withData:speedUp];
    [cell setTableCellCloumn:2 withData:speedDown];
    return cell;
}
- (void)updateUIData:(NSDictionary*)data{
    
    self.dataArray   = [data objectForKey:@"safeData"];
    [dataTableView reloadData];
}
@end
