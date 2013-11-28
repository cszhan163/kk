//
//  DBManage.h
//  BUILIb
//
//  Created by cszhan on 13-11-5.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGetLocationNameMSG   @"getLocationMSG"

@protocol DBManageDelegate<NSObject>
- (void)didGetLocationData:(id)sender withIndex:(NSInteger)index;
- (void)didGetLocationData:(id)sender withIndex:(NSInteger)index withTag:(BOOL)tag;
@end
@interface DBManage : NSObject
@property(nonatomic,weak)id<DBManageDelegate> delegate;
+(id)getSingletone;
- (NSDictionary*)getLocationPointsData;
- (NSString*)getLocationPointNameByLatitude:(double)lat withLogtitude:(double)lng;
- (void)getLocationDataFromVendorWithLatitude:(double)lat withLotitude:(double)lng;
- (void)setLocationPointNameByLocationSet:(NSArray*)data;
- (void)setLocationPointNameByLatitude:(double)lat withLogtitude:(double)lng withData:(NSString*)name withIndex:(NSInteger)index withTag:(BOOL)tag;
- (NSString*)getLocationPointNameByLatitude:(double)lat withLogtitude:(double)lng withIndex:(NSInteger)index withTag:(BOOL)tag;
- (NSArray*)getMessageHistData:(NSString*)userId;
- (void)saveMessageHistData:(NSArray*)data withUserId:(NSString*)userId;
@end
