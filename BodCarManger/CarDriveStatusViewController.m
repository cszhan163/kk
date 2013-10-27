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

#import "CarMaintainanceView.h"

#define kLeftPendingX  10
#define kTopPendingY  8
#define kHeaderItemPendingY 8

#define kDriveStatusViewWidth  300
#define kDriveStatusViewHeight 259

#define kDriveMaintainanceLeftPendingX 36.f

@interface CarMonitorViewController()<BSPreviewScrollViewDelegate>{

    UILabel *panelHeaderLabel;
    
    CarMaintainanceView *carMaintainanceView;
}
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
    [self setNavgationBarTitle:NSLocalizedString(@"驾驶行为", @""
                                                 )];
    [self setRightBtnHidden:YES];
    [self setHiddenLeftBtn:YES];
    
    CGFloat currY = kMBAppTopToolBarHeight+kTopPendingY;
    
    UIImageWithFileName(bgImage, @"drive_panel_header.png");
    
#if 0
    panelHeaderLabel= [[UILabel alloc]initWithFrame:CGRectZero];
    panelHeaderLabel.text = @"七月驾驶情况";
    panelHeaderLabel.textAlignment = NSTextAlignmentCenter;
    panelHeaderLabel.layer.contents = (id)bgImage.CGImage;
    panelHeaderLabel.backgroundColor = [UIColor clearColor];
    panelHeaderLabel.frame = CGRectMake(kLeftPendingX,currY,bgImage.size.width/kScale, bgImage.size.height/kScale);
    [self.view  addSubview:panelHeaderLabel];
    SafeRelease(panelHeaderLabel);
    currY = currY+bgImage.size.height/kScale;
#else
    
#endif
    
    
    //bgView.frame = viewRect;
    
    
    
    CGRect viewRect = CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,kMBAppRealViewHeight-kTopPendingY-60.f-34.f);
    
  
    CGSize size = viewRect.size;//CGSizeMake(viewRect.size, bgImage.size.height/kScale);
    BSPreviewScrollView *scrollerView = [[BSPreviewScrollView alloc]initWithFrameAndPageSize:CGRectMake(0.f, 0.f,size.width, size.height) pageSize:size];
    scrollerView.delegate = self;
    [scrollerView setBoundces:NO];
    scrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollerView];
    scrollerView.layer.cornerRadius = 5.f;
    scrollerView.frame =  viewRect;
    scrollerView.clipsToBounds = YES;
    
    [scrollerView setPageControlHidden:NO];
    
    currY = currY+scrollerView.frame.size.height;
    StyledPageControl *pageControl = [scrollerView getPageControl];
#if 0
    UIImage *image  = nil;
    UIImageWithFileName(image ,@"page_normal.png");
    pageControl.thumbImage = image;
    UIImageWithFileName(image ,@"page_selected.png");
    pageControl.selectedThumbImage = image;
    pageControl.pageControlStyle = PageControlStyleThumb;
#else
    pageControl.coreNormalColor=  [UIColor whiteColor];
    pageControl.strokeNormalColor = [UIColor whiteColor];
    pageControl.coreSelectedColor = [UIColor grayColor];
    
#endif
    pageControl.diameter = 5.0;
    pageControl.strokeWidth = 2.f;
    
    CGRect rect = pageControl.frame;
    //[self.scrollViewPreview setPageControlFrame:CGRectMake(0.f,rect.size.height-80.f,kDeviceScreenWidth, 40.f)];
    pageControl.frame = CGRectOffset(rect, 0.f, -40.f+38-5);

    [scrollerView bringSubviewToFront:pageControl];
    
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"drive_oil_btn.png" withHightBGImageName:@"drive_oil_btn.png" withTitle:@"" withTag:0];
    [scrollerView addSubview:oilAnalaysisBtn];
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    oilAnalaysisBtn.frame = CGRectMake(25.f,size.height-10.f-btnsize.height,btnsize.width ,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *driveAnalysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"drive_habit_btn.png" withHightBGImageName:@"drive_habit_btn.png" withTitle:@"" withTag:1];
    [scrollerView addSubview:driveAnalysisBtn];
    btnsize = driveAnalysisBtn.frame.size;
    driveAnalysisBtn.frame =  CGRectMake(180.f+12,size.height-10.f-btnsize.height,btnsize.width ,btnsize.height);
    [driveAnalysisBtn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //for 
    //[self addMaintainaceUI];
  
    carMaintainanceView = [[CarMaintainanceView alloc]initWithFrame:CGRectMake(kDriveMaintainanceLeftPendingX,currY+8.f, kDeviceScreenWidth-2*kDriveMaintainanceLeftPendingX,80)];
    
    
    [carMaintainanceView setLeftProcessLen:84 rightLen:84];
    
    [self.view addSubview:carMaintainanceView];
    SafeRelease(carMaintainanceView);
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
}
- (void)addMaintainaceUI{
    
    
    
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
