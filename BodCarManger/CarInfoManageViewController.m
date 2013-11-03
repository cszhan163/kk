//
//  CarInfoManageViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarInfoManageViewController.h"

static NSString *kCarInfoArray[] =
{
    @"车辆品牌",@"车牌型号",@"车牌号",
};
static NSString *kCarOtherInfoArray[] = {
    @"行驶总里程",@"上次保养里程",@"保养日期",@"保险到期日",
};

@interface CarInfoManageViewController ()

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
    [self setNavgationBarTitle:@"车量和设备信息"];
	// Do any additional setup after loading the view.
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
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelTextFieldCell];
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
    
    
    
    int index = [indexPath row];
    NSString *bgImageName = nil;
    switch (indexPath.section)
    {
        
        case 0:
            bgImageName = @"setting_cell_one.png";
            cell.textLabel.text = @"OBD设备号";
            break;
        case 1:{
            cell.textLabel.text = kCarInfoArray[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    bgImageName = @"setting_cell_header.png";
                    break;
                case 2:
                    bgImageName = @"setting_cell_footer.png";
                    break;
                    
                default:
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
                    break;
                case 3:
                    bgImageName = @"setting_cell_footer.png";
                    break;
                default:
                    bgImageName = @"setting_cell_middle.png";
                    break;
            }
        
        }
            
    }
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
@end
