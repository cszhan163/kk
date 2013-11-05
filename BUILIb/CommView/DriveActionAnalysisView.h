//
//  DriveActionAnalysisView.h
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAnalysisBaseView.h"
#import "DriveDataModel.h"
@interface DriveActionAnalysisView : DataAnalysisBaseView{
    
    NSArray *colorArray;
}
- (id)initWithFrame:(CGRect)frame  withLineColorArray:(NSArray*)colorArray withTagImageArray:(NSArray*)tagImageArray;
@property(nonatomic,strong)NSArray *tagImageArray;
@property(nonatomic,strong)NSArray *colorArray;
@property(nonatomic,strong)OilAnalysisData *oilData;
@end
