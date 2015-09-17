//
//  ScanCellTop.m
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/12.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#import "ScanCellTop.h"
#define Count 8
@interface ScanCellTop ()<UIScrollViewDelegate>

@end
@implementation ScanCellTop{
    UIScrollView *_top;
    NSTimer *_timer;
    UIPageControl *_pageControl;
}

- (void)awakeFromNib {
    // Initialization code
}
//-(void)dealloc{
//    if ([_timer isValid]) {
//        [_timer invalidate];
//    }
//
//}
-(void)createImageView{
    if (!_top ) {
        _top = [[UIScrollView alloc]initWithFrame:self.bounds];
    }else{
        return;
    }
    _top.pagingEnabled = YES;
    _top.contentSize = CGSizeMake(self.bounds.size.width * 8,0);
    //
    _top.delegate = self;
    //页面控制器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(130, 170, 100, 25)];
  //  _pageControl.backgroundColor = [UIColor orangeColor];
    _pageControl.numberOfPages = 8;
    
    
    
    [self addImageToScrollView];
    [self.contentView addSubview:_top];
    
    [self.contentView addSubview:_pageControl];
    [self.contentView bringSubviewToFront:_pageControl];
}

-(void)addImageToScrollView{

    
    
    for (int i = 0; i < 8; i ++) {
        UIImageView *image = [[UIImageView alloc]init];
        image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"滑动图片%d.JPG",i]]];
        [image setFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, 200)];
        [_top addSubview:image];
        
    }
    

    [self timerOn];
}
    
-(void)changeFrame{
    NSInteger i = _pageControl.currentPage;//当前页
    if (i==7) {
        i=-1;
    }
    i++;
    [_top setContentOffset:CGPointMake(i*self.bounds.size.width, 0) animated:YES];
}

-(void)timerOff{
    [_timer invalidate];//invalidate 使。。无效
    _timer=nil;
}
//当用户准备拖拽的时候，关闭定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self timerOff];
}
//当用户停止拖拽的时候，添加一个定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self timerOn];
}
-(void)timerOn{
    _timer  = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

    
    
//这个事判断定时器滚动的时候，实时判断滚动位置，以让Page Controll显示当前的点是哪一个点
//这个需要在总宽度上加上半个scrollView的宽度，是为了保证拖拽到一半时候左右的效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage=(self.bounds.size.width/2+scrollView.contentOffset.x)/self.bounds.size.width;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
