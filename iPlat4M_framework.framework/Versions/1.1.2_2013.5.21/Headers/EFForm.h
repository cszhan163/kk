//
//  EFFormView.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-18.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFFoundation.h"



@interface EFForm : EFView{
	
	
}
@property (nonatomic,retain) NSMutableDictionary * row;
-(void) updateFromRow:(NSDictionary *)tempRow;
-(void) updateData;

@end
