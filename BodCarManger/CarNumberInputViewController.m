//
//  CarNumberInputViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-27.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarNumberInputViewController.h"
static char *carNumProvince[] = {"京","津","冀","晋","蒙","辽","吉","黑","沪","苏","浙","皖","闽","赣",
    "鲁","豫","鄂","湘","粤","桂","琼","渝","川","黔","云","藏","陕","甘","青","宁","新"};
@interface CarNumberInputViewController (){
    
    UILabel *headerLabel;
    NSRange currRange;
    
}
@property(nonatomic,strong)NSString *lastString;
@property(nonatomic,strong)NSString *replaceString;
@property(nonatomic,strong)NSMutableArray *proviceArray;
@property(nonatomic,strong)NSMutableArray *characterArray;
@end

@implementation CarNumberInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.proviceArray = [NSMutableArray array];
        self.characterArray = [NSMutableArray array];
        //[ZCSNotficationMgr addObserver:self call:@selector(didChangeText:) msgName:UITextFieldTextDidChangeNotification];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    for(int i = 0;i<sizeof(carNumProvince)/sizeof(carNumProvince[0]);i++){
        NSString *item = [NSString stringWithUTF8String:carNumProvince[i]];
        [self.proviceArray addObject:item];
    }
    char character[26];
    for(int i = 0;i<26;i++){
        character[i]='A'+i;
    }
    for(int i = 0;i<26;i++){
        NSString *item = [NSString stringWithFormat:@"%c",character[i]];
        [self.characterArray addObject:item];
    }
    NSString *provinceStr = nil;
    
    
    if([self.userEmail length]>=1){
    }
    else{
        self.userEmail = @"沪A12345";
    }
    self.subClassInputTextField.text = [self.userEmail substringFromIndex:1];
    provinceStr = [self.userEmail substringToIndex:1];
    /*
    NSRange range ;
    range.location = 1;
    range.length = 1;
    NSString *charStr = [self.userEmail substringWithRange:range];
    int charIndex = 0;
    
    for(int i = 0;i<26;i++){
        if([[self.characterArray objectAtIndex:i]isEqualToString:charStr]){
            charIndex = i;
            break;
        }
    }
    */
    int proviceIndex = 0;
    for(int i = 0;i<[self.proviceArray count];i++){
        if([[self.proviceArray objectAtIndex:i]isEqualToString:provinceStr]){
            proviceIndex = i;
            break;
        }
    }
#if 1
    CGRect rect = self.subClassInputTextField.frame;
    headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor whiteColor] withText:[self.userEmail substringToIndex:1] withFrame:CGRectMake(rect.origin.x,rect.origin.y,80.f,rect.size.height)];
    headerLabel.textAlignment = NSTextAlignmentRight;
    headerLabel.text = provinceStr;
    [self.view addSubview:headerLabel];
    SafeRelease(headerLabel);

    self.subClassInputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.subClassInputTextField.frame = CGRectMake(rect.origin.x+80, rect.origin.y, rect.size.width-80.f, rect.size.height);
    
#endif
    UIPickerView *picView = [[UIPickerView alloc]initWithFrame:CGRectMake(0.f,100, 320.f,218)];
    picView.delegate = self;
    picView.dataSource = self;
    picView.showsSelectionIndicator = YES;
    [self.view addSubview:picView];
    [picView selectRow:proviceIndex inComponent:0 animated:YES];
    //[picView selectRow:charIndex inComponent:1 animated:YES];
    SafeRelease(picView);
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(component ==0){
        return [self.proviceArray count];
    }
    else if(component ==1){
        return [self.characterArray count];
    }
    return  0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if(component ==0){
        return [self.proviceArray objectAtIndex:row];
    }
    else if(component == 1){
        return [self.characterArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
#if 0
    NSInteger charIndex = [pickerView selectedRowInComponent:1];
    
    NSString *headerStr = [NSString stringWithFormat:@"%@%@",[self.proviceArray objectAtIndex:provinceIndex],[self.characterArray objectAtIndex:charIndex]];
    NSRange range;
    range.length = 2;
    range.location = 0;
#else
    NSString *headerStr = [NSString stringWithFormat:@"%@",[self.proviceArray objectAtIndex:provinceIndex]];
    NSRange range;
    range.length = 1;
    range.location = 0;
#endif
    self.userEmail = [self.userEmail stringByReplacingCharactersInRange:range withString:headerStr];
    headerLabel.text = headerStr;
    
}
-(void)didSelectorTopNavItem:(id)navObj
{
	NE_LOG(@"select item:%d",[navObj tag]);
    
	switch ([navObj tag])
	{
		case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];// animated:
        }
        break;
		case 1:
		{
            if([self.subClassInputTextField.text isEqualToString:@""]){
                return;
            }
            //[self startRestPassword];
            if(delegate && [delegate respondsToSelector:@selector(setCellItemData:withIndexPath:)]){
                NSString *result = @"";
                result = [NSString stringWithFormat:@"%@%@",headerLabel.text,self.subClassInputTextField.text];
                [delegate setCellItemData:result withIndexPath:self.indexPath];
            }
            [self.navigationController popViewControllerAnimated:YES];
			break;
		}
	}
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if([newString length]>6){
    
        return NO;
    }
    else
        return YES;
    
    
//    if([textField.text length]>6){
//        return NO;
//    }
//    else if([textField.text length]==6 && range.location>[textField.text length]-1){
//        return NO;
//    }
//    else{
//        return YES;
//    }
//    self.lastString = textField.text;
//    currRange = range;
//    self.replaceString = string;
//    return YES;
}

- (void)didChangeText:(NSNotification*)ntf{
//    if([self.subClassInputTextField.text length]>6){
//        
//        self.subClassInputTextField.text = self.lastString;
//        
//    }
        //        return NO;
        //    }
        //    else if([textField.text length]==6 && range.location>[textField.text length]-1){
        //        return NO;
        //    }
        //    else{
        //        return YES;
        //    }

}

@end
