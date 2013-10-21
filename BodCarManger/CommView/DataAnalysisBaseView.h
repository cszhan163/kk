//
//  DataAnalysisBaseView.h
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataAnalysisBaseView : UIView
/*
 * @praram data (percent data)
 * type 0: integer value,100(eg 50,50)
 * type 1: float value,1 (eg 0.5,0,5)
 */
- (void)setDisplayViewData:(NSArray*)data withType:(int)type;
- (void)setNeedsDisplay;
@end
