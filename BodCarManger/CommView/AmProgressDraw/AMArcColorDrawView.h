//
//  AMColorDrawView.h
//  AMProgressView
//
//  Created by cszhan on 13-10-24.
//  Copyright (c) 2013年 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMArcColorDrawView : UIView
@property(nonatomic,assign)CGFloat radius;
-(void) gradientColorWithRed:(CGFloat)aRed green:(CGFloat)aGreen blue:(CGFloat)aBlue;
@end
