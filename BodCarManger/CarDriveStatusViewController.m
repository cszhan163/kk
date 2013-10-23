//
//  CarMonitorViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-9-17.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarDriveStatusViewController.h"

#import "BSPreViewScrollView.h"
#import "CarDriveStatusView.h"

#import "CarDriveOilAnalaysisViewController.h"

#import "CarDriveMannerAnalysisViewController.h"

#define kLeftPendingX  11
#define kTopPendingY  8
#define kHeaderItemPendingY 8

#define kDriveStatusViewWidth  300
#define kDriveStatusViewHeight 350

@interface CarMonitorViewController()<BSPreviewScrollViewDelegate>

@end

@implementation CarMonitorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"BG.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    [self setNavgationBarTitle:NSLocalizedString(@"Drive Monitor", @""
                                                 )];
    [self setRightBtnHidden:YES];
    [self setHiddenLeftBtn:YES];
    
    
    CGRect viewRect = CGRectMake(kLeftPendingX,kMBAppTopToolBarHeight+kTopPendingY,kDeviceScreenWidth-2*kLeftPendingX,kMBAppRealViewHeight-kTopPendingY-60.f);
    /*
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:bgView];
    
    bgView.frame = viewRect;
      */
    CGSize size = viewRect.size;//CGSizeMake(viewRect.size, bgImage.size.height/kScale);
    BSPreviewScrollView *scrollerView = [[BSPreviewScrollView alloc]initWithFrameAndPageSize:CGRectMake(0.f, 0.f,size.width, size.height) pageSize:size];
    scrollerView.delegate = self;
    scrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollerView];
    scrollerView.layer.cornerRadius = 5.f;
    scrollerView.frame =  viewRect;
    scrollerView.clipsToBounds = YES;
    
    [scrollerView setPageControlHidden:NO];
    
    
    StyledPageControl *pageControl = [scrollerView getPageControl];
    /*
    UIImage *image  = nil;
    UIImageWithFileName(image ,@"point-gray.png");
    pageControl.thumbImage = image;
    UIImageWithFileName(image ,@"point-red.png");
    pageControl.selectedThumbImage = image;
    pageControl.pageControlStyle = PageControlStyleThumb;
    */
    
    CGRect rect = pageControl.frame;
    //[self.scrollViewPreview setPageControlFrame:CGRectMake(0.f,rect.size.height-80.f,kDeviceScreenWidth, 40.f)];
    pageControl.frame = CGRectOffset(rect, 0.f, -10.f);

    [scrollerView bringSubviewToFront:pageControl];
    
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"油耗分析" withTag:0];
    [scrollerView addSubview:oilAnalaysisBtn];
    oilAnalaysisBtn.frame = CGRectMake(20.f,size.height-60.f, 80.f, 40);
    [oilAnalaysisBtn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *driveAnalysisBtn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"驾驶情况分析" withTag:1];
    [scrollerView addSubview:driveAnalysisBtn];
    driveAnalysisBtn.frame =  CGRectMake(180.f,size.height-60.f,120.f, 40);
    [driveAnalysisBtn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
-(UIView*)viewForItemAtIndex:(BSPreviewScrollView*)scrollView index:(int)index{
    
    UIView *maskView =[[UIView alloc]initWithFrame:CGRectMake(0.,0.f,kDriveStatusViewWidth, kDriveStatusViewHeight)];
    // maskView.frame =
    //[maskView addSubview:maskView];
    CarDriveStatusView *carDriveStatusView = [UIComUtil  instanceFromNibWithName:@"CarDriveStatusView"];
    [maskView addSubview:carDriveStatusView];
    [carDriveStatusView setTarget:self withAction:@selector(didTouchButton:)];
    //SafeRelease(carDriveStatusView);
    return maskView;
}
-(int)itemCount:(BSPreviewScrollView*)scrollView{
    return  3;
}
-(void)didScrollerView:(BSPreviewScrollView*)scrollView{


}

#pragma mark -
#pragma mark View Delegate
- (void)didTouchButton:(id)sender{

    switch ([sender tag]) {
        case 0:
            {
                CarDriveOilAnalaysisViewController *carDriveOilAnalaysisVc = [[CarDriveOilAnalaysisViewController
                                                                               alloc]init];
                [self.navigationController pushViewController:carDriveOilAnalaysisVc animated:YES];
                SafeRelease(carDriveOilAnalaysisVc);
            }
            break;
        case 1:
        {
            CarDriveMannerAnalysisViewController *carDriveMannerAnalysisVc =
            [[CarDriveMannerAnalysisViewController
              alloc]init];
            [self.navigationController pushViewController:carDriveMannerAnalysisVc animated:YES];
            SafeRelease(carDriveMannerAnalysisVc);
        
        }
        default:
            break;
    }

}
@end
