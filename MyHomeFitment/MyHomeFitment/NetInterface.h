//
//  NetInterface.h
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#ifndef MyHomeFitment_NetInterface_h
#define MyHomeFitment_NetInterface_h

//浏览接口
#define kScan @"http://api.meilijia.com/app/featured_page3?page=%ld"
//图片展示接口
#define kReference1 @"http://api.meilijia.com/app/idea_photos?page=%ld&show_styles=1"
//画册展示接口
#define kReference2 @"http://api.meilijia.com/app/idea_collections?page=%ld"
//装修吧接口
#define kCommunity_fitment @"http://api.meilijia.com/app/ba_diary_book_list?page=%ld&type=2&sort="
//讨论区接口
#define kCommunity_discuss @"http://api.meilijia.com/app/topic_list?page=%ld&sort="
// 讨论区页面详情
#define KCommunity_discuss2 @"http://api.meilijia.com/app/topic_list?page=1&sort=&class_id=%ld"




////讨论区  全部接口
//http://api.meilijia.com/app/topic_list?page=1&sort=
////讨论区  户型接口
//http://api.meilijia.com/app/topic_list?page=1&sort=&class_id=1
////讨论区  图片提问接口
//http://api.meilijia.com/app/topic_list?page=1&sort=&class_id=9
////讨论区 设计接口
//http://api.meilijia.com/app/topic_list?page=1&sort=&class_id=3
////讨论区  施工接口
//http://api.meilijia.com/app/topic_list?page=1&sort=&class_id=4
////讨论区  产品选购
//http://api.meilijia.com/app/topic_list?page=1&sort=&class_id=6
//专家（设计师）接口



#define kSpecialist1 @"http://api.meilijia.com/app/advanced_pro_list?page=1&sort=&zone="
//工长接口
#define kSpecialist2 @"http://api.meilijia.com/app/advanced_pro_gz_list?page=1&sort=&zone="

#endif
