//
//  CarDetailPenalView.m
//  BodCarManger
//
//  Created by cszhan on 13-9-18.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDetailPenalView.h"
#import <QuartzCore/QuartzCore.h>
#define kCarDetailPanelViewImageViewPendingX 17
#define kCarDetailPanelViewLabelPendingX 40
@interface CarDetailPenalView(){
    
}
@end
@implementation CarDetailPenalView
@synthesize mDriveAnalaysisImageView;
@synthesize mOilCostAnalaysisImageView;
@synthesize mRotateSpeedLabel;
@synthesize mRunDistanceLabel;
@synthesize mRunSpeedLabel;
@synthesize mRunTemperatureLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bgImage = nil;
        UIImageWithFileName(bgImage, @"router_panel_bg.png");
        self.frame = CGRectMake(frame.origin.x,frame.origin.y, bgImage.size.width,bgImage.size.height);
        self.layer.contents = (id)bgImage.CGImage;
        
        for(int i = 0;i<2;i++){
            for(int j = 0;j<2;j++){
            
                
            }
            
        }
        mDriveAnalaysisImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kCarDetailPanelViewImageViewPendingX,0.,0.,0.f)];
    }
    return self;
}
- (void)initUI{
    /*
    self.mRunSpeedLabel.font = [UIFont systemFontOfSize:12];
    self.mRunSpeedLabel.font = [UIFont systemFontOfSize:12];
    self.mRunTemperatureLabel.font
     */
    for(id item in self.subviews){
        if([item isKindOfClass:[UILabel class]]){
            UILabel *tempItem = (UILabel*)item;
            tempItem.backgroundColor = [UIColor clearColor];
            tempItem.textColor = [UIColor whiteColor];
            tempItem.font = [UIFont systemFontOfSize:12];
        }
    }
}
- (void)awakeFromNib{
    [self initUI];
}
- (void)setUILayOutByData:(NSDictionary*)data{


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
