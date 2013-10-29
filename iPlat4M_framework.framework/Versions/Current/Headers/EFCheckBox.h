//
//  EFCheckBox.h
//  iPlat4M
//
//  Created by Fu Yiming on 11-11-15.
//  Copyright 2011年 baosight. All rights reserved.
//


#import "EFFoundation.h"

@interface EFCheckBox :UIButton<IDataContext>
{
    
}

@property (nonatomic,retain) EFControlCore * core;

@property (nonatomic,retain) NSString * eName;
@property (nonatomic,assign) id eValue;
@property (nonatomic,retain) NSString * eLabel;
@property (nonatomic,retain) NSString * eBindName;
@property (nonatomic,assign) id eCheckedValue;
@property (nonatomic,assign) id eUnCheckedValue;


@end
@interface EFCheckBox(private)
- (void) initDefaultStatus;
- (void) setTrueStatus;
- (void) setFalseStatus;
@end
