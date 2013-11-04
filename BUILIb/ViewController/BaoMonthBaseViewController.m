//
//  BaoMonthBaseViewController.m
//  BUILIb
//
//  Created by cszhan on 13-10-31.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "BaoMonthBaseViewController.h"

@interface BaoMonthBaseViewController ()

@end

@implementation BaoMonthBaseViewController
@synthesize mCurrDate;
@synthesize mDataDict;
@synthesize mMothDateKey;
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
    NSDate *currDate  = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM"];
    //dateFormat.dateStyle = NSDateFormatterShortStyle;
    NSString *currDateStr = [dateFormat stringFromDate:currDate];
    NSArray *dateArray = [currDateStr componentsSeparatedByString:@"-"];
    DateStruct date;
    
    date.month = [dateArray[1]intValue];
    date.year = [dateArray[0]intValue];

    self.mCurrDate = date;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)checkDataChange{
    
#if 0
    NSArray * dataArray = [NSArray arrayWithObject:
                           [NSDictionary dictionary]]
    mDataDict = [NSDictionary dictionaryWithObjectsAndKeys:
                 
                 , nil];
#endif
    NSMutableArray *data = [mDataDict objectForKey:mMothDateKey] ;
    if(data== nil){
        [self refulshNetData];
    }
    else{
        if(!isNeedReflush)
            return;
        [self updateUIData:data];
    }
    
}

- (void)didTouchPreMoth:(NSDictionary*)day{
    
    mCurrDate.year = [[day objectForKey:@"year"]intValue];
    mCurrDate.month = [[day objectForKey:@"month"]intValue];
    self.mMothDateKey = [NSString stringWithFormat:@"%d%02d",mCurrDate.year,mCurrDate.month];
    
    [self checkDataChange];
}
- (void)didTouchAfterMoth:(NSDictionary *)day{
    
    isNeedReflush = YES;
    mCurrDate.year = [[day objectForKey:@"year"]intValue];
    mCurrDate.month = [[day objectForKey:@"month"]intValue];
    self.mMothDateKey = [NSString stringWithFormat:@"%d%02d",mCurrDate.year,mCurrDate.month];
    [self checkDataChange];
    
    
}
- (void)updateUIData:(NSDictionary*)netData{

}
@end
