//
//  EiInfo2Json.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-3.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EiInfo.h"
#import "JSON.h"
#import "EiBlock.h"

@interface EiInfo2Json : NSObject {

}




+ (NSString*) EiInfo2JsonString :(EiInfo*) info;

+ (NSString *) EiBlock2JsonString:(EiBlock *)inblock;

+ (id) EiInfo2JsonObject:(EiInfo *) info;

+(id) Map2JsonObject:(NSMutableDictionary *) map;

+(id) EiBlock2JsonObject:(EiBlock *) eiBlock;

+(id) EiBlockMeta2JsonObject:(EiBlockMeta *) eiBlockMeta;

+(id) EiColumn2JsonObject:(EiColumn *)eiColumn index:(int)index;




@end
