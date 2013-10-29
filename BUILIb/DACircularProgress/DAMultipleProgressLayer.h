//
//  DAMultipleProgressLayer.h
//  DACircularProgressExample
//
//  Created by cszhan on 13-9-21.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "DACircularProgressView.h"

@interface DAMultipleProgressLayer : UIView
{
    
    
}
@property(nonatomic) CGFloat thicknessRatio UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *trackTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;
/**
 @prama data NSDictionary;
 key:percent value:18%
 key:tinycolor value:[UIColor greenColor]
 **
 */
- (void)addMutiplePecentTrackData:(NSDictionary*)data;

- (void)addMutiplePecentTrackWithPercent:(int)percent withColor:(UIColor*)color;
- (void)addMutiplePecentTrackWithPercent:(int)percent withColor:(UIColor*)color withClocksize:(BOOL)tag;
@end
