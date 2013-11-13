//
//  CarInfoInputViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-6.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarInfoInputViewController.h"

@interface CarInfoInputViewController (){

}
@property(nonatomic,strong)NSString *srcText;
@end

@implementation CarInfoInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{

    [self removeObserver:self.subClassInputTextField forKeyPath:@"text"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavgationBarTitle:self.barTitle];
    [self setHiddenRightBtn:NO];
    self.srcText = self.subClassInputTextField.text;
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, kMBAppTopToolBarHeight,kDeviceScreenWidth, kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    
    [self.view insertSubview:bgView belowSubview:self.subClassInputTextField];
    SafeRelease(bgView);
    
    
    UIImageWithFileName(bgImage, @"item_default_btn.png");
    assert(bgImage);
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
    UIImageWithFileName(bgImage, @"item_change_btn.png");
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateSelected];
    self.rightBtn.frame = CGRectMake(kDeviceScreenWidth-10-bgImage.size.width/kScale, self.rightBtn.frame.origin.y, bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self addObserver:self.subClassInputTextField forKeyPath:@"text"  options:NSKeyValueObservingOptionNew context:NULL];
    
    [super setNavgationBarRightBtnText:@"确定" forStatus:UIControlStateNormal];
    //self.rightBtn.titleLabel.textColor = [UIColor whiteColor];
    if(self.type == 0)
    {
        //[self setNavgationBarTitle:NSLocalizedString(@"获取验证码", @"")];
    }
    else
    {
        datePickView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0.f,kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-100.f,320.f, 100.f)];
        datePickView.datePickerMode = UIDatePickerModeDate;
        [self.view addSubview:datePickView];
        datePickView.hidden = NO;
        self.subClassInputTextField.enabled = NO;
        [self.subClassInputTextField resignFirstResponder];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyyMMdd"];
        
        NSDate *date = [dateFormat dateFromString:self.subClassInputTextField.text];
        datePickView.hidden = NO;
        [datePickView setDate:date animated:YES];
        
        [datePickView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        SafeRelease(datePickView);
        SafeRelease(dateFormat);
        //[self setNavgationBarTitle:NSLocalizedString(@"找回密码", @"")];
    }
	// Do any additional setup after loading the view.
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isEqualToString:self.srcText]){
        self.rightBtn.selected = NO;
    }
    else{
        self.rightBtn.selected = YES;
    }
}
- (void)dateChange:(UIDatePicker*)sender{
    NSDateComponents *dateComonets = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit  fromDate:sender.date];
    //[dateComonets ]
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
    NSString *dateString = [dateFormat stringFromDate:sender.date];
    //NSDate *date = [dateFormat dateFromString:self.subClassInputTextField.text];
    self.subClassInputTextField.text = dateString;
    SafeRelease(dateFormat);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didSelectorTopNavItem:(id)navObj
{
	NE_LOG(@"select item:%d",[navObj tag]);
    
	switch ([navObj tag])
	{
		case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];// animated:
        }
			break;
		case 1:
		{
            //[self startRestPassword];
            if(delegate && [delegate respondsToSelector:@selector(setCellItemData:withIndexPath:)]){
                [delegate setCellItemData:self.subClassInputTextField.text withIndexPath:self.indexPath];
            }
            [self.navigationController popViewControllerAnimated:YES];
			break;
		}
	}
    
}

@end
