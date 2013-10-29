//
//  BaseObject.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-5.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseObject : NSObject {
	NSMutableDictionary * attr;
	
}

@property(nonatomic,retain)  NSMutableDictionary* attr;

- (id)init;//初始化

- (id) get:(NSString *)key;//获取值

- (void) set:(NSString *)key value:(id) value;

-(NSString*) getString:(NSString*) key;

-(int) getInt:(NSString*) key;

@end
