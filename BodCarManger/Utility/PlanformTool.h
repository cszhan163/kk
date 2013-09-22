//
//  PlanformTool.h
//  TVMobileSdk
//
//  Created by cszhan on 13-7-9.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#ifndef TVMobileSdk_PlanformTool_h
#define TVMobileSdk_PlanformTool_h

//#define DEBUG_UMENG
#define INFOR_TOP 1
#ifdef DEBUG
#define NE_LOG(fmt,...)       NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define NE_LOGPOINT(x)  NSLog(@"%@",NSStringFromCGPoint(x))
#define NE_LOGRECT(x)  NSLog(@"%@",NSStringFromCGRect(x))
#else
#define NE_LOG(fmt,...) 
#define NE_LOGPOINT(x)
#define NE_LOGRECT(x)
#endif
#if __has_feature(objc_arc)
#define KokSafeRelease(x)
#define kokSafeRetain(x,y) x = y
#define SafeRelease(x)
#define SafeAutoRelease(x)
#else
#define KokSafeRelease(x) [(x) release]
#define kokSafeRetain(x,y)  x = [(y) retain]
#define SafeRelease(x) KokSafeRelease(x)
#define SafeAutoRelease(x)  [(x) autorelease]
#endif
#if __has_feature(objc_arc)
#else
#define unsafe_unretain assign
#define __bridge
#endif


#endif
