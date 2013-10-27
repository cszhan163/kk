//
//  ZCSDrawLineView.h
//  AMProgressView
//
//  Created by cszhan on 13-10-27.
//  Copyright (c) 2013年 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCSDrawLineView : UIView{

}
@property(nonatomic,strong)UIColor *backgroundColor;
@property(nonatomic,strong)UIColor *drawLineColor;
- (void)setXStep:(CGFloat)step;
- (void)setYStep:(CGFloat)step;
- (void)updateDrawLineData:(NSArray*)data;
@end
