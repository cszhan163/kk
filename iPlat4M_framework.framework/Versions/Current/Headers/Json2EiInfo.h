//
//  Json2EiInfo.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-3.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EiInfo.h"
#import "JSON.h"

@interface Json2EiInfo : NSObject {
	
}

+ (EiInfo *)parseString:(NSString *)jsonStr;

+ (EiInfo *)parseJsonObject:(NSMutableDictionary *)jsonObj;

+ (EiBlock *)parseBlock:(NSString *)blockId blockObj:(NSMutableDictionary *)blockObj;

+ (EiBlockMeta *)parseBlockMeta:(NSString *)blockMetaId blockObj:(NSMutableDictionary*)blockMetaObj;

+ (EiColumn *)parseColumn:(NSMutableDictionary*)columnObj;





@end
