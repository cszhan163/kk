//
//  CarInfoInputViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-6.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarInfoInputViewController.h"

@interface CarInfoInputViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavgationBarTitle:self.barTitle];
    
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

@end
