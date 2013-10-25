//
//  Statement.m
//  iPlat4M
//
//  Created by liuxi on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <sqlite3.h>
#import <Foundation/Foundation.h>

@interface Statement : NSObject
{
    sqlite3_stmt*   stmt;
}
- (id)initWithDB:(sqlite3*)db query:(const char*)sql;

//+ (id)statementWithDB:(sqlite3*)db query:(const char*)sql;
+ (id)statementWithDB:(sqlite3*)db query:(NSString *) sql;
+(int) sqlExe:(sqlite3*)db exeSql:(NSString *) sql ;
// method
- (int)step;
- (void)reset;

// Getter
- (NSString*)getString:(int)index;
- (int)getInt32:(int)index;
- (long long)getInt64:(int)index;
- (NSData*)getData:(int)index;

-(int) getColumnCount;
-(NSString *) getColumnName:(int) index;
// Binder
- (void)bindString:(NSString*)value forIndex:(int)index;
- (void)bindInt32:(int)value forIndex:(int)index;
- (void)bindInt64:(long long)value forIndex:(int)index;
- (void)bindData:(NSData*)data forIndex:(int)index;

@end



