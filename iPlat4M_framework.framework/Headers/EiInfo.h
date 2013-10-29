//
//  EiInfo.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-1.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EiInfo.h"
#import "EiBlock.h"
#import "EiColumn.h"
#import "EiBlockMeta.h"
#import "EiConstant.h"
#import "BaseObject.h"



@interface EiInfo : BaseObject {

	NSString * name;
	NSString * descName;
	NSString * msg;
	NSString * msgKey;
	NSString * detailMsg;
	NSMutableDictionary * blocks;
	
	int status;
	

}  

@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * descName;
@property(nonatomic,retain) NSString * msg;
@property(nonatomic,retain) NSString * msgKey;
@property(nonatomic,retain) NSString * detailMsg;

@property(nonatomic,retain) NSMutableDictionary * blocks;


@property(nonatomic,assign) int status;



//function 

/**
 * 构造函数.将传入的字符串设为当前对象的名称
 * 
 * @param name 名称
 */

-(id) initByName:(NSString *)eiinfoName;

-(id) init;





/**
 * 获取指定Id的数据块对象.
 * 
 * @param blockId 数据块ID
 * 
 * @return 数据块ID对应的数据块
 */

-(EiBlock *) getBlock:(NSString *) blockId;



-(EiBlock *)addBlockById:(NSString *)blockId;


/**
 * 将一个数据块对象加入此对象中.
 * 若此对象中已经存在相同ID的数据块对象,则不新增
 * 
 * @param eiBlock 欲加入的数据块对象
 */
-(EiBlock *)addBlock:(EiBlock *)eiBlock;


/**
 * 指定数据块ID,行号及列名,设定其数据值.
 * 
 * @param columnValue 数据值
 * @param blockId 数据块ID
 * @param rowNo 行号
 * @param columnName 列名
 */

-(void)setCell:(NSString*)blockId rowNo:(int)rowNo columnName:(NSString*)columnName columnValue:(NSString*)columnValue;



/**
 * 指定数据块ID,行号及列名,获取其数据值.
 * 
 * @param blockId 数据块ID
 * @param rowNo 行号
 * @param columnName 列名
 * 
 * @return 数据值
 */
-(id)getCell:(NSString*)blockId rowNo:(int)rowNo columnName:(NSString*)columnName;




-(void) setValue:(NSString *) value ForeBindingName:(NSString *) eBindingName;

-(id) getValueForeBindingName:(NSString *) eBindingName;

@end
