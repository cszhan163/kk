//
//  EFControlCore.h
//  iPlat4M_iPad
//
//  Created by Fei Ye on 11-12-19.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//
#import "Config.h"
#import <Foundation/Foundation.h>
#import "EiInfo.h"
#import <UIKit/UIKit.h>
@interface EFControlCore : NSObject
{
    
    UIView * control;
    
}
@property (nonatomic,retain) NSString * description;
@property (nonatomic,retain) NSString * eName;
@property (nonatomic,retain) id eValue;
@property (nonatomic,retain) NSString * eLabel;
@property (nonatomic,retain) NSString * eBindName;

- (void) updateFromData:(EiInfo *)eiinfo;
- (void) updateToData:(EiInfo *)eiinfo;
- (void) updateFromRow:(NSDictionary *)row;
- (void) updateToRow:(NSDictionary *)row;
- (NSDictionary *) getSuperFormRow;

- (EiInfo *) getEiInfo;
-(id) initWithObject:(UIView *)obj;

@end

@interface  EFControlCore (private)

    
@end
