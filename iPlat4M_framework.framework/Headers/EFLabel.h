//
//  EFLabel.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-23.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFFoundation.h"


@interface EFLabel : UILabel <IDataContext>
{
}

@property (nonatomic,retain) EFControlCore * core;
@property (nonatomic,assign) NSString * eName;
@property (nonatomic,assign) id eValue;
@property (nonatomic,assign) NSString * eLabel;
@property (nonatomic,assign) NSString * eBindName;

@end

@interface EFLabel(private)
- (void) initDefaultStatus;
@end