//
//  UpdaterProtocol.h
//  iPlat4M_iPad
//
//  Created by baosight on 11-10-26.
//  Copyright 2011 BaoSight. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Updater.h"

@class Updater;
@protocol UpdaterProtocol

- (void)appUpdateChecker:(Updater*)checker didFailCheckWithError:(NSError*)error;

@end
