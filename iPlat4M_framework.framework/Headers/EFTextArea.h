//
//  EFTextView.h
//  iPlat4M_iPad
//
//  Created by baosight on 11-11-29.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFFoundation.h"
@interface EFTextArea : UITextView<IDataContext,UITextViewDelegate>

@property (nonatomic,retain) EFControlCore * core;
@property (nonatomic,assign) NSString * eName;
@property (nonatomic,assign) id eValue;
@property (nonatomic,assign) NSString * eLabel;
@property (nonatomic,assign) NSString * eBindName;

@end

@interface EFTextArea(private)
- (void) initDefaultStatus;
- (IBAction)pressAcceptButton:(id)sender;

@end
