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
        NSArray *percentArray = @[@18,@28,@40];
        NSArray *colorArray = @[HexRGB(79, 120, 205),
                                HexRGB(92, 200, 92),
                                HexRGB(237, 209, 69),
                                ];
        NSMutableArray *testData = [NSMutableArray array];
        for(int i = 0 ;i<3;i++){
            NSMutableDictionary *item = [NSMutableDictionary dictionary];
            [item setValue:percentArray[i] forKey:@"percent"];
            [item setValue:colorArray[i] forKey:@"color"];
            [testData addObject:item];
        }
        [self setDisplayViewData:testData withType:0];
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
