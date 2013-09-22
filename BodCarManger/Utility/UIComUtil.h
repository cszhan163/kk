//
//  UIComUtil.h
//  VoiceInput
//
//  Created by cszhan on 13-3-6.
//  Copyright (c) 2013年 DragonVoice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton (Extensions)

@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end

@interface UIComUtil : NSObject
+(UIButton*)createButtonWithNormalBGImageName:(NSString*)normaliconImage withHightBGImageName:(NSString*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag;

+(UIButton*)createButtonWithNormalBGImage:(UIImage*)normaliconImage withHightBGImage:(UIImage*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag;

+(NSString*)getDataToHexString:(unsigned char*)charStr withLength:(int)len;
+ (NSString*)getDocumentFilePath:(NSString*)fileName;

+ (void)shadowUIButtonText:(UIButton*)btn withShowdowColor:(UIColor*)color  withShadowOffset:(CGSize)shwSize;
+ (void)shadowUILabelText:(UILabel*)label withShowdowColor:(UIColor*)color  withShadowOffset:(CGSize)shwSize;
+ (id)instanceFromNibWithName:(NSString*)nibName;
@end
