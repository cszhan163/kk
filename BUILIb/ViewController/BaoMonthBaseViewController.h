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
    DateStruct mCurrDate;
    BSPreviewScrollView *scrollerView;
}
@property(nonatomic,strong)NSString *mMothDateKey;
@property(nonatomic,strong)NSMutableDictionary *mDataDict;
@property(nonatomic,assign)DateStruct mCurrDate;
- (void)didTouchPreMoth:(NSDictionary*)day;
- (void)didTouchAfterMoth:(NSDictionary *)day;
- (void)refulshNetData;
- (void)updateUIData:(NSDictionary*)netData;
@end
