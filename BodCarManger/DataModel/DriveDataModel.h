//
//  DriveDataModel.h
//  BodCarManger
//
//  Created by cszhan on 13-10-29.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriveDataModel : NSObject

@end

@interface OilAnalysisData:NSObject
@property(nonatomic,strong)NSMutableArray *percentDataArray;
@property(nonatomic,strong)NSMutableArray *linesDataArray;
@property(nonatomic,strong)NSString *conclusionText;
@property(nonatomic,assign)DateStruct date;
@end
