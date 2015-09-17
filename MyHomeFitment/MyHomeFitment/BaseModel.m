//
//  BaseModel.m
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//kvc 赋值的时候 如果 没有找到key 对应的对象 的属性 会调用下面的方法，
//如果不实现 程序 就会崩溃
//写出来可以防止崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
