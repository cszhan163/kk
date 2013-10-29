//
//  EFRefreshTableFooterView.h
//  iPlat4M_iPad
//
//  Created by fuyiming on 12-2-29.
//  Copyright (c) 2012年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFRefreshTableFooterView : UIView
{

    UILabel * _countInfoLabel;
    UILabel * _footerNoticeLabel;
    BOOL footerLoading;
    UIActivityIndicatorView * _footerActivityView;

}

@property (nonatomic,assign) BOOL footerLoading;


-(void) setStatus:(BOOL) isLoading ;
-(void) setNoticeInfoCount:(int)count Total:(int)total;

@end
