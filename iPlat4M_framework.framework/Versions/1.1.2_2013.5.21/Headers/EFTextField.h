//
//  EFTextField.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-20.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFFoundation.h"


@interface EFTextField : UITextField <IDataContext,UITextFieldDelegate>

@property (nonatomic,retain) EFControlCore * core;
@property (nonatomic,assign) NSString * eName;
@property (nonatomic,assign) id eValue;
@property (nonatomic,assign) NSString * eLabel;
@property (nonatomic,assign) NSString * eBindName;

@end

@interface EFTextField(private)
- (void) initDefaultStatus;
- (IBAction)pressAcceptButton:(id)sender;

@end
