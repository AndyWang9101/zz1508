//
//  Define.h
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/9.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#ifndef MyHomeFitment_Define_h
#define MyHomeFitment_Define_h
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "NetInterface.h"

//获取屏幕大小
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kIsOpen @"isOpen"//是否打开过

#ifdef DEBUG
#define DDLog(...) NSLog(__VA_ARGS__)
#else
#define DDLog(...)
#endif

#endif
