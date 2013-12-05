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
+(UIButton*)createButtonWithNormalBGImageName:(NSString*)normaliconImage withSelectedBGImageName:(NSString*)selectedIconImage withTitle:(NSString*)text withTag:(NSInteger)tag;
+(UIButton*)createButtonWithNormalBGImage:(UIImage*)normaliconImage withHightBGImage:(UIImage*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag;


+(UIButton*)createButtonWithNormalBGImage:(UIImage*)normaliconImage withHightBGImage:(UIImage*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag withTarget:(id)target withTouchEvent:(SEL)event;


+(UIButton*)createButtonWithNormalBGImage:(UIImage*)normaliconImage withHightBGImage:(UIImage*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag withTarget:(id)target withTouchEvent:(SEL)event;

+(UILabel*)createLabelWithFont:(UIFont*)font withTextColor:(UIColor*)color withText:(NSString*)text withFrame:(CGRect)rect;

+(UIView*)createSplitViewWithFrame:(CGRect)frame withColor:(UIColor*)color;


+(NSString*)getDataToHexString:(unsigned char*)charStr withLength:(int)len;
+ (NSString*)getDocumentFilePath:(NSString*)fileName;

+ (void)shadowUIButtonText:(UIButton*)btn withShowdowColor:(UIColor*)color  withShadowOffset:(CGSize)shwSize;
+ (void)shadowUILabelText:(UILabel*)label withShowdowColor:(UIColor*)color  withShadowOffset:(CGSize)shwSize;
+ (id)instanceFromNibWithName:(NSString*)nibName;
+ (UIImage*)getCurrentViewShortCut:(UIView*)view ;
+ (NSMutableAttributedString*)getCustomAttributeString:(NSString*)text withFont:(UIFont*)font withColor:(UIColor*)color;
@end
