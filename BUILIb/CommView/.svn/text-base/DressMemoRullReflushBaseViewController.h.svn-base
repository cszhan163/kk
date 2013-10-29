//
//  DresMemoRullReflushBaseViewController.h
//  DressMemo
//
//  Created by cszhan on 12-8-10.
//
//

#import "DressMemoViewController.h"
@protocol DressMemoRullReflushBaseViewControllerScollerDelegate
@optional
-(void)didScrollerView:(id)sender;
-(void)didScrollerViewUp:(id)sender;
-(void)didScrollerViewDown:(id)sender;
@end
@interface DressMemoRullReflushBaseViewController : DressMemoViewController
@property(nonatomic,assign)UINavigationController *navigationController;
@property(nonatomic,assign)BOOL isNeedRefulsh;
@property(nonatomic,assign)id<DressMemoRullReflushBaseViewControllerScollerDelegate> scollerDelegate;
 
@end
