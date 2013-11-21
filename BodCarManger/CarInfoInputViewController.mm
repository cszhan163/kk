//
//  CarInfoInputViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-6.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarInfoInputViewController.h"
#import "ZXingWidgetController.h"
#import <QRCodeReader.h>
#include <iostream>
@interface CarInfoInputViewController ()<ZXingDelegate>{

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

    //[self.subClassInputTextField removeObserver:self forKeyPath:@"text"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavgationBarTitle:self.barTitle];
    [self setHiddenRightBtn:NO];
    self.srcText = self.subClassInputTextField.text;
    
    UIImage *bgImage;
    
    //[self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    UIImageWithFileName(bgImage, @"item_default_btn.png");
    assert(bgImage);
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateNormal];
    UIImageWithFileName(bgImage, @"item_change_btn.png");
    [super setNavgationBarRightBtnImage:bgImage forStatus:UIControlStateSelected];
   
    //self.rightBtn.titleLabel
    /*
    self.rightBtn = [UIComUtil createButtonWithNormalBGImageName:@"item_default_btn.png" withHightBGImageName:@"item_change_btn.png" withTitle:@"确定" withTag:0];
     */
    self.rightBtn.frame = CGRectMake(kDeviceScreenWidth-10-bgImage.size.width/kScale, self.rightBtn.frame.origin.y, bgImage.size.width/kScale, bgImage.size.height/kScale);
    self.subClassInputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.subClassInputTextField  addTarget:self action:@selector(didchangeInputText:) forControlEvents:UIControlEventEditingChanged];
    //self.rightBtn.titleLabel.text = @"确定";
    self.rightBtn.font = [UIFont systemFontOfSize:13];
    [self setNavgationBarRightBtnText:@"确定"forStatus:UIControlStateNormal];
    [self setNavgationBarRightBtnText:@"确定" forStatus:UIControlStateSelected];
//    [self.rightBtn setNeedsDisplay];
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
        [dateFormat setDateFormat:@"yyyy年MM月dd日"];
        
        NSDate *date = [dateFormat dateFromString:self.subClassInputTextField.text];
        datePickView.hidden = NO;
        [datePickView setDate:date animated:YES];
        
        [datePickView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        SafeRelease(datePickView);
        SafeRelease(dateFormat);
        //[self setNavgationBarTitle:NSLocalizedString(@"找回密码", @"")];
    }
    if(_isShowQR){
        UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:@"qr_btn.png" withHightBGImageName:@"qr_btn.png" withTitle:@"二维码扫瞄" withTag:0];
        
        [btn addTarget:self action:@selector(qrScanAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(60.f, 120.f,btn.frame.size.width, btn.frame.size.height);
        [self.view addSubview:btn];
    }
	// Do any additional setup after loading the view.
}
- (void)didchangeInputText:(UITextField*)textField{
    if([textField.text isEqualToString:self.srcText]){
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
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *dateString = [dateFormat stringFromDate:sender.date];
    //NSDate *date = [dateFormat dateFromString:self.subClassInputTextField.text];
    self.subClassInputTextField.text = dateString;
    SafeRelease(dateFormat);
    //SafeRelease(dateComonets);
    if([self.subClassInputTextField.text isEqualToString:self.srcText]){
        self.rightBtn.selected = NO;
    }
    else{
       self.rightBtn.selected = YES; 
    }
    
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
- (void)qrScanAction:(id)sender{

    return;
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    [self presentViewController:widController animated:YES completion:^{}];
}
@end
