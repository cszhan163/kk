//
//  CarDriveMannerDataGraphViewController.m
//  BUILIb
//
//  Created by cszhan on 13-11-5.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "CarDriveMannerDataGraphViewController.h"
#import "DriveActionAnalysisView.h"
@interface CarDriveMannerDataGraphViewController(){
    
    DriveActionAnalysisView *dataAnaylsisView;
}
@end


@implementation CarDriveMannerDataGraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[dataAnaylsisView setNeedsDisplay];
}
- (void)setNeedDisplaySubView{
    
    [dataAnaylsisView setNeedsDisplay];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    mainView.topBarView.hidden = YES;
    
	// Do any additional setup after loading the view.
    NSArray *colorArray = @[HexRGB(92, 200, 92),
      HexRGB(237, 209, 69),
      HexRGB(237, 54, 75),
      ];
    NSArray *tagImageArray = @[@"safe_green.png",@"safe_yellow.png",@"safe_red.png",];
    dataAnaylsisView = [[DriveActionAnalysisView alloc]initWithFrame:CGRectMake(0.f, kMBAppTopToolBarHeight+10.f, 320.f,300) withLineColorArray:colorArray withTagImageArray:tagImageArray];
    [self.view addSubview:dataAnaylsisView];
    dataAnaylsisView.backgroundColor = [UIColor clearColor];
    SafeRelease(dataAnaylsisView);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateUIData:(NSDictionary*)data{
    
    OilAnalysisData *oilData =  [[OilAnalysisData alloc]init];
    
    oilData.percentDataArray = [NSArray arrayWithObjects:
                                [data objectForKey:@"accRate"],
                                [data objectForKey:@"breakRate"],
                                [data objectForKey:@"overSpeedRate"],
                                nil];
    NSMutableArray *linesArray = [NSMutableArray array];
    for(int i = 0;i<3;i++){
        NSMutableArray * lineArray = [NSMutableArray array];
        [linesArray addObject:lineArray];
    }
    NSArray *economicData = [data objectForKey:@"safeData"];
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
        NSString *overSpead = [NSString stringWithFormat:@"%@",[item objectForKey:@"overSpeedCount"]];
        //[cell setTableCellCloumn:0 withData:date];
        [[linesArray objectAtIndex:0] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [item objectForKey:@"day"],@"x",
                                                 speedUp,@"y",nil]];
        
        [[linesArray objectAtIndex:1] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [item objectForKey:@"day"],@"x",
                                                 speedDown,@"y",nil]];
        
         [[linesArray objectAtIndex:2] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
         [item objectForKey:@"day"],@"x",
         overSpead,@"y",nil]];
        
    }
    oilData.linesDataArray = linesArray;
    //oilData.percentDataArray = @[@32,@28,@40];
    
    
    
    oilData.date = self.mCurrDate;
    oilData.indictorText = @"本月安全驾驶指数";
    oilData.textFormatArray = @[@"急加速: %d%@",@"急减速: %d\%@",@"    超速: %d\%@"];
    oilData.conclusionText = @"急减速较多，容易导致后车追尾";
    
    [dataAnaylsisView  updateUIByData:oilData];
    
}
@end
