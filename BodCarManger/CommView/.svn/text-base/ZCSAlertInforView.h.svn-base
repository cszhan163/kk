//
//  ZCSAlertInforView.h
//  DressMemo
//
//  Created by  on 12-7-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCSAlertInforViewDelegate <NSObject>
@optional
-(void)didAutoDissMiss:(id)sender;

@end
@interface ZCSAlertInforView : UIView
@property(nonatomic,assign)id<ZCSAlertInforViewDelegate> delegate;
@property(nonatomic,assign)BOOL isHiddenAuto;
@property(nonatomic,assign)BOOL isTouchHidden;
@property(nonatomic,assign)BOOL isTextCenter;
@property(nonatomic,retain)NSString *text;
@property(nonatomic,assign)NSTimeInterval hiddenAfterTimerDuration;
-(void)setTextFont:(UIFont*)font;
-(id)initWithFrame:(CGRect)frame withText:(NSString*)text isWindow:(BOOL)isWindow;
-(id)initWithFrame:(CGRect)frame withText:(NSString *)text withImages:(NSArray*)imageArr;
- (void)setBGContent:(UIImage*)image;
- (void)dissMiss;
- (void)hiddenAfterDelay:(NSTimeInterval)duration;
- (void)hiddenUpAnimation:(NSTimeInterval)duration;
@end
