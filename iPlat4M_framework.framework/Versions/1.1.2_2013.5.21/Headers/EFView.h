//
//  EFView.h
//  iPlat4M
//
//  Created by Fu Yiming on 11-11-15.
//  Copyright 2011年 baosight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDataContext.h"

@interface EFView : UIView
{
}

@property (nonatomic,retain) NSString * eName;

@property (nonatomic,retain) EiInfo * innerEiInfo;
@end

@interface EFView(private)
- (void) UpdateToView:(UIView*)uiView EiInfo:(EiInfo *)info;
- (void) updateFromData:(EiInfo *)eiinfo;
- (void) updateToData:(EiInfo *)eiinfo;
- (EiInfo *) getEiInfo;
@end
