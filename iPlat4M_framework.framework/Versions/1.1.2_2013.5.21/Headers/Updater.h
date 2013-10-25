//
//  Updater.h
//  iPlat4M_iPad
//
//  Created by baosight on 11-10-26.
//  Copyright 2011 BaoSight. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "UpdaterProtocol.h"
@class Updater;

@protocol UpdaterProtocol

- (void)appUpdateChecker:(Updater*)checker didFailCheckWithError:(NSError*)error;

@end
@interface Updater : NSObject {
	id <UpdaterProtocol, UIAlertViewDelegate> delegate;
	NSString *plist_url;
	BOOL forceUpdate;
}

@property (nonatomic, retain) id <UpdaterProtocol> delegate;
- (void)checkUpdateWithURLString:(NSString*)url message:(NSString*)updateMsg forceUpdate:(BOOL)flag;

@end