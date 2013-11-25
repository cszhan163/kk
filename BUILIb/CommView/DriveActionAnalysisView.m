//
//  DriveActionAnalysisView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "DriveActionAnalysisView.h"



@interface DriveActionAnalysisView(){
    
    UILabel *conclusionLabel;
    UILabel *dateShowLabel;
}
@property(nonatomic,strong)NSMutableArray *percentShowLabelArray;
@end
@implementation DriveActionAnalysisView
@synthesize colorArray;
@synthesize oilData;
- (id)initWithFrame:(CGRect)frame  
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initData];

        [self addUIView];
        
//        UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f,image.size.width/2.f, image.size.height/2.f)];
    }
    return self;
}
- (void)initData{
    self.colorArray =       @[HexRGB(79, 120, 205),
                              HexRGB(92, 200, 92),
                              HexRGB(237, 209, 69),
                              ];
    self.percentShowLabelArray = [NSMutableArray array];
    
    self.tagImageArray = @[@"blue.png",@"green.png",@"yellow.png"];
}
- (void)addUIView{
    
    CGFloat startY = 27.f;
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
    for(int i = 0;i<3;i++){
        bgImage = [UIImage imageNamed:self.tagImageArray[i]];
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

}
- (id)initWithFrame:(CGRect)frame  withLineColorArray:(NSArray*)colorArr withTagImageArray:(NSArray*)tagImageArray{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initData];
        self.colorArray = colorArr;
        self.tagImageArray = tagImageArray;
        [self addUIView];
    }
    return  self;
}
- (void)updateUIByData:(OilAnalysisData*)data{
    self.oilData = data;
    //@[@32,@28,@40];
    NSArray *percentArray = self.oilData.percentDataArray;
  
    
    
   
    conclusionLabel.text = oilData.conclusionText;
    dateShowLabel.text = oilData.indictorText;
    
    NSArray *formartArray = data.textFormatArray;
    
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
    
    [self updateLinesUIByData:data.linesDataArray];
}
- (void)updateLinesUIByData:(NSMutableArray*)data{
    /*
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
     */
    [drawLineView setDrawLineColors:self.colorArray];
    for(NSArray *item in data){
        [self addDisplayLineChart:item];
        //[self  setDisplayLineChart:linesArray];
    }
    [drawLineView setNeedsDisplay];
    //drawLineView.
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    // Drawing code
//}

@end
