//
//  AppConfig.h
//  DressMemo
//
//  Created by  on 12-6-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef DressMemo_AppConfig_h
#define DressMemo_AppConfig_h

#define  kDressMemoAppURLLink           @"http://itunes.apple.com/us/app/yi-chu-tong-gaodressmemo/id560418256?ls=1&mt=8"
#define  kDressMemoImageUrlRoot         @"http://upload.dressmemo.com"
//#define  kDressMemoImageUrlRoot         @"http://upload.iclub7.com/"//@"http://upload.dressmemo.com"
#define  kRequestApiRoot                @"http://api.dressmemo.com"
//#define  kRequestApiRoot                @"http://api.iclub7.com"

//#define  kDressMemoImageUrlRoot      @"http://upload.iclub7.com"
#define  kDressMemoUserIconScaleSize    @"_100x100.jpg"

#define  kDressMemoPhotoTinyScaleSize   @"_190x254.jpg"
#define  kDressMemoPhotoSmallScaleSize  @"_320x429.jpg"
//#define  kDressMemoPhoto


#define  kCurrentLoginUser   @"currentLoginUser"

#define  kNavgationItemButtonTextFont [UIFont boldSystemFontOfSize:15] //[UIFont systemFontOfSize:15]

#define  kAppTextSystemFont(x) [UIFont systemFontOfSize:x]
#define  kAppTextBoldSystemFont(x) [UIFont boldSystemFontOfSize:x]
#define  kAppTextItalicSystemFont(x) [UIFont italicSystemFontOfSize:x];

#define  kTopNavItemLabelOffSetY  -2.f
#define  kTopNavItemLabelOffsetX  13.f

#define  kInputTextPenndingX      10.f

#define  kUIAlertView(x)  UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:nil message:x delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok",nil) otherButtonTitles:nil, nil]autorelease];[alertErr show];
#define  kUIAlertConfirmView(title,msg,left,right)  UIAlertView *alertErr = [[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:left otherButtonTitles:right,nil]autorelease];[alertErr show];

//if all the button is the same ,the offset should be all 0
#define kTabAllItemTextCenterXOffset    @"3,-1,-3"
#define kTabAllItemTextCenterYOffset    @"0,0,0"

#define kTabAllItemText                 @"Dress what,Upload,Me"
//for tabItem text
#define kTabItemTextPendingY            5.f
#define kTabItemTextHeight              12
#define kTabItemTextFont            [UIFont systemFontOfSize:12]


#define kTabCountMax                              3
#define kTabItemImageSubfix                       @"png"

#define  kUserImageDefaultName                  @"pic-user.png"

#define kAppUserBGWhiteColor        HexRGB(236,236,236)

//#define kNetNewThread
#define kParserDataThread

#define kNetStartShow(x,y) [SVProgressHUD showWithStatus:x networkIndicator:YES]; [[SVProgressHUD sharedView]setCenter:y.center];y.userInteractionEnabled = NO
#define kNetEnd(y)  [SVProgressHUD dismiss];y.userInteractionEnabled = YES
#define kNetEndSuccStr(x,y) [SVProgressHUD dismissWithSuccess:x];y.userInteractionEnabled = YES
#define kNetEndSuccStrAutoDismiss(x,y,z) [SVProgressHUD dismissWithSuccess:x afterDelay:z];y.userInteractionEnabled = YES
#define kNetEndWithErrorAutoDismiss(x,y) [SVProgressHUD show]; [SVProgressHUD dismissWithError:x afterDelay:y];
#define kItemCellCount  3

#define MSG_TIMER
#define kGetNewMsgTimeLen  10

#endif

