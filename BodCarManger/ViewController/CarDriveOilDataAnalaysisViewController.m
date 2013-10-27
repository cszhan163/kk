//
//  CarDriveOilDataGraphViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-10-26.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveOilDataAnalaysisViewController.h"
#import "DriveActionAnalysisView.h"


@interface CarDriveOilDataAnalaysisViewController(){
    DriveActionAnalysisView *dataAnaylsisView;
   
}
@end

@implementation CarDriveOilDataAnalaysisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    dataAnaylsisView = [[DriveActionAnalysisView alloc]initWithFrame:CGRectMake(0.f, 35+.f, 320.f,300)];
    [self.view addSubview:dataAnaylsisView];
    SafeRelease(dataAnaylsisView);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[dataAnaylsisView setNeedsDisplay];
}
- (void)setNeedDisplaySubView{
    [dataAnaylsisView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
