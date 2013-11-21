//
//  BaoMonthBaseViewController.h
//  BUILIb
//
//  Created by cszhan on 13-10-31.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "UISimpleNetBaseViewController.h"
#import "BSPreviewScrollView.h"
@interface BaoMonthBaseViewController : UISimpleNetBaseViewController{

     BOOL isNeedReflush;
    NSInteger pageIndex;
    //DateStruct mCurrDate;
    //DateStruct   mTodayDate
    int        currIndex;
    BOOL       isTodayMonth;
}
@property(nonatomic,strong)NSString *mMothDateKey;
@property(nonatomic,strong)NSMutableDictionary *mDataDict;
@property(nonatomic,assign)DateStruct mCurrDate;
@property(nonatomic,assign)DateStruct   mTodayDate;
@property(nonatomic,assign)BOOL isNeedInitDateMonth;
- (void)checkAdjustDate:(int)offset withMonth:(int*)month withYear:(int*)year;
- (void)didTouchPreMoth:(NSDictionary*)day;
- (void)didTouchAfterMoth:(NSDictionary *)day;
- (void)refulshNetData;
- (void)updateUIData:(NSDictionary*)netData;
@end
