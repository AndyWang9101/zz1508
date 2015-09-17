//
//  BeginViewController.m
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/9.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#import "BeginViewController.h"
#import "Factory.h"
#import "TabBarViewController.h"
#define Count 4
@interface BeginViewController ()
{
    UIImageView *_imageView;
    
    int _index;
}
@end

@implementation BeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createImageView];
    //_index = 0;

}

-(void)createImageView{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imageView.image = [UIImage imageNamed:@"开机0.png"];
    [self.view addSubview:_imageView];
    //添加手势
    //左
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left];
    //右
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:right];
}
//左滑
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}
//右滑
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}
#pragma mark - 转场动画
-(void)transitionAnimation:(BOOL)isNext{
    //1、创建转场动画对象
    CATransition *transition = [[CATransition alloc] init];
    //2、设置动画类型(没公开的动画类型只能使用字符串，没有对应的常量定义)
    transition.type = @"cube";//最下边标注
    //3、设置子类型
    
    if (isNext ) {
        transition.subtype = kCATransitionFromRight;
    } else{
        transition.subtype = kCATransitionFromLeft;
    }
    //设置动画时长
    transition.duration = 1.0f;
    //设置转场后的新视图添加转场动画
    _imageView.image = [self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
    
}
//取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext && _index<Count) {
        _index = (_index+1)%Count;
        if (_index == 3) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(200, 600,self.view.frame.size.width-200-50, 44);
            [btn setTitle:@"马上体验~~" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor lightGrayColor];
            [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }
    } else {
        _index = (_index-1+Count)%Count;
    }
    NSString *imageName = [NSString stringWithFormat:@"开机%d.png",_index];
    return [UIImage imageNamed:imageName];
}

- (void)buttonClick{
    TabBarViewController *tvc = [[TabBarViewController alloc]init];
//    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.frame];
//    img.image = [UIImage imageNamed: @"开机3"];
    [self presentViewController:tvc animated:YES completion:nil];
//    [self presentViewController:tvc animated:YES completion:^{
//        [UIView animateWithDuration:7 animations:^{
//            DDLog(@"ddfad");
//            img.alpha = 0.0;
//        } completion:^(BOOL finished){
//            [img removeFromSuperview];
//        }];
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
