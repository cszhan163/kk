//
//  UIImage+Ex.h
//  kok
//
//  Created by cszhan on 12-12-7.
//  Copyright (c) 2012年 raiyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Extend)
#if __has_feature(objc_arc) 
-(void)convertToRGBData:(char**)data withLen:(int*)len;
+(void)saveByteArray2File:(unsigned char*)pByteArray size:(unsigned int)nSize  directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileNmae;
+(UIImage*)convertFromRGBData:(char*)rgbData withSize:(CGSize)size;
+(UIImage*)imagePatternDrawWithImage:(UIImage*)image withSize:(CGSize)size ;
+ (UIImage*)imageFromColor:(UIColor*)color;
+(UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage ;
+(UIImage*) coverImage:(UIImage *)image withMask:(UIImage *)maskImage;
#else
-(void)convertToRGBData:(char**)data withLen:(int*)len;
+(void)saveByteArray2File:(unsigned char*)pByteArray size:(unsigned int)nSize  directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileNmae;
+(UIImage*)convertFromRGBData:(char*)rgbData withSize:(CGSize)size;
+(UIImage*)imagePatternDrawWithImage:(UIImage*)image withSize:(CGSize)size;
+ (UIImage*)imageFromColor:(UIColor*)color;
+(UIImage*)imageFromColor:(UIColor *)color withConnerRadius:(CGFloat)radius;
+(UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
+(UIImage*) coverImage:(UIImage *)image withMask:(UIImage *)maskImage;
#endif
@end
