//
//  AppDelegate.h
//  BodCarManger
//
//  Created by cszhan on 13-9-16.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
-(BOOL)checkCarInforData;
@property(nonatomic,strong)UIImage *sharedImage;
@property(nonatomic,assign)NSInteger mesCount;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
