//
//  SqliteManager.h
//  iPlat4M
//
//  Created by liuxi on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "sqlite3.h" 

@interface SqliteManager : NSObject { 
    sqlite3 *database; 
} 
#pragma mark - 数据库的初始化
/** 
 * 方法：
 * 功能： 
 * 描述：数据库名称
 * 返回：
 **/
@property (nonatomic,retain) NSString * dbName;
/** 
 * 方法：
 * 功能： 
 * 描述：数据库debug模式
 * 返回：
 **/
@property (nonatomic) BOOL deBug;

/** 
 * 方法：initWithDBName: 
 * 功能：初始化数据库名称 
 * 描述：dbName为数据库名称
 * 返回：SqliteManager实例 
 **/
-(id) initWithDBName:(NSString *) dbName;
/** 
 * 方法：createDatabase: 
 * 功能：创建数据库 
 * 描述：
 * 返回：创建成功返回YES,否则返回NO 
 **/ 
-(BOOL)createDatabase; 

/** 
 * 方法：openDatabase: 
 * 功能：打开数据库 
 * 描述：
 * 返回：打开成功返回YES,否则返回NO 
 **/ 
-(BOOL)openDatabase;

/** 
 * 方法：createTableWithSql:inDatabase: 
 * 功能：创建表 
 * 描述：sql是创建表的结构化查询语句，tbName是要创建的表
 * 返回：创建成功返回YES,否则返回NO 
 **/ 
-(BOOL)createTableWithSql:(NSString*)sql 
                  byTable:(NSString*)tbName; 

/** 
 * 方法：isTableExist: 
 * 功能：检查数据库中是否存在指定表 
 * 描述：tbName是要查找的表名
 * 返回：存在返回YES,否则返回NO 
 **/ 
-(BOOL)isTableExist:(NSString*)tbName;

/** 
 * 方法：closeDatabase: 
 * 功能：关闭数据库 
 * 描述：
 * 返回：关闭成功返回YES,否则返回NO 
 **/ 
-(BOOL)closeDatabase;
#pragma mark - 数据库的增删改查
/** 
 * 方法：insertDataWithDict:withTable:toTable: 
 * 功能：向表中插入数据 
 * 描述：dataDict的key值为字段名称，value为相应key对应的字段值;tbName为将要插入的数据表名
 * 返回：插入成功返回YES,否则返回NO 
 **/ 
-(BOOL) insertDataWithDict:(NSMutableDictionary *) dataDict 
                   toTable:(NSString *) tbName;


/** 
 * 方法：deleteDataWithCondStr:fromTable:
 * 功能：删除数据 
 * 描述：dataStr存放删除条件，tbName为表名
 * 返回：成功返回YES，失败返回NO
 **/ 
-(BOOL) deleteDataWithCondStr:(NSString *) condStr 
                     fromTable:(NSString *) tbName;

/** 
 * 方法：updateDataWithDict:condStr:toTable:
 * 功能：删除数据 
 * 描述：condStr存放删除条件，tbName为表名
 * 返回：成功返回YES，失败返回NO
 **/ 
-(BOOL) updateDataWithDict:(NSMutableDictionary *) dataDict 
                  condStr:(NSString *) condStr
                   toTable:(NSString *) tbName;

/** 
 * 方法：queryDataWithCondStr: OrderStr: fromTable:
 * 功能：查询数据 
 * 描述：sql是查询语句 
 * 返回：查询之后的结果集 
 **/ 

-(NSArray*)queryDataWithCondStr:(NSString *) condStr 
                       orderStr:(NSString *) orderStr
                      fromTable:(NSString *) tbName;
/** 
 * 方法：exeSql: 
 * 功能：执行自定义sql对数据库的增、删、改操作
 * 描述：sql语句 
 * 返回：成功返回YES，失败返回NO
 **/
-(BOOL) exeSql:(NSString *)sql;
/** 
 * 方法：exeSql: 
 * 功能：执行自定义sql对数据库的查询操作
 * 描述：sql语句 
 * 返回：成功返回YES，失败返回NO
 **/
-(NSArray *) exeQuerySql:(NSString *)sql;

/** 
 * 方法：getLastInsertRowId 
 * 功能：获得最后插入数据的id
 * 描述：sql语句 
 * 返回：id数据
 **/
-(int) getLastInsertRowId;

/** 
 * 方法：beginTransaction 
 * 功能：开启事务 
 * 描述：--
 * 返回：成功返回YES，失败返回NO
 **/ 
#pragma mark - 数据库的事务处理
- (BOOL)beginTransaction;

/** 
 * 方法：commitTransaction 
 * 功能：提交事务 
 * 描述：--
 * 返回：成功返回YES，失败返回NO
 **/ 
- (BOOL)commitTransaction;

/** 
 * 方法：rollbackTransaction 
 * 功能：事务回滚 
 * 描述：--
 * 返回：成功返回YES，失败返回NO
 **/
- (BOOL)rollbackTransaction;

@end





