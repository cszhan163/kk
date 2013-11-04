//
//  UICustomActionAlertView.h
//  VoiceInput
//
//  Created by cszhan on 13-6-9.
//  Copyright (c) 2013年 DragonVoice. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UICustomActionAlertViewDelegate<NSObject>
@optional
- (void)didTouchView:(id)sender;
- (void)didTouchItem:(id)sender;
- (void)didTouchFunItem:(id)sender withItem:(id)sender;
@end
@interface UICustomActionAlertView : UIView
@property(nonatomic,assign)BOOL subStatus;
@property(nonatomic,assign)id<UICustomActionAlertViewDelegate> delegate;
//- (id)initMoreAlertActionView:(CGRect)frame;

- (id )initMoreAlertActionView:(CGRect)frame  subViewStatus:(BOOL)status;

- (void)disMissAlertView:(BOOL)animatied;
- (void)setAutoSendButton:(NSString*)text;
- (void)showAlertActionViewStatus:(BOOL)isShow animated:(BOOL)animation;
@end
