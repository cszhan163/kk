//
//  IPhoneIndexViewController.h
//  iPlat4M_iPad
//
//  Created by baosight on 11-12-29.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPhoneIndexViewController : UIViewController<UINavigationControllerDelegate> {
    UIViewController *detailViewController;
    UIViewController *navigatViewController;
}
@property (nonatomic,retain) UIViewController *detailViewController;
@property (nonatomic,retain) UIViewController *navigatViewController;
- (IBAction)refreshTreeMenu:(id)sender ;
@end
