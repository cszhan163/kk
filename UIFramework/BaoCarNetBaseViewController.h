//
//  CardShopNetBaseViewController.h
//  CardShop
//
//  Created by cszhan on 12-9-15.
//  Copyright (c) 2012年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarServiceNetDataMgr.h"

#import "NTESMBLocalImageStorage.h"
#import "MemoPhotoDownloader.h"
@interface CardShopNetBaseViewController : UIViewController
@property(nonatomic,assign)id request;
@property(nonatomic,retain)NSMutableDictionary *allIconDownloaders;
@end
