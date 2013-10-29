//
//  EFCheckBox.h
//  iPlat4M
//
//  Created by Fu Yiming on 11-11-15.
//  Copyright 2011年 baosight. All rights reserved.
//

#import "EFFoundation.h"
@class EFComboBoxTable;

@interface EFComboBox :UIButton<IDataContext,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{

}

@property (nonatomic,retain) EFControlCore * core;

@property (nonatomic,retain) NSString * eName;
@property (nonatomic,assign) id eValue;
@property (nonatomic,retain) NSString * eLabel;
@property (nonatomic,retain) NSString * eBindName;
@property (nonatomic,retain) NSString * eBlockName;
@property (nonatomic,retain) NSString * eValuePath;

@property (nonatomic,retain) UIPopoverController * popover;
@property (nonatomic,retain) EFComboBoxTable * comboBoxtable;
@property (nonatomic,assign) id  delegate;
@property (nonatomic,assign) SEL onDidSelected;

@property (nonatomic,retain) UIAlertView *pickerAlert;
@property (nonatomic,retain) UIPickerView *comboBoxPicker;
@end
@interface EFComboBox(private)
- (void) initDefaultStatus;
- (UIView *)labelCellWithWidth:(CGFloat)width ;
@end
