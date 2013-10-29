//
//  frmRegist.h
//  kkshop
//
//  Created by apple  on 12-8-7.
//
//

#import <UIKit/UIKit.h>
#import "CardShopLoginViewController.h"
@interface CardShopResignViewController : CardShopLoginViewController
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,retain)IBOutlet UILabel  *navTitleLabel;
@property(nonatomic,retain)IBOutlet UITextField *mobilePhoneTextFied;
@property(nonatomic,retain)IBOutlet UITextField *radomCodeTextFied;
@property(nonatomic,retain)IBOutlet UITextField *passwordTextFied;
@property(nonatomic,retain)IBOutlet UITextField *confirmPasswordTextFied;
@property(nonatomic,retain)NSString *mobilePhoneNumStr;
-(IBAction)goBack:(id)sender;
@end
