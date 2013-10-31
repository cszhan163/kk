//
//  CarDriveOilDataGraphViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-10-26.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveOilDataAnalaysisViewController.h"
#import "DriveActionAnalysisView.h"

#import "DriveOilAnalysisView.h"

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
//    UIImage *bgImage = nil;
//    //tweetieTableView.hidden = YES;
//    //mainView.backgroundColor = [UIColor clearColor];
//    //tweetieTableView.frame = CGRectMake(0.f,0.f,300.f,380.f);
//    UIImageWithFileName(bgImage, @"car_plant_bg.png");
//    DriveOilAnalysisView *oilAnalysisView = [[DriveOilAnalysisView alloc]initWithFrame:
//                                             CGRectMake(10.f,0.f,bgImage.size.width,bgImage.size.height)];
//    [self.view addSubview:oilAnalysisView];
//    oilAnalysisView.backgroundColor = [UIColor redColor];
//    [oilAnalysisView updateUIByData:nil];
//    return;
    dataAnaylsisView = [[DriveActionAnalysisView alloc]initWithFrame:CGRectMake(0.f,35-10.f, 320.f,300)];
    dataAnaylsisView.backgroundColor = [UIColor clearColor];
    
    OilAnalysisData *data =  [[OilAnalysisData alloc]init];
    data.percentDataArray = @[@32,@28,@40];
    DateStruct date;
    date.month = 11;
    data.date = date;
    data.conclusionText = @"起挺次数较多会影响油耗";
    
    [dataAnaylsisView  updateUIByData:data];
    //self.view.backgroundColor = [UIColor whiteColor];
    //dataAnaylsisView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dataAnaylsisView];
    //dataAnaylsisView.backgroundColor = [UIColor blueColor];
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
