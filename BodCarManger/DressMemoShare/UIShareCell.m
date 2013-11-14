//
//  UIShareCell.m
//  DressMemo
//
//  Created by Pan Fengfeng on 12-8-10.
//
//

#import "UIShareCell.h"
#import "SharePlatformCenter.h"

@implementation UIShareCell

@synthesize shareNameLabel = _shareNameLabel;
@synthesize nameLabel = _nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _shareNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _shareNameLabel.textAlignment = UITextAlignmentLeft;
        _shareNameLabel.backgroundColor = [UIColor clearColor];
        _shareNameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_shareNameLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textAlignment = UITextAlignmentRight;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self.contentView addSubview:_nameLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    Safe_Release(_shareNameLabel)
    Safe_Release(_nameLabel)
    
    [super dealloc];
}

#define kUIShareCellLeftPadding 10
#define kUIShareCellRightPadding 10
#define kUIShareCellTopPadding 10
#define kUIShareCellBottomPadding 10
#define kUIShareCellLabelHeight 18
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _shareNameLabel.frame = CGRectMake(kUIShareCellLeftPadding,
                                       kUIShareCellTopPadding,
                                       100, kUIShareCellLabelHeight);
    _nameLabel.frame = CGRectMake(self.contentView.bounds.size.width-kUIShareCellRightPadding-100,
                                  kUIShareCellTopPadding,
                                  100, kUIShareCellLabelHeight);
    
}

- (void)reloadData:(NSString *)platformType{
    _shareNameLabel.text = [[SharePlatformCenter defaultCenter] plateformNameWithKey:platformType];
    NSDictionary *data = [[SharePlatformCenter defaultCenter] modelDataWithType:platformType];
    
    if([[data objectForKey:K_PLATFORM_MODEL_UID] isKindOfClass:[NSString class]])   
        _nameLabel.text = [data objectForKey:K_PLATFORM_MODEL_UID];
    else
        _nameLabel.text = @"未绑定";
}

+ (CGFloat)cellHeight{
    return (kUIShareCellLabelHeight+kUIShareCellTopPadding+kUIShareCellBottomPadding);
}

@end
