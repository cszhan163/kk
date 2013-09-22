//
//  UIPhotoImageViewController.h
//  DressMemo
//
//  Created by cszhan on 12-8-7.
//
//

#import "UIIconImageNetViewController.h"
#import "DressMemoPhotoCache.h"
@interface UIPhotoImageViewController : UIIconImageNetViewController
@property(nonatomic,retain)NSArray *fileNameArr;
-(void)startuserCustomLoadCellImageData:(NSIndexPath*)indexPath;
@end
