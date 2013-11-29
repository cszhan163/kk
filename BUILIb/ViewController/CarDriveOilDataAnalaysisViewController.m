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

#define  kOilMothFormart    @"%02d月起停油耗分析表"


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
    
      mainView.topBarView.hidden = YES;
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
    dataAnaylsisView = [[DriveActionAnalysisView alloc]initWithFrame:CGRectMake(0.f,kMBAppTopToolBarHeight+10.f, 320.f,300)];
    dataAnaylsisView.backgroundColor = [UIColor clearColor];
    
    
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
- (void)updateUIData:(NSDictionary*)data{

    OilAnalysisData *oilData =  [[OilAnalysisData alloc]init];
    
    oilData.percentDataArray = [NSArray arrayWithObjects:
                                [data objectForKey:@"breakRate"],
                                [data objectForKey:@"accRate"],
                                [data objectForKey:@"highRPMRate"],
                                nil];
    NSMutableArray *linesArray = [NSMutableArray array];
    for(int i = 0;i<3;i++){
        NSMutableArray * lineArray = [NSMutableArray array];
        [linesArray addObject:lineArray];
    }
    NSArray *economicData = [data objectForKey:@"economicData"];
    economicData = [economicData sortedArrayUsingComparator:^(id param1,id param2){
        
        id arg1 = [param1 objectForKey:@"day"];
        id arg2 = [param2 objectForKey:@"day"];
        if([arg1 intValue]>[arg2 intValue]){
            return NSOrderedDescending;
        }
        else if([arg1 intValue]<[arg1 intValue]){
            return NSOrderedAscending;
        }
        else{
            return NSOrderedSame;
        }
    
    }];
    for(NSDictionary *item in economicData){
        
        NSString *speedUp = [NSString stringWithFormat:@"%@",[item objectForKey:@"accCount"]];
        NSString *speedDown = [NSString stringWithFormat:@"%@",[item objectForKey:@"breakCount"]];
        NSString *overSpeadCoutn = [NSString stringWithFormat:@"%@",[item objectForKey:@"highRPMCount"]];
        //[cell setTableCellCloumn:0 withData:date];
        [[linesArray objectAtIndex:0] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [item objectForKey:@"day"],@"x",
                                                 speedDown,@"y",nil]];
        
        [[linesArray objectAtIndex:1] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [item objectForKey:@"day"],@"x",
                                                 speedUp,@"y",nil]];
        
        [[linesArray objectAtIndex:2] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [item objectForKey:@"day"],@"x",
                                                 overSpeadCoutn,@"y",nil]];
        
        
    }
    oilData.linesDataArray = linesArray;
    //oilData.percentDataArray = @[@32,@28,@40];
    
    
    NSString *showText = [NSString stringWithFormat:kOilMothFormart,self.mCurrDate.month];
    oilData.date = self.mCurrDate;
    oilData.indictorText = showText;
    oilData.textFormatArray = @[@"低速行驶时间: %d%@",@"经济行驶时间: %d\%@",@"高速行驶时间: %d\%@"];
    oilData.conclusionText = @"起挺次数较多会影响油耗";
    
    [dataAnaylsisView  updateUIByData:oilData];

}
@end
