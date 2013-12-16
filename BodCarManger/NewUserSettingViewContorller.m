//
//  NewUserSettingViewContorller.m
//  BodCarManger
//
//  Created by cszhan on 13-11-21.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "NewUserSettingViewContorller.h"

@implementation NewUserSettingViewContorller
- (void)dealloc{
    [super dealloc];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.readerDelegate = self;
    //for sestion one
    for(id item in [self.view subviews]){
        NSLog(@"%@",[item description]);
    }
    CGFloat height = 370.f;
    CGFloat pendingXWidth = 20.f;
    CGFloat topViewHeight = 50.f;
    
    //画中间的基准线
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(160,topViewHeight,1,height)];
    
    line.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:line];
    
    [line release];
    
    
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, topViewHeight)];
    
    upView.alpha = 0.3;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:upView];
    
    //用于说明的label
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(15,0, 290, 50);
    
    labIntroudction.numberOfLines=2;
    labIntroudction.font = [UIFont boldSystemFontOfSize:16];
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.text=@"请横向拍摄,使条形码图像置于方框内,摄像头尽可能靠近条形码,系统会自动识别.";
    
    [upView addSubview:labIntroudction];
    
    [labIntroudction release];
    
    [upView release];
    
    //左侧的view
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0,topViewHeight, pendingXWidth, height)];
    
    leftView.alpha = 0.3;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:leftView];
    
    [leftView release];
    
    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(300,topViewHeight,pendingXWidth, height)];
    
    rightView.alpha = 0.3;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:rightView];
    
    [rightView release];
    
    //底部view
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0,height+topViewHeight, 320,480-height-topViewHeight)];
    
    downView.alpha = 0.3;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:downView];
    
    [downView release];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.titleLabel.text = @"取消";
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateSelected];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(130.f, 430.f,60,40.f);
    //self.readerView.readerView.frame = CGRectMake(0.f,44.f,320, 300);
}
- (void)cancel:(id)sender{
    //self.scanner
    
    [ZCSNotficationMgr postMSG:kPopAllViewController obj:nil];
}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    
    NSLog(@"info=%@",info);
    // 得到条形码结果
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // 将获得到条形码显示到我们的界面上
    //resultText.text = symbol.data;
    
    // 扫描时的图片显示到我们的界面上
    /*
     resultImage.image =
     [info objectForKey: UIImagePickerControllerOriginalImage];
     */
    // 扫描界面退出
    //[reader dismissModalViewControllerAnimated: YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didGetScanResult:)]){
    
        [self.delegate didGetScanResult:symbol.data];
    }
    [self cancel:nil];
    
}
@end
