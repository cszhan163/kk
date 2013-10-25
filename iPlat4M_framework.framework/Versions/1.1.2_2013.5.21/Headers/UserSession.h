//
//  UserSession.h
//  iPlat4M_iPad
//
//  Created by liuxi on 11-11-9.
//  Copyright 2011年 BaoSight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject
{
}
@property (nonatomic, retain) NSString *userTokenID;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *encryptKey;
@property (nonatomic, retain) NSString *encryptVector;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *deviceToken;
@property (nonatomic, retain) NSString *deviceTokenStrForPushNotifi;

@property (nonatomic) BOOL didGoBackGroundWhenOverhaul;
@end
