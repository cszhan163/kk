//
//  EFImageView.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-20.
//  Copyright 2011 baosteel. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "EFFoundation.h"
// 支持本地加载以及远程多线程加载



@interface EFImageAsynView : UIView {

    
	NSURLConnection* connection;  
	
    
    NSMutableData* data; 
	
}

- (void)loadImageFromURL:(NSURL*)url;
- (UIImage*) image;

@end




@interface EFImage : UIImageView <IDataContext> {
	
	NSString * eUrl ;
	
}
@property(nonatomic,retain) EFControlCore * core;

@property (nonatomic,retain) NSString * eName;
@property (nonatomic,assign) id eValue;
@property (nonatomic,retain) NSString * eLabel;
@property (nonatomic,retain) NSString * eBindName;

@property(nonatomic,retain)NSString * eUrl;



@end

@interface EFImage(private)
- (void) initDefaultStatus;
@end
