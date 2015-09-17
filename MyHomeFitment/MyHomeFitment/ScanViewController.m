//
//  ScanViewController.m
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#import "ScanViewController.h"
#import "AFNetworking.h"
#import "ScanModel.h"
#import "SQHelper.h"
#import "Factory.h"
#import "ScanCell.h"
#import "ScanCellTop.h"
#import "MMProgressHUD.h"
#import "JHRefresh.h"

@interface ScanViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIScrollView *_topScrollerView;
    UITableView *_tableView;
    NSInteger _currentPage;
    BOOL _isRefreshing;
    BOOL _isLoadMore;
}
@property (nonatomic, strong)UITableView *   tableView;
@property (nonatomic,strong) NSMutableArray *dataAry;
@property (nonatomic)   NSInteger currentPage;
@property (nonatomic)        BOOL  isRefreshing;
@property (nonatomic)        BOOL isLoadMore;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self loadFirstPage];
    [self createRefreshView];

    self.navigationItem.title = @"浏览";
    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    _dataAry = [[NSMutableArray alloc]init];
}

#pragma mark - 解析数据
- (void)loadFirstPage {
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    _currentPage = 1;
    NSString *url = nil;
    url = [NSString stringWithFormat:kScan,self.currentPage];
    [self parserInfo:url isRefresh:NO];
}
//下拉刷新
-(void)createRefreshView {
    //增加下拉刷新
    __weak typeof (self) weakSelf = self;//弱引用
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //重新下载数据
        if (weakSelf.isRefreshing ) {
            return ;
        }
        //[weakSelf.dataAry removeAllObjects];
        weakSelf.isRefreshing = YES;//标记正在刷新
        weakSelf.currentPage = 1;
        
        NSString *url = [NSString stringWithFormat:kScan,weakSelf.currentPage];
        [weakSelf parserInfo:url isRefresh:YES];
        
    }];
    //上拉加载更多
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //重新下载数据
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;//标记正在刷新
        weakSelf.currentPage ++;//页码加1
        NSString *url = [NSString stringWithFormat:kScan,weakSelf.currentPage];
        [weakSelf parserInfo:url isRefresh:YES];
    }];
}

- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;//标记刷新结束
        //正在刷新 就结束刷新
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
}

-(void)parserInfo:(NSString *)url isRefresh:(BOOL)isRefresh{
    
    
    //弱引用指针 防止 block 中 两个强引用 导致死锁而内存泄露
    __weak typeof(self) weakSelf = self;
    
//    //下载之前 设置特效
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
//    //设置 标题
//    [MMProgressHUD showWithTitle:@"下载应用" status:@"loading...."];
//    //下载完成 、失败 要关闭特效
//    
//    //加上缓存,有些时候我们的app界面 希望在离线情况下，浏览一页以前的数据，这时我们可以对这个界面把第一页数据做本地存储(不同需求做好可能一样)，这样的话可以节省流量，提高用户体验。
//    //走本地满足3个条件 1.缓存文件存在2.不是刷新 3.没有超时
//    
//    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:[SQHelper getFullPathWithFile:url]];
//    //文件是否超时 1小时
//    BOOL isTimerOut = [SQHelper isTimeOutWithFile:[SQHelper getFullPathWithFile:url] timeOut:60*60];
//    if ((isExist == YES)&&(isRefresh == NO)&&(isTimerOut == NO)) {
//        //满足三个条件走本地
//        
//        //读缓存
//        NSData *data = [NSData dataWithContentsOfFile:[SQHelper getFullPathWithFile:url]];
//        //json 解析
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSDictionary *dataDic = dic[@"data"];
//        NSDictionary *itemsDic = dataDic[@"featured_items"];
//        NSMutableArray *ary = itemsDic[@"items"];
//        for (NSDictionary *appDict in ary) {
//           ScanModel *model = [[ScanModel alloc] init];
//            //kvc 赋值
//            [model setValuesForKeysWithDictionary:appDict];
//            [weakSelf.dataAry addObject:model];
//        }
//        //数据源数组变了 刷新表格
//        [weakSelf.tableView reloadData];
//        //关闭下载特效
//        [MMProgressHUD dismissWithSuccess:@"ok" title:@"下载本地数据完成"];
//        return;
//    }

    
   // __weak typeof(self) weakSelf = self;
    
    //显示 下载 特效
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingLeft];
    [MMProgressHUD showWithTitle:@"下载数据" status:@"Loading...."];
    
//    weakSelf.dataAry = [[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            DDLog(@"解析成功");
 //           weakSelf.dataAry = [[NSMutableArray alloc]init];

            
            //            if(weakSelf.currentPage == 1) {
//                [weakSelf.dataAry removeAllObjects];
//                //只缓存 第一页数据 保存到本地
//                //普通文件缓存
//                [[NSFileManager defaultManager] createFileAtPath:[SQHelper getFullPathWithFile:url] contents:responseObject attributes:nil];
//            }
            
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic = dic[@"data"];
            NSDictionary *itemsDic = dataDic[@"featured_items"];
            NSMutableArray *ary = itemsDic[@"items"];
            for (NSDictionary *dic2 in ary) {
                ScanModel *model = [[ScanModel alloc] init];
                [model setValuesForKeysWithDictionary:dic2];
                [weakSelf.dataAry addObject:model];
            }
            [_tableView reloadData];
            [weakSelf endRefreshing];
            //下载完成 之后 要把 特效 取消 否则 不会自动取消
            [MMProgressHUD dismissWithSuccess:@"下载数据" title:@"OK"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLog(@"解析失败");
        [weakSelf endRefreshing];
        [MMProgressHUD dismissWithError:@"Error" title:@"下载数据"];
    }];
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorColor:[UIColor grayColor]];
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"ScanCell" bundle:nil] forCellReuseIdentifier:@"ScanCell"];
    [_tableView registerClass:[ScanCellTop class] forCellReuseIdentifier:@"ScanCellTop"];
}

#pragma UITableViewDataSource && UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        ScanCellTop *cell = [tableView dequeueReusableCellWithIdentifier:@"ScanCellTop" forIndexPath:indexPath];
        [cell createImageView];
        return cell;
    }else{
        ScanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScanCell" forIndexPath:indexPath];
        ScanModel *model = self.dataAry[indexPath.row];
//                                  cell之间的分割线宽度
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 10)];
//        view.backgroundColor = [UIColor colorWithRed:165.0/255 green:165.0/255 blue:165.0/255 alpha:1.0];
//        [cell addSubview:view];
        
        [cell showDataWithModel:model];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ? 190 : 300;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
