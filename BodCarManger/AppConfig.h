//
//  AppConfig.h
//  DressMemo
//
//  Created by  on 12-6-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef DressMemo_AppConfig_h
#define DressMemo_AppConfig_h

#define  kDressMemoAppURLLink           @"http://itunes.apple.com/us/app/facebook/id284882215?mt=8"

#define  kDressMemoImageUrlRoot         @"http://211.152.50.207/cardmore/"
//#define  kDressMemoImageUrlRoot         @"http://upload.iclub7.com/"//@"http://upload.dressmemo.com"
//#define  kRequestApiRoot                @"http://211.144.193.13:8082/WebServiceDriveRecord/"
//#define  kRequestApiRoot                 @"http://211.152.50.207/cardmore/index.php?controller=jsonapi"
//#define  kRequestApiRoot                @"http://api.iclub7.com"

//#define  kDressMemoImageUrlRoot      @"http://upload.iclub7.com"
#define  kDressMemoUserIconScaleSize    @"_100_100"

#define  kDressMemoPhotoTinyScaleSize   @"_175_175"

#define  kDressMemoPhotoSmallScaleSize  @"_320x429.jpg"
//#define  kDressMemoPhoto



#define  kNavgationItemButtonTextFont [UIFont boldSystemFontOfSize:15] //[UIFont systemFontOfSize:15]

#define  kAppTextSystemFont(x) [UIFont systemFontOfSize:x]
#define  kAppTextBoldSystemFont(x) [UIFont boldSystemFontOfSize:x]
#define  kAppTextItalicSystemFont(x) [UIFont italicSystemFontOfSize:x];

#define  kTopNavItemLabelOffSetY  -2.f
#define  kTopNavItemLabelOffsetX  13.f

#define  kInputTextPenndingX      10.f

#define  kUIAlertView(y,x)  UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:y message:x delegate:self cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil, nil]autorelease];[alertErr show];alertErr.tag=9900;

#define kUIAlertViewNoDelegate(y,x) UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:y message:x delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil, nil]autorelease];[alertErr show];alertErr.tag=9900;
#define  kUIAlertConfirmView(title,msg,left,right)  UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:left otherButtonTitles:right,nil]autorelease];[alertErr show];

////if all the button is the same ,the offset should be all 0
//#define kTabAllItemTextCenterXOffset    @"3,-1,-3"
//#define kTabAllItemTextCenterYOffset    @"0,0,0"
//
//#define kTabAllItemText                 @"Dress what,Upload,Me"
////for tabItem text
//#define kTabItemTextPendingY            5.f
//#define kTabItemTextHeight              12
//#define kTabItemTextFont            [UIFont systemFontOfSize:12]
//
//
//#define kItemCellCount  3
//#define kTabCountMax                              3


#define kTabItemImageSubfix                       @"png"

#define  kUserImageDefaultName                  @"pic-user.png"

#define kAppUserBGWhiteColor        HexRGB(202, 202, 204)

#define kBaoTApp                @"baoTapp"

#define kNetNewThread
//#define kParserDataThread

#define kNetStartShow(x,y) [SVProgressHUD showWithStatus:x networkIndicator:YES]; [[SVProgressHUD sharedView]setCenter:y.center];y.userInteractionEnabled = NO
#define kNetEnd(y)  [SVProgressHUD dismiss];y.userInteractionEnabled = YES
#define kNetEndSuccStr(x,y) [SVProgressHUD dismissWithSuccess:x];y.userInteractionEnabled = YES
#define kNetEndWithErrorAutoDismiss(x,y) [SVProgressHUD show]; [SVProgressHUD dismissWithError:x afterDelay:y];


#define MSG_TIMER


#define kCheckCardRecentRun     @"checkCardRecentRun"

#define kQueryCarInfoMSG        @"queryCarInfoMSG"

/**
 login and register
 */
#define  kUserDidLoginOk           @"userLoginOk"
#define  kUserDidResignOK           @"userDidResignOk"
#define  kUserDidLogOut             @"userLogOut"

#define kDidUserLoginOK             @"diduserLoginOk"

#define KNewMessageFromMSG          @"newMessageMSG"

/*view controller*/
#define kViewControllerWillPush     @"viewControllerWillPush"


#define kNeedReflushBuyData         @"needReflushBuyData"

#define kWillScrollerShowView       @"willScrollerShowView"

#define kScrollerViewWillDisappear  @"scrollerViewWillDisappear"
#define kScrollerViewWillAppear     @"scrollerViewWillAppear"


/*
 photo pick
 */
#define kUploadPhotoPickChooseMSG     @"uploadPhotoPickChooseMSG"
#define kUploadPhotoPickChooseEditMSG @"uploadPhotoPickChooseEditMSG"
#define kUploadActionSheetViewAlertMSG @"uploadActionSheetViewAlertMSG"

//user
#define kCarUserRegister                @"userRegister"
#define kCarUserLogin                   @"userLogin"
#define kCarUserUpdatePass              @"updateUserPassword"
#define kCarUserUpdatePhone             @"updateUserPhoneNumber"
#define kCarUserLocation                @"setLocationEnable"
#define kCarBrandQuery                  @"queryVehcileBrand"
#define kCarSeriesQuery                 @"queryVehcileSeries"
#define kCarModelQuery                 @"queryVehcileModel"


#define kCarInfoQuery                   @"queryVehInfo"
#define kCarInfoUpdate                  @"updateVehicleInfo"

//router
#define kResRouterDataMoth              @"queryTripCalanderMonth"
#define kResRouterDataDay               @"queryTripDay"
#define kResRouterNow                   @"queryTripNow"
#define kResRouterLatest                @"queryLastTripID"
#define kResRouterHistory               @"queryTripHistory"

//drive
#define kResDriveDataMoth                       @"queryDriveMonthData"
#define kResDriveActionAnalysis                 @"querySafeAnalyse"
#define kResDriveOilAnalysis                    @"queryEconomicAnalyse"
#define kResDriveMaintainData                   @"queryMaintain"
//check
#define kResCarCheckData                        @"queryConData"

#define kResMessageData                         @"queryMessage"

#define kResReplyMessageData                         @"ackMessage"

#define kDateFormart   @"%d%02d"

#define Infinite
#define kMapHasTab   1

#define kLocationPhone 0

#define RUNNING_PAUST 0

#define  kLowSpeed   20
#define  kNormalSpeed  40

#define  kHighSpeed  60

#define kFetchMessageLen 10

#define TEST_RUNNING 0

#define RunningCenter 1

#define kAlertCardBidTXT                    @"请先添加车辆信息"

#define kNeedCarBindMSG                     @"needCarBindMSG"

#define UMENG_APPKEY                        @"52ae6d1256240b08b11d1968"

#endif

