//
//  DriveActionAnalysisView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "DriveActionAnalysisView.h"


@implementation DriveActionAnalysisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *data = @[@18,@28,@40];
        [self setDisplayViewData:data withType:0];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
