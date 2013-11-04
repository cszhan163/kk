//
//  UIComUtil.m
//  VoiceInput
//
//  Created by cszhan on 13-3-6.
//  Copyright (c) 2013年 DragonVoice. All rights reserved.
//

#import "UIComUtil.h"
//#import "UIButton+Extensions.h"
#import <objc/runtime.h>
@implementation UIImage (JTColor)

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
@implementation UIButton (Extensions)

@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) ||       !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

@end

@implementation UIComUtil
+(UIButton*)createButtonWithNormalBGImageName:(NSString*)normaliconImage withHightBGImageName:(NSString*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag{
    UIImage *image = nil;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageWithFileName(image,normaliconImage);
    if(normaliconImage)
        assert(image);
    else{
        image = [UIImage imageFromColor:[UIColor blackColor]];
    }
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateDisabled];
    UIImageWithFileName(image,hightIconImage);
    if(normaliconImage)
        assert(image);
    else{
        image = [UIImage imageFromColor:[UIColor redColor]];
    }
    //btn.titleLabel.text = text;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateHighlighted];
    [btn setBackgroundImage:image forState:UIControlStateSelected];
    //[btn setBackgroundImage:image forState:UIControlStateHighlighted];
    if(normaliconImage)
        btn.frame = CGRectMake(0.f, 0.f,image.size.width/kScale, image.size.height/kScale);
    btn.tag = tag;
    return btn;
}
+(UIButton*)createButtonWithNormalBGImage:(UIImage*)normaliconImage withHightBGImage:(UIImage*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:normaliconImage forState:UIControlStateNormal];
    [btn setBackgroundImage:normaliconImage forState:UIControlStateDisabled];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateHighlighted];
    [btn setBackgroundImage:hightIconImage forState:UIControlStateHighlighted];
    if(normaliconImage)
        btn.frame = CGRectMake(0.f, 0.f,normaliconImage.size.width/normaliconImage.scale, normaliconImage.size.height/normaliconImage.scale);
    btn.tag = tag;
    return btn;

}
+(UIButton*)createButtonWithNormalBGImageName:(NSString*)normaliconImage withHightBGImageName:(NSString*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag withTarget:(id)target withTouchEvent:(SEL)event{
    
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:normaliconImage withHightBGImageName :hightIconImage withTitle:text withTag:tag];
    [btn addTarget:target action:event forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(UIButton*)createButtonWithNormalBGImage:(UIImage*)normaliconImage withHightBGImage:(UIImage*)hightIconImage withTitle:(NSString*)text withTag:(NSInteger)tag withTarget:(id)target withTouchEvent:(SEL)event{
    
    UIButton *btn = [UIComUtil createButtonWithNormalBGImage:normaliconImage withHightBGImage:hightIconImage withTitle:text withTag:tag];
    [btn addTarget:target action:event forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}
+(UIView *)createSplitViewWithFrame:(CGRect)frame withColor:(UIColor*)color{
    UIView *splitLine = [[UIView alloc]initWithFrame:frame];
    splitLine.backgroundColor = [UIColor whiteColor];
    splitLine.alpha = 0.1;
    splitLine.backgroundColor = color;
    return splitLine;
}
+(UILabel*)createLabelWithFont:(UIFont*)font withTextColor:(UIColor*)color withText:(NSString*)text withFrame:(CGRect)rect{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.font = font;
    label.textColor = color;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
+(UIButton*)createButtonWithNormalBGImageName:(NSString*)normaliconImage withSelectedBGImageName:(NSString*)selectedIconImage withTitle:(NSString*)text withTag:(NSInteger)tag{
    UIImage *image = nil;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageWithFileName(image,normaliconImage);
    if(normaliconImage)
        assert(image);
    else{
        image = [UIImage imageFromColor:[UIColor blackColor]];
    }
    //[btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    UIImageWithFileName(image,selectedIconImage);
    if(normaliconImage)
        assert(image);
    else{
        image = [UIImage imageFromColor:[UIColor redColor]];
    }
    //btn.titleLabel.text = text;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateSelected];
    [btn setBackgroundImage:image forState:UIControlStateSelected];
    //[btn setImage:image forState:UIControlStateSelected];
    if(normaliconImage)
        btn.frame = CGRectMake(0.f, 0.f,image.size.width/kScale, image.size.height/kScale);
    btn.tag = tag;
    return btn;
}
+(NSString*)getDataToHexString:(unsigned char*)charStr withLength:(int)len{
    NSMutableString *result = [NSMutableString string];
    for(int i = 0;i<len;i++){
        [result appendString:[NSString stringWithFormat:@"%02X",charStr[i]]];
    }
    return result;
}
+ (NSString*)getDocumentFilePath:(NSString*)fileName{
    NSString *path = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    return filePath;
}

+ (void)shadowUIButtonText:(UIButton*)btn withShowdowColor:(UIColor*)color  withShadowOffset:(CGSize)shwSize
{

    [btn setTitleShadowColor:color forState:UIControlStateNormal];
    [btn setTitleShadowColor:color forState:UIControlStateHighlighted];
    //btn.titleLabel.shadowColor = color;
    btn.titleLabel.shadowOffset  = shwSize;

}
+ (void)shadowUILabelText:(UILabel*)label withShowdowColor:(UIColor*)color  withShadowOffset:(CGSize)shwSize
{
    
    label.textColor = color;
    label.shadowOffset  = shwSize;
    
}
+ (id)instanceFromNibWithName:(NSString*)nibName{
    NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:nibName
                                                    owner:self options:nil];
    for (id oneObject in nibArr)
        if ([oneObject isKindOfClass:[NSClassFromString(nibName) class]])
            return oneObject;
    return nil;
}
@end
