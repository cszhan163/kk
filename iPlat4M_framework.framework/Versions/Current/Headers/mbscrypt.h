//
//  crypt.h
//  httptest
//
//  Created by memac.cn on 11-2-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface mbscrypt : NSObject {
	

}
+ (NSData *)AES128Encrypt: (NSData *)input 
				  WithKey: (NSString *)key
			   WithVector: (NSString *)vector;
+ (NSData *)AES128Encrypt2: (NSData *)input 
				  WithKey: (NSString *)key
			   WithVector: (NSString *)vector;
+ (NSData *)AES128Decrypt: (NSData *)input
				  WithKey: (NSString *)key
			   WithVector: (NSString *)vector;

@end
