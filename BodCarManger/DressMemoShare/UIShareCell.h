//
//  UIShareCell.h
//  DressMemo
//
//  Created by Pan Fengfeng on 12-8-10.
//
//

#import <UIKit/UIKit.h>

@interface UIShareCell : UITableViewCell{
    UILabel     *_shareNameLabel;
    UILabel     *_nameLabel;
}

@property (nonatomic, readonly)UILabel     *shareNameLabel;
@property (nonatomic, readonly)UILabel     *nameLabel;

- (void)reloadData:(NSString *)platformType;
+ (CGFloat)cellHeight;
@end
