//
//  Utils.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-9.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject {

}

/**
 * 判断某一对象是否为空。
 * @param {Object} obj	:	所要判断的对象
 * @return {boolean}	:	若obj为空对象(null或undefined)或是空字符串("")，
 * 返回false，否则返回true。
 * @exception 无异常抛出
 */
+(bool)isAvailable:(id)obj;

+(bool)isEqual:(id)obj1 obj2:(id)obj2;


@end
