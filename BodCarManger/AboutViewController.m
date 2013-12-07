//
//  AboutViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-12-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "AboutViewController.h"
#define kAppVersionFormart  @"宝逸行%@"
@interface AboutViewController ()

@end

@implementation AboutViewController

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
    
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, kMBAppTopToolBarHeight,kDeviceScreenWidth, kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
	// Do any additional setup after loading the view.
    [self setNavgationBarTitle:NSLocalizedString(@"关于", @""
                                                 )];
    [self setRightBtnHidden:YES];
    //[self setHiddenLeftBtn:YES];
    [self.view addSubview:bgView];
    SafeRelease(bgView);
    UIImageWithNibName(bgImage, @"icon@2x.png");
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    imageView.image =bgImage;
    imageView.frame = CGRectMake((320.f-bgImage.size.width/kScale)/2.f,kMBAppTopToolBarHeight+20.f,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view addSubview:imageView];
    SafeRelease(imageView);
    CGFloat currHeight = imageView.frame.origin.y+bgImage.size.height/kScale;
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f,currHeight+10.f, kDeviceScreenWidth, 20.f)];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.font = [UIFont systemFontOfSize:16];
    navTitleLabel.textColor = [UIColor blackColor];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString* strVersionPrompt = [NSString stringWithFormat:kAppVersionFormart,version];
    navTitleLabel.text = strVersionPrompt;
    currHeight = currHeight+navTitleLabel.frame.size.height+10.f;
    [self.view addSubview:navTitleLabel];
    SafeRelease(navTitleLabel);
    
    currHeight = currHeight+ 40.f;
    CGRect tableRect = logInfo.frame;
    logInfo.frame = CGRectMake(0.f, currHeight+30.f,tableRect.size.width , tableRect.size.height);
    
    
}
#pragma mark -
#pragma mark tableView dataSource
//- (NSInteger)tableView:(UITableView *)tableView section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2.f;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.section == 1 &&
    //        (indexPath.row == 1 || indexPath.row == 2)) {
    //        return [UIShareCell cellHeight];
    //    }
    
    return  42.f;
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
    switch (indexPath.row)
    {
            case 0:
            cell.textLabel.text = @"功能介绍";
            break;
            case 1:
            cell.textLabel.text = @"版本更新";
            break;
            
    }
    cell.detailTextLabel.text = dataText;
    UIImageWithNibName(UIImage *bgImage,bgImageName);
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
- (void)addFonterView{
    
    //    logInfo.frame = CGRectMake(0,kMBAppTopToolBarHeight-self.mainContentViewPendingY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60 );
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f,0.f,300.f,80)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    
    CGFloat currY = kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60+10.f;
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:nil  withHightBGImageName:nil  withTitle:@"使用条框和隐私政策" withTag:0];
    
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    currY = 10.f;
    oilAnalaysisBtn.frame = CGRectMake(10.f,currY,160,30);
    [oilAnalaysisBtn addTarget:self action:@selector(logOutConfirm:) forControlEvents:UIControlEventTouchUpInside];
    //[logInfo addSubview:oilAnalaysisBtn];
    //
    [bgView addSubview:oilAnalaysisBtn];
    [logInfo setTableFooterView:bgView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
