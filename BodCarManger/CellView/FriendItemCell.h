//
//  FriendItemCell.h
//  DressMemo
//
//  Created by  on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UINetActiveIndicatorButton.h"
#import "UICarTableViewCell.h"
@class UINetActiveIndicatorButton;
@interface FriendItemCell : UICarTableViewCell
@property(nonatomic,retain)IBOutlet UILabel *nickNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *locationLabel;
@property(nonatomic,strong)IBOutlet UILabel *indictTextLabel;
@property(nonatomic,retain)IBOutlet UINetActiveIndicatorButton *relationBtn;
@property(nonatomic,retain)IBOutlet UIImageView *userIconImageView;
+(id)getFromNibFile;
@end
