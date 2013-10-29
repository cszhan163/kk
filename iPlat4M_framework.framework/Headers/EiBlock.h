//
//  EiBlock.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-3.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EiBlockMeta.h"
#import "EiColumn.h"
#import "BaseObject.h"


@interface EiBlock : BaseObject {
	EiBlockMeta * blockMeta;
	NSMutableArray * rows ;
	int colCount;
}


@property(nonatomic,retain) EiBlockMeta * blockMeta;

@property(nonatomic,retain) NSMutableArray * rows;

@property(nonatomic,assign) int colCount;


/**
 * 初始化函数.
 * 
 * @param blockId
 *            块ID
 */

-(id)init:(NSString *)blockId;

/**
 * 
 * @param blockMeta 列集合对象
 */

-(void)addBlockMeta:(EiBlockMeta *)blockMeta;

/**
 * 增加一个空数据行.
 */
-(void)addNewRow;

-(void)addRow:(NSMutableDictionary*)rowMap;

/**
 * 获取当前数据块的数据行数.
 * 
 * @return 数据行数
 */
-(int)getRowCount;

/**
 * 返回第rowNo行的数据. 如果输入的行号大于数据行数或者行号小于0,返回null
 * 
 * @param rowNo
 *            行号
 * 
 * @return 返回的数据行
 */

-(NSMutableDictionary*)getRow:(int)rowNo;

/**
 * 指定数据行号及列名,返回该行列对应的数据值. 如果输入的行号大于数据行数或者行号小于0,返回null
 * 
 * @param columnName
 *            列名
 * @param rowNo
 *            行号
 * 
 * @return 数据值
 */

/**
 * 增加一列
 * 如果传入的EiColumn为空,则返回
 * 如果block的元数据为空,则产生一个新的元数据对象
 * @param meta  
 */

-(void)addMeta:(EiColumn *)meta;

-(id)getCell:(int)rowNo columnName:(NSString *)columnName;


/**
 * 指定数据行号及列名,返回该行列对应的数据值,以字符串形式返回. 如果输入的行号大于数据行数或者行号小于0,返回null
 * 
 * @param columnName
 *            列名
 * @param rowNo
 *            行号
 * 
 * @return 数据值
 */

-(NSString *)getCellStr:(int)rowNo columnName:(NSString *)columnName;



/**
 * 根据行号、列号，取得数据值
 * @param {Object} sRowNo	：行号
 * @param {Object} sColPos	：列号
 * @return {String} value	: 数据值 
 */
-(id)getCellByPos:(int)sRowNo colPos:(int)sColPos;




/**
 * 指定行号及列名,设置该行列对应的数据值.
 * 
 * @param columnValue
 *            数据值
 * @param columnName
 *            列名
 * @param rowNo
 *            行号
 */

-(void)setCell:(int)rowNo columnName:(NSString *)columnName columnValue:(id)columnValue;




/**
 * 删除一列,以传入的EiColumn对象的id为key
 * 如果传入的column或者块的元数据为空,则返回
 * @param meta
 */

-(void) removeMeta:(EiColumn *)meta;
/**
 * 删除一列,以传入的string为key
 * 如果块的元数据为空,则返回
 * @param metaName
 */
-(void) removeMetaByName:(NSString *)metaName;

-(NSMutableArray *)getMappedRows;


/**
 * 删除一列数据,以传入的string为key
 *
 * @param colName
 */
-(void) removeCol:(NSString *)colName;

-(void) setRowWithArray:(NSArray*) array;


@end

@interface EiBlock(private)


/**
 * @private
 * @param {Object} row
 */
//-(NSMutableDictionary *)getMappedObject:(NSMutableDictionary *)row;
//-(NSMutableDictionary *)getPositionObject:(NSMutableDictionary *)row;


@end
