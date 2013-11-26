//
//  KokTool.h
//  kok
//
//  Created by cszhan on 12-12-11.
//  Copyright (c) 2012年 raiyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kDeviceScreenWidth			[[UIScreen mainScreen]bounds].size.width
#define kDeviceScreenHeight			[[UIScreen mainScreen]bounds].size.height
#define kAppStatusBarHeight      20.f
//#define kAppNavigationBarHeight     45.f

#define UIImageWithNibName(image,filename)   image = [UIImage imageNamed:filename]
#define kDeviceCheckIphone5 (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? 0:1)
//#define UIImageWithFileName(image,filename) image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]bundlePath],filename]]
//#define UIImageWithFileName(image,filename) image = [UIImage imageNamed:filename]
#define IPhone5FileName(filename) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? filename : [NSString stringWithFormat:@"%@-568h@2x",filename])
// iPhone 5 support
#define UIImageWithIPhone5FileName(image,filename,ext) image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IPhone5FileName(filename) ofType:ext]]

#define  UIColorWithRGBA(x,y,z,al)  [UIColor colorWithRed:(x/255.f) green:y/255.f     blue:z/255.f alpha:al]


//#if __has_feature(objc_arc)
//#define SafeRelease(x) 
//#define SafeAutoRelease(x)
//#else
//#define SafeAutoRelease(x) [(x) autorelease]
////#ifndef SafeRelease(x)
//#define SafeRelease(x) [(x) release];
////#endif
//#endif



@interface KokTool : NSObject

#if __has_feature(objc_arc) == 1
+(void)saveByteArray2File:(unsigned char*)pByteArray size:(unsigned int)nSize  directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileName;
+(void)deleteNewArrayObject:(char*)ptr;
+(void)revertRGBLineRowDataArr:(unsigned char*)ptr withHeight:(int)height withWidth:(int)width;
+(void)saveUIImageData:(UIImage*)image directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileName;
+ (NSString*)getLocalizedLanguage;
+(NSString*)getIPbyDomain:(NSString*)domain;
+(NSString*)getPhoneConnectNetworkInfo;
+(NSString *)getLocalMacAddress;
+(NSString *)getIPAddress;
+(BOOL)isIPAdrressAvailable:(NSString*)ipString withPort:(NSString*)port;
#else
+(void)getPlaceNameByPosition:(NSArray*)locationArray;

+(void)deleteNewArrayObject:(char*)ptr;
+(void)saveByteArray2File:(unsigned char*)pByteArray size:(unsigned int)nSize  directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileName;
+(void)revertRGBLineRowDataArr:(unsigned char*)ptr withHeight:(int)height withWidth:(int)width;
+ (NSString*)getLocalizedLanguage;
+(NSString*)getIPbyDomain:(NSString*)domain;
+(NSString*)getPhoneConnectNetworkInfo;
+(NSString *)getLocalMacAddress;
+(NSString *)getIPAddress;
+(BOOL)isIPAdrressAvailable:(NSString*)ipString withPort:(NSString*)port;
#endif
+ (void)startTimeCheckPoint:(NSString*)tag;
+ (void)endTimeCheckPoint:(NSString*)tag;
@end
