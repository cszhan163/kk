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

@property(nonatomic,strong)UIColor *drawLineColor;
@property(nonatomic,strong)NSArray *drawLineColors;
- (void)setBackgroundImage:(UIImage*)image;
- (void)setXStep:(CGFloat)step;
- (void)setYStep:(CGFloat)step;
- (void)setOffsetY:(CGFloat)offsetY;
- (void)setOffsetX:(CGFloat)offsetX;
- (void)setMaxLenY:(CGFloat)len;
- (void)addDrawLineData:(NSArray*)data;
- (void)updateDrawLineData:(NSArray*)data;
@end
