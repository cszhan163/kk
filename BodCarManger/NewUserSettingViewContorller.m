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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.titleLabel.text = @"取消";
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(130.f, 400.f,60,40.f);
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
