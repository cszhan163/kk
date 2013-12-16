//
//  CarDriveAnalysisView.h
//  BodCarManger
//
//  Created by cszhan on 13-10-27.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TouchEventDelegate<NSObject>;
- (void)didTouchEvent:(id)sender;
@end
@interface CarMaintainanceView : UIView
@property(nonatomic,assign)id<TouchEventDelegate> delegate;
- (id)getCircleViewController;
- (void)setCenterImageView:(UIImage*)image;
- (void)setLeftProcessLen:(CGFloat)llen rightLen:(CGFloat)right;
- (void)setLeftProcessDay:(CGFloat)lLen rightDistance:(CGFloat)rLen;
@end
