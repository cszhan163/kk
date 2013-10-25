//
//  EFCheckBox.h
//  iPlat4M
//
//  Created by Fu Yiming on 11-11-15.
//  Copyright 2011年 baosight. All rights reserved.
//


#import "EFFoundation.h"

@interface EFDatePicker :UIButton<IDataContext,UIAlertViewDelegate>
{
    NSString * eDateFormat;
    UIDatePickerMode  eDatePickerMode;
    
    UIPopoverController * popover;
    UIViewController * pickerContainer;
    UIDatePicker * datePicker;
    NSDateFormatter *dateFormatter;
     
}

@property (nonatomic,retain) EFControlCore * core;

@property (nonatomic,retain) NSString * eName;
@property (nonatomic,assign) id eValue;
@property (nonatomic,retain) NSString * eLabel;
@property (nonatomic,retain) NSString * eBindName;
@property (nonatomic,retain) NSString * eDateFormat;
@property (nonatomic,assign) UIDatePickerMode  eDatePickerMode;

@property (nonatomic,retain) UIAlertView *datePickerAlert;

@end
@interface EFDatePicker(private)
- (void) initDefaultStatus;
@end
