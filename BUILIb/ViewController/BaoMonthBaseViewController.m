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
        self.isNeedInitDateMonth = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.isNeedInitDateMonth)
        [self initDateMonth];
	// Do any additional setup after loading the view.
}

- (void)initDateMonth{

    NSDate *currDate  = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    //dateFormat.dateStyle = NSDateFormatterShortStyle;
    NSString *currDateStr = [dateFormat stringFromDate:currDate];
    NSArray *dateArray = [currDateStr componentsSeparatedByString:@"-"];
    DateStruct date;
    
    date.month = [dateArray[1]intValue];
    date.year = [dateArray[0]intValue];
    date.day = [dateArray[2]intValue];
    self.mCurrDate = date;
    SafeRelease(dateFormat);
    self.mTodayDate = date;
    
    self.mMothDateKey = [NSString stringWithFormat:kDateFormart,self.mCurrDate.year,self.mCurrDate.month];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)checkDataChange{
    
    if(![[[UIApplication sharedApplication] delegate] checkCarInforData]){
        return;
    }
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
    isNeedReflush = YES;
    mCurrDate.year = [[day objectForKey:@"year"]intValue];
    mCurrDate.month = [[day objectForKey:@"month"]intValue];
    self.mMothDateKey = [NSString stringWithFormat:kDateFormart,mCurrDate.year,mCurrDate.month];
    
    [self checkDataChange];
}
- (void)didTouchAfterMoth:(NSDictionary *)day{
    
    isNeedReflush = YES;
    mCurrDate.year = [[day objectForKey:@"year"]intValue];
    mCurrDate.month = [[day objectForKey:@"month"]intValue];
    self.mMothDateKey = [NSString stringWithFormat:kDateFormart,mCurrDate.year,mCurrDate.month];
    [self checkDataChange];
    
    
}
- (void)updateUIData:(NSDictionary*)netData{

}
- (void)checkAdjustDate:(int)offset withMonth:(int*)month withYear:(int*)year{
    
    *month = self.mTodayDate.month +offset;
    *year = self.mTodayDate.year;
    if(*month>12){
        //for first year;
        int adjust = 12-self.mTodayDate.month;
        int num = (*month-adjust)/12;
        *year = self.mTodayDate.year+num;
        *month = *month%12;
        if(*month == 0){
            *month = 12;
        }
    }
    if(*month<=0){
        int num = -1+*month/12;
        *year = self.mTodayDate.year+num;
        *month = 12+*month%12;
    }
    
    return;
}
@end
