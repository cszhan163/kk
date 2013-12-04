//
//  AboutViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-12-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "AboutViewController.h"

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
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
