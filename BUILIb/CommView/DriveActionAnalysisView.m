//
//  DriveActionAnalysisView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "DriveActionAnalysisView.h"

#define  kOilMothFormart    @"%02d月起停油耗分析表" 

@interface DriveActionAnalysisView(){
    
    UILabel *conclusionLabel;
    UILabel *dateShowLabel;
}
@property(nonatomic,strong)NSMutableArray *percentShowLabelArray;
@end
@implementation DriveActionAnalysisView
@synthesize oilData;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.percentShowLabelArray = [NSMutableArray array];
      

        CGRect rect = CGRectMake(18.f,20.f,50, 50);
        [self addPercentView:rect];

        
        UIImage *bgImage = [UIImage imageNamed:@"oil_analysis_graph.png"];
        rect = CGRectMake(15.f, 104.f, bgImage.size.width/kScale, bgImage.size.height/kScale);
        CGFloat currY = rect.origin.y+rect.size.height;
        [self addLineChartView:rect withBGImage:bgImage];
        
        rect = CGRectMake(25, 102,200, 20);
        dateShowLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor whiteColor] withText:@"" withFrame:rect];
        dateShowLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:dateShowLabel];
        SafeRelease(dateShowLabel);
        
        
        //
        CGFloat startY = 27.f;
        NSArray *tagArray = @[@"blue.png",@"green.png",@"yellow.png"];
        
        for(int i = 0;i<3;i++){
            bgImage = [UIImage imageNamed:tagArray[i]];
            rect = CGRectMake(141,startY+6, bgImage.size.width/kScale, bgImage.size.height/kScale);
            UIImageView *imageView = [[UIImageView alloc]initWithImage:bgImage];
            imageView.frame = rect;
            [self addSubview:imageView];
            SafeRelease(imageView);
          
            rect = CGRectMake(141+rect.size.width+10,startY,250, 20);
            UILabel *textLabel  = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor whiteColor] withText:@"" withFrame:rect];
            textLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:textLabel];
            SafeRelease(textLabel);
            [self.percentShowLabelArray addObject:textLabel];
            startY = startY+ 24;
        }
        
        bgImage = [UIImage imageNamed:@"oil_conclusion_tag.png"];
        rect = CGRectMake(21.f,currY+18.f, bgImage.size.width/kScale, bgImage.size.height/kScale);
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:bgImage];
        imageView.frame = rect;
        [self addSubview:imageView];
        
        SafeRelease(imageView);
        
        rect = CGRectMake(50,currY+14.f,250, 20);
        conclusionLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor whiteColor] withText:@"" withFrame:rect];
        conclusionLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:conclusionLabel];
        SafeRelease(conclusionLabel);
        
//        UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f,image.size.width/2.f, image.size.height/2.f)];
    }
    return self;
}
- (void)updateUIByData:(OilAnalysisData*)data{
    self.oilData = data;
    //@[@32,@28,@40];
    NSArray *percentArray = self.oilData.percentDataArray;
    NSArray *colorArray = @[HexRGB(79, 120, 205),
                            HexRGB(92, 200, 92),
                            HexRGB(237, 209, 69),
                            ];
    
    
    NSString *showText = [NSString stringWithFormat:kOilMothFormart,oilData.date.month];
    conclusionLabel.text = oilData.conclusionText;
    dateShowLabel.text = showText;
    [self updateLinesUIByData:nil];
    NSArray *formartArray = @[@"低速行驶时间: %d%@",@"经济行驶时间: %d\%@",@"高速行驶时间: %d\%@"];
    
    NSString *precentText = @"";
    for(int i = 0;i<[formartArray count];i++){
        precentText = [NSString stringWithFormat:formartArray[i],[percentArray[i]intValue],@"%"];
        id item = [self.percentShowLabelArray objectAtIndex:i];
        [item setText:precentText];
    }
    NSMutableArray *testData = [NSMutableArray array];
    for(int i = 0 ;i<3;i++){
        NSMutableDictionary *item = [NSMutableDictionary dictionary];
        [item setValue:percentArray[i] forKey:@"percent"];
        [item setValue:colorArray[i] forKey:@"color"];
        [testData addObject:item];
    }
    [self setDisplayViewData:testData withType:0];
}
- (void)updateLinesUIByData:(NSMutableArray*)data{

    NSMutableArray *linesArray = [NSMutableArray array];
    int lastx = 0;
    int lasty = 10;
    for(int i = 1;i<=5;i++){
        NSMutableDictionary *item = [NSMutableDictionary dictionary];
        
        int x = rand()%3+lastx+1;
        int y = rand()%50+lasty+10;
        [item setValue:[NSString stringWithFormat:@"%d",x] forKey:@"x"];
        [item setValue:[NSString stringWithFormat:@"%d",y] forKey:@"y"];
        [linesArray addObject:item];
        lastx = x;
        lasty = y;
    }
    NE_LOG(@"%@",linesArray);
    [self  setDisplayLineChart:linesArray];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    // Drawing code
//}

@end
