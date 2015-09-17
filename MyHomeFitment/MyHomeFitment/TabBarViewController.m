//
//  TabBarViewController.m
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#import "TabBarViewController.h"
#import "BaseViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建子视图控制器
- (void)createViewControllers{
    NSArray *children = @[@"ScanViewController",@"ReferenceViewController",@"CommunityViewController",@"SpecialistViewController",@"MyViewController"];
    //NSArray *titles = @[@"风格大览",@"灵感参考",@"社区论坛",@"专业咨询",@"我的装吧"];
    NSArray *images = @[@"浏览-常态",@"灵感-常态",@"社区-常态",@"专家-常态",@"我-常态"];
    NSMutableArray *vcAry = [[NSMutableArray alloc]init];
    for (NSInteger i = 0;  i < children.count; i++) {
        Class childrenClass = NSClassFromString(children[i]);
        BaseViewController *viewController = [[childrenClass alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        //nav.tabBarItem.title = titles[i];
        nav.tabBarItem.image = [UIImage imageNamed:images[i]];
        [vcAry addObject:nav];
    }
    self.viewControllers = vcAry;
    self.tabBar.tintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
