//
//  EiColumn.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-3.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"


@interface EiColumn : BaseObject {

	int pos;
	/**
	 * @private
	 */	

	NSString * name;
	/**
	 * @private
	 */	

	NSString * descName;
	/**
	 * @private
	 */	

	NSString * type ;
	/**
	 * @private
	 */              

	NSString * regex;
	/**
	 * @private
	 */              
  
	NSString * formatter ;
	/**
	 * @private
	 */       
 
	NSString * editor;
	/** 
	 * @private
	 */           
 
	int minLength;
	/**
	 * @private
	 */       

	int maxLength;
	/**
	 * @private
	 */    
  
	bool primaryKey ;
	/**
	 * @private
	 */   
 
	bool nullable ;
	/**
	 * @private
	 */   
 
	bool visible ;
	/** 
	 * @private
	 */        

	bool readonly ;
	/**
	 * @private
	 */        

	NSString * displayType;
	/**
	 * @private
	 */
  
	NSString * errorPrompt;
	/**
	 * @private
	 */    

	NSString * dateFormat;
	/**
	 * @private
	 */    
	NSString * defaultValue;
   
	/**
	 * @private
	 */ 
   
	NSString * validateType;
	/**
	 * @private
	 */

	int width;
	/**
	 * @private
	 */

	int height;
	/**
	 * @private
	 */
  
	NSString * align;
	/**
	 * @private
	 */   

	NSString * blockName;
	/**
	 * @private
	 */

	NSString * sourceName;
	/**
	 * @private
	 */

	NSString * labelProperty;
	/**
	 * @private
	 */   

	NSString * valueProperty;
	
	
	
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *type;
@property(nonatomic,retain) NSString *descName;
@property(nonatomic,retain) NSString *regex;
@property(nonatomic,retain) NSString *formatter;
@property(nonatomic,retain) NSString *editor;
@property(nonatomic,retain) NSString *align;


@property(nonatomic,retain) NSString *dateFormat;
@property(nonatomic,retain) NSString *validateType;
@property(nonatomic,retain) NSString *errorPrompt;
@property(nonatomic,retain) NSString *displayType;





@property(nonatomic,retain) NSString *defaultValue;
@property(nonatomic,retain) NSString *labelProperty;
@property(nonatomic,retain) NSString *valueProperty;
@property(nonatomic,retain) NSString *sourceName;
@property(nonatomic,retain) NSString *blockName;






@property(nonatomic,assign) int minLength;
@property(nonatomic,assign) int maxLength;

@property(nonatomic,assign) bool primaryKey;
@property(nonatomic,assign) bool nullable;
@property(nonatomic,assign) bool visible;
@property(nonatomic,assign) bool readonly;
@property(nonatomic,assign) int width;
@property(nonatomic,assign) int height;
@property(nonatomic,assign) int pos;

- (id)init:(NSString *)columnName;



@end
