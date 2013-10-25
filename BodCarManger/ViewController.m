//
//  ViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-16.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "ViewController.h"
#import "CarServiceNetDataMgr.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *imgPath = nil;
    UIImage *defaultStatusImg,*selectStatusImg;
    CGRect itemRect = CGRectMake(0.f,100.f,64.f,50.f);
    NSDictionary *param = nil;
    CarServiceNetDataMgr *cardNetMgr = [CarServiceNetDataMgr getSingleTone];
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"2013",@"year",
             @"10",@"month",
             nil];
    [cardNetMgr getDetailByMonth:param];
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"2013",@"year",
             @"10",@"month",
             nil];
    [cardNetMgr getDetailByDay:param];
    [cardNetMgr getCarRealTimeStatus:@""];
    [cardNetMgr getDriveDataByMoth:@"" withYear:@""];
    [cardNetMgr getDriveDataByMoth:@"10" withYear:@"2013"];
    
    [cardNetMgr getMessageList:nil];
    for(int i = 0; i<1;i++)
	{
		UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
		/*
		 imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"mainpagebtn%d",i] ofType:@"png"];
		 bgImag =  [UIImage imageWithContentsOfFile:imgPath];
		 */
		imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:kTabItemNarmalImageFileNameFormart,i] ofType:kTabItemImageSubfix];
		assert(imgPath);
		defaultStatusImg =  [UIImage imageWithContentsOfFile:imgPath];
        defaultStatusImg =  [UIImage_Extend imageWithColor:[UIColor clearColor] withImage:defaultStatusImg withSize:itemRect.size];
		imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:kTabItemSelectImageFileNameFormart,i] ofType:kTabItemImageSubfix];
		assert(imgPath);
		selectStatusImg =  [UIImage imageWithContentsOfFile:imgPath];
        
        selectStatusImg = [UIImage_Extend imageWithColor:[UIColor clearColor] withImage:selectStatusImg withSize:itemRect.size];
        
		//[btn setBackgroundImage:bgImag forState:UIControlStateNormal];
		[btn setImage:defaultStatusImg forState:UIControlStateNormal];
		[btn setImage:selectStatusImg forState:UIControlStateSelected];
		//[btn setBackgroundImage:statusImg forState:UIControlStateNormal];
		//btn.frame = CGRectMake(0.f,0.f,defaultStatusImg.size.width/kScale, defaultStatusImg.size.height/kScale);
		//[mainView.mainFramView addSubview:btn];
        
        btn.frame = itemRect;
        btn.selected = YES;
        [self.view addSubview:btn];
        
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
