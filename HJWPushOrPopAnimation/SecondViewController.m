//
//  SecondViewController.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/5.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "SecondViewController.h"
#import "TableDataSoureAndDelegate/HJWDataSource.h"
#import "TableDataSoureAndDelegate/HJWTableDelegate.h"
#import "SecondVCModel.h"

@interface SecondViewController ()
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) HJWDataSource *dataSource;
@property (nonatomic, strong) HJWTableDelegate *tableDelegate;
@property (nonatomic, strong) NSMutableArray *headViews;
@property (nonatomic, strong) NSMutableArray *footViews;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *namearr;
@end

@implementation SecondViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _namearr = @[@{@"name":@"张三@property (nonatomic, strong) NSMutableArray *dataArr;@property (nonatomic, strong) NSMutableArray *dataArr;@property (nonatomic, strong) NSMutableArray *dataArr;"},@{@"name":@"李四"},@{@"name":@"123456789123456789234567892345678904567890"}];
        _dataArr = [NSMutableArray array];
        [_dataArr addObjectsFromArray:[SecondVCModel returnModelArrWithListArr:_namearr]];
    }
    return _dataArr;
}

-(NSMutableArray *)headViews{
    if (!_headViews) {
        _headViews = [@[] mutableCopy];
        for (NSInteger i=0; i<self.dataArr.count; i++) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
            UILabel *lab = [[UILabel alloc] initWithFrame:v.bounds];
            lab.text = @"我是头部视图";
            v.backgroundColor = [UIColor purpleColor];
            [_headViews addObject:v];
        }
    }
    return _headViews;
}
-(NSMutableArray *)footViews{
    if (!_headViews) {
        _footViews = [@[] mutableCopy];
        for (NSInteger i=0; i<self.dataArr.count; i++) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
            UILabel *lab = [[UILabel alloc] initWithFrame:v.bounds];
            lab.text = @"我是尾部视图";
            v.backgroundColor = [UIColor orangeColor];
            [_footViews addObject:v];
        }
    }
    return _footViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"second";
    [self createTable];
    [self dropDownRefreshData];
    [self pullUpLoadingMoreData];
}

- (void)createTable{
    UITableView *table = [HjwUI createTableWithFrame:self.view.bounds WithStyle:UITableViewStyleGrouped];
    self.table = table;
    self.table.backgroundColor = [UIColor yellowColor];
    //指定代理, 这是核心代码, 就这两句, 其他的要不要都是可以的
    table.dataSource = self.dataSource;
    table.delegate = self.tableDelegate;
    //开启是否自适应cell高度
    self.tableDelegate.automaticDimension = YES;

    //这是设置左滑的显示, 不设置就不能能左滑, 就这么简单
    self.tableDelegate.editActionsTitleArr = @[@"删除", @"置顶", @"添加"];
    self.tableDelegate.editActionsColorArr = @[[UIColor orangeColor], [UIColor redColor], [UIColor blueColor]];
    
    //下面这些头部尾部的东西, 有就设置, 没有就不设置
    self.tableDelegate.headHeight = 60;//设置头部视图高度
    self.tableDelegate.footViews = self.footViews;//设置头部视图
    self.tableDelegate.footHeight = 30;//设置尾部视图高
    self.tableDelegate.headViews = self.headViews;//设置尾部视图
    [self.view addSubview:table];
    
    //这里是左滑cell之后的一些回调,
    __weak typeof(self) weakSelf = self;
    self.tableDelegate.hjwEditActionsBlock = ^(id item, NSIndexPath *indexPath, NSInteger index) {
        NSLog(@"item = %@\nindexPath = (%ld,%ld)\nindex = %ld\n",(SecondVCModel *)item, indexPath.section,indexPath.row, index);
        switch (index) {//这里是根据数组的内容来的, 自己看
            case 0://删除
            {
                //置顶的时候这里需要删除indexPath的高度
//                NSString *fromkey = [NSString stringWithFormat:@"%ld-%ld",indexPath.section, indexPath.row];
//                [weakSelf.tableDelegate.cellHeightsDictionary removeObjectForKey:fromkey];
                NSArray *keys = weakSelf.tableDelegate.cellHeightsDictionary.allKeys;
                [weakSelf.tableDelegate.cellHeightsDictionary removeObjectsForKeys:keys];
                [weakSelf.dataArr removeObjectAtIndex:indexPath.row];
                [weakSelf.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
                break;
            case 1://置顶
            {
                //置顶的时候这里需要删除indexPath的高度
//                NSString *fromkey = [NSString stringWithFormat:@"%ld-%ld",indexPath.section, indexPath.row];
//                [weakSelf.tableDelegate.cellHeightsDictionary removeObjectForKey:fromkey];
//
//                NSString *secondkey = @"0-1";
//                [weakSelf.tableDelegate.cellHeightsDictionary removeObjectForKey:secondkey];
//
//                NSString *tokey = @"0-0";
//                [weakSelf.tableDelegate.cellHeightsDictionary removeObjectForKey:tokey];
//
//                for (NSString *key in weakSelf.tableDelegate.cellHeightsDictionary) {
//                    [weakSelf.tableDelegate.cellHeightsDictionary removeObjectForKey:key];
//                }
                NSArray *keys = weakSelf.tableDelegate.cellHeightsDictionary.allKeys;
                [weakSelf.tableDelegate.cellHeightsDictionary removeObjectsForKeys:keys];
                [weakSelf.dataArr removeObject:item];
                [weakSelf.dataArr insertObject:item atIndex:0];
                [weakSelf.table reloadData];
            }
                break;
            case 2://添加
            {
                NSDictionary *dic = weakSelf.namearr[arc4random_uniform(3)];
                SecondVCModel *model = [SecondVCModel mj_objectWithKeyValues:dic];
                [weakSelf.dataArr addObject:model];
                [weakSelf.table reloadData];
            }
                break;
            default:
                break;
        }
    };
}

-(HJWDataSource *)dataSource{
    if (!_dataSource) {
        _dataSource = [[HJWDataSource alloc] initWithDataArr:self.dataArr WithTable:self.table WithIsTwoDimension:NO cellIdentifier:@"xx" configureCellBlock:^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
            NSLog(@"%@",item);
            cell.textLabel.numberOfLines = 0;
            indexPath.row%2 ? (cell.textLabel.textColor = [UIColor purpleColor]) : (cell.textLabel.textColor = [UIColor orangeColor]);
            cell.textLabel.text = ((SecondVCModel *)item).name;
        }];
    }
    return _dataSource;
}

-(HJWTableDelegate *)tableDelegate{
    if (!_tableDelegate) {
        //二维
        __weak typeof(self) weakSelf = self;
        _tableDelegate = [[HJWTableDelegate alloc] initWithDataArr:self.dataArr WithTable:self.table WithIsTwoDimension:NO configureCellBlock:^(id item, NSIndexPath *indexPath) {
            NSLog(@"点击的是%ld-%ld", indexPath.section, indexPath.row);
            NSDictionary *dic = weakSelf.namearr[arc4random_uniform(3)];
            SecondVCModel *model = [SecondVCModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArr addObject:model];
            [weakSelf.table reloadData];
        }];

    }
    return _tableDelegate;
}

-(void)dealloc{
    NSLog(@"释放");
}

#pragma mark - 下拉刷新
- (void)dropDownRefreshData
{
    WeakObj(self);
    self.table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([selfWeak.table.mj_footer isRefreshing]) {
            [selfWeak.table.mj_footer endRefreshing];
            [selfWeak.table.mj_header endRefreshing];
            return;
        }
        //获取详情列表
        [selfWeak.table reloadData];
//        selfWeak.pageCount = 1;
//        [selfWeak requestForFlash];
    }];
    [self.table.mj_header beginRefreshing];//手动吊起加载
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.table.mj_header.automaticallyChangeAlpha = YES;
}

#pragma  mark -上拉加载获取数据
-(void)pullUpLoadingMoreData
{
    WeakObj(self);
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if ([selfWeak.table.mj_header isRefreshing]) {
            [selfWeak.table.mj_header endRefreshing];
            [selfWeak.table.mj_footer endRefreshing];
            return;
        }
        [selfWeak.table reloadData];
//        [selfWeak requestForFlash];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
