//
//  UIImage+Ex.m
//  kok
//
//  Created by cszhan on 12-12-7.
//  Copyright (c) 2012年 raiyin. All rights reserved.
//

#import "UIImage+Ex.h"
//#import "ANImageBitmapRep.h"
#import <CoreFoundation/CoreFoundation.h>

@implementation UIImage(Extend)
-(void)convertToRGBData:(char**)data withLen:(int*)len
{
#if 1
    CGImageAlphaInfo type = CGImageGetAlphaInfo(self.CGImage);
    NSLog(@"Image:%d",type);
    NSData* pixelData = (__bridge NSData*)CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage));
    uint myLength = [pixelData length];
    *data = new char[3*myLength/4];
    char *srcData =  new char[myLength];
    [pixelData getBytes:srcData length:myLength];
    int index = 0;
    for(int i = 0; i < myLength; i += 4)
    {
        //CHANGE PIXELS HERE
        /*
         Sidenote: Just show me how to NSLog them
         RGB or 
         */
        //Example:
#if 0       
        NSLog(@"Black 255-Value is: %0x", srcData[i]);
        NSLog(@"Red 255-Value is: %0x", srcData[i+1]);
        NSLog(@"Green 255-Value is: %0x", srcData[i+2]);
        NSLog(@"Alpha 255-Value is: %0x", srcData[i+3]);
#endif
        (*data)[index++]= srcData[i];
        (*data)[index++] = srcData[i+1];
        (*data)[index++] = srcData[i+2];
    }
    
    *len =  index;
#if __has_feature(objc_arc)
    CFBridgingRelease((__bridge CFDataRef)pixelData);
#else
    CFRelease((__bridge CFDataRef)pixelData);
     delete[] srcData;
#endif
   
#else
        
#endif
  
}
+(void)saveByteArray2File:(unsigned char*)pByteArray size:(unsigned int)nSize  directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileNmae
{
    NSData* pixelData = [[NSData alloc] initWithBytesNoCopy:pByteArray length:nSize freeWhenDone:NO];
    if(pixelData)
    {
        if(pDirectoryName == nil)
            pDirectoryName = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];

        NSString* pFilePath = [NSString stringWithFormat:@"%@/%@",pDirectoryName,pStrFileNmae ];
        /*
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:pFileName];
        //[[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
         */
        NSError *error = nil;
        if([pixelData writeToFile:pFilePath options:NSDataWritingAtomic error:&error])
        {
            NSLog(@"write ok");
        }
        else
        {
            NSLog(@"write failed:%@",[error description]);
        }
    }
#if __has_feature(obj_arc)
    [pixelData release];
#else
    
#endif
}
+(UIImage*)convertFromRGBData:(char*)rgbData withSize:(CGSize)size{

    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
#if 0
    CFDataRef data2 = CFDataCreateWithBytesNoCopy(kCFAllocatorDefault,(UInt8*)rgbData,size.width*size.height*3,kCFAllocatorNull);
#else
    assert(size.width);
    assert(size.height);
    CFDataRef data2 = CFDataCreate(kCFAllocatorDefault, (UInt8*)rgbData,size.width*size.height*3);
#endif
    assert(data2);
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data2);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef cgImage = CGImageCreate(size.width,
                                       size.height,
                                       8,
                                       8*3,
                                       size.width*3,
                                       colorSpace,
                                       bitmapInfo,
                                       provider,
                                       NULL,
                                       NO,
                                       kCGRenderingIntentDefault);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGDataProviderRelease(provider);
    CFRelease(data2);
    //[self release];
    //self = image;
    /*
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Test.png"];
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
     */
    return image;
}
+(UIImage*)imagePatternDrawWithImage:(UIImage*)image withSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGRect drawRect = CGRectMake(0.f,0.f,size.width, size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextClearRect(context,CGRectMake(0.f,0.f,size.width, size.height));
    CGContextClipToRect(context,drawRect);
    CGContextDrawTiledImage(context,CGRectMake(0.f, 0.f, image.size.width*2, image.size.height*2),image.CGImage);
    //CGContextTranslateCTM(context, 0,1);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  img;
}
+ (UIImage*)imageFromColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0, 0, 2, 2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  img;
}
+(UIImage*)imageFromColor:(UIColor *)color withConnerRadius:(CGFloat)radius{
   
    CGRect rect = CGRectMake(0, 0, 2, 2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
     UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:2.0];
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    [bezierPath stroke];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
      return  img;
}
+(UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
    
}
+(UIImage*) coverImage:(UIImage *)image withMask:(UIImage *)maskImage{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width,image.size.height);
    UIGraphicsBeginImageContext(image.size);
   
    [image drawInRect:rect];
    
    CGRect centerRect = CGRectMake((image.size.width-maskImage.size.width)/2.f, (image.size.height-maskImage.size.height)/2.f, maskImage.size.width, maskImage.size.height) ;
     NSLog(@"%@",NSStringFromCGRect(centerRect));
    [maskImage drawInRect:centerRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%lf,%lf,",newImage.size.width,newImage.size.height);
    return newImage;
}
@end
