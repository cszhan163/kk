//
//  MessageTableViewCell.h
//  BodCarManger
//
//  Created by cszhan on 13-10-3.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageBoxCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *mTagImageView;
@property(nonatomic,strong)IBOutlet UILabel     *mDateLabel;
@property(nonatomic,strong)IBOutlet UILabel     *mTypeLabel;
@property(nonatomic,strong)IBOutlet UITextView  *mMsgTextLabel;

+(CGFloat)cellHeight:(NSDictionary*)data;
@end
