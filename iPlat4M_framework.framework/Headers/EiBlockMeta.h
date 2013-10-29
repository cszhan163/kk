//
//  EiBlockMeta.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-3.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EiColumn.h"
#import "BaseObject.h"


@interface EiBlockMeta : BaseObject {
	NSString * blockId;
	NSString * desc;
	NSMutableDictionary * metas;
	
		
	
}

@property(nonatomic,retain) NSString * blockId;
@property(nonatomic,retain) NSString * desc;
@property(nonatomic,retain) NSMutableDictionary * metas;



-(id)init:(NSString*)newBlockId;

-(int)getMetaCount;

-(void)addMetas:(NSMutableDictionary *) newMetas;
-(void)addBlockMetas:(EiBlockMeta *)newBlockMeta;
-(void)addMeta:(EiColumn *)newColumn;

-(EiColumn *)getMeta:(NSString *)metaName;

-(NSString *)getMetaNames;


-(EiColumn *)removeColumnMeta:(EiColumn *)column;

-(EiColumn *)removeMeta:(NSString *)metaName;



@end
