//
//  PlatException.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-2.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlatException : NSObject {
	NSString * error_msg;
	NSString * error_type;

}

@property(readwrite,retain) NSString *error_msg;
@property(readwrite,retain) NSString *error_type;

@end
