//
//  HJWTableDelegate.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/6.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "HJWTableDelegate.h"
#import "BaseModel.h"
#import "HJWBaseTableHeadOrFootView.h"
@interface HJWTableDelegate ()
{
    HJWTableDelegateBlock _hjwTableDelegateBlock;//回调
    BOOL _isTwoDimension;//是否是二维, 这里只支持一二维
    
}
@end

//这里用来区分用户一开始有没有设置高度值
static const CGFloat baseHeadOrFootHeight = -1.f;
static const CGFloat baseRowHeight = -1.f;

@implementation HJWTableDelegate
- (instancetype)initWithDataArr:(NSMutableArray *)dataArr WithTable:(UITableView *)table WithIsTwoDimension:(BOOL)isTwoDimension configureCellBlock:(HJWTableDelegateBlock)tableDelegateBlock;{
    if (self = [super init]) {
        _dataArr = dataArr;
        _hjwTableDelegateBlock = tableDelegateBlock;
        _footHeight = baseHeadOrFootHeight;
        _headHeight = baseHeadOrFootHeight;
        _cellHeight = baseRowHeight;
        _isTwoDimension = isTwoDimension;
        _table = table;
        
    }
    return self;
}

#pragma mark - 下拉刷新
- (void)dropDownRefreshDataBlock:(void (^)(void))dropDownBlock
{
    WeakObj(self);
    self.table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([selfWeak.table.mj_footer isRefreshing]) {
            [selfWeak.table.mj_footer endRefreshing];//这里只是模拟
            [selfWeak.table.mj_header endRefreshing];
            return;
        }
        //block传出去获取详情列表
        dropDownBlock();
    }];
    [self.table.mj_header beginRefreshing];//手动吊起加载
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.table.mj_header.automaticallyChangeAlpha = YES;
}

#pragma  mark -上拉加载获取数据
-(void)pullUpLoadingMoreData:(void (^)(void))pullUpBlock
{
    WeakObj(self);
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if ([selfWeak.table.mj_header isRefreshing]) {
            [selfWeak.table.mj_header endRefreshing];//这里只是模拟
            [selfWeak.table.mj_footer endRefreshing];
            return;
        }
        pullUpBlock();
    }];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;{
    if (_isTwoDimension){
        NSArray *subArr = _dataArr[(NSInteger)indexPath.section];
        return subArr[indexPath.row];
    }
    return _dataArr[(NSInteger)indexPath.row];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _hjwTableDelegateBlock([self itemAtIndexPath:indexPath], indexPath);
}

//#if automaticDimension
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //自动段行高
    if (_automaticDimension) {
        NSString *key = [NSString stringWithFormat:@"%ld-%ld",indexPath.section, indexPath.row];
        NSNumber *height = [self.cellHeightsDictionary objectForKey:key];
        if (height) return height.doubleValue;
        return UITableViewAutomaticDimension;
    }
    //model里面的行高
    else if (self.cellHeight <= baseRowHeight) {
        id model = nil;
        if (_isTwoDimension){
            NSArray *subArr = _dataArr[(NSInteger)indexPath.section];
            model = subArr[indexPath.row];
        }else{
            model = _dataArr[indexPath.row];
        }
        if ([model isKindOfClass:[BaseModel class]]) {
            BaseModel *m = (BaseModel*)model;
            return m.cellHight;
        }else{
            return 50;
        }
    }else{
        //默认的行高
        return _cellHeight;
    }
}
//#endif

// save height
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.automaticDimension) {//只有自动计算高度的时候才要缓存
        NSString *key = [NSString stringWithFormat:@"%ld-%ld",indexPath.section, indexPath.row];
        [self.cellHeightsDictionary setObject:@(cell.frame.size.height) forKey:key];
    }
}
//估高
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //自动段行高
    if (_automaticDimension) {
        NSString *key = [NSString stringWithFormat:@"%ld-%ld",indexPath.section, indexPath.row];
        NSNumber *height = [self.cellHeightsDictionary objectForKey:key];
        if (height) return height.doubleValue;
        return UITableViewAutomaticDimension;
    }
    //model里面的行高
    else if (self.cellHeight <= baseRowHeight) {
        id model = nil;
        if (_isTwoDimension){
            NSArray *subArr = _dataArr[(NSInteger)indexPath.section];
            model = subArr[indexPath.row];
        }else{
            model = _dataArr[indexPath.row];
        }
        if ([model isKindOfClass:[BaseModel class]]) {
            BaseModel *m = (BaseModel*)model;
            return m.cellHight;
        }else{
            return 50;
        }
    }else{
        //默认的行高
        return _cellHeight;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footViews[section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.footHeight > baseHeadOrFootHeight) {
        return self.footHeight;
    }
    else{
        if (self.footViews.count > 0)
        {
            HJWBaseTableHeadOrFootView *view = self.footViews[section];
            return view.viewHeight;
        }else
        {
            return 0.01;
        }
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headViews[section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headHeight > baseHeadOrFootHeight) {
        return self.headHeight;
    }
    else{
        if (self.headViews.count > 0)
        {
            HJWBaseTableHeadOrFootView *view = self.headViews[section];
            return view.viewHeight;
        }else
        {
            return 0.01;
        }
    }
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

/**
 *  左滑cell时出现什么按钮
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    NSMutableArray *arr = [@[] mutableCopy];
    NSInteger i = 0;
    for (NSString *str in self.editActionsTitleArr) {
        UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:str handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击%@", str);
            // 收回左滑出现的按钮(退出编辑模式)
            tableView.editing = NO;
            !weakSelf.hjwEditActionsBlock ? : weakSelf.hjwEditActionsBlock([weakSelf itemAtIndexPath:indexPath], indexPath, i);
        }];
        action0.backgroundColor = self.editActionsColorArr[i];
        [arr addObject:action0];
        i++;
    }
    return arr;
}

#pragma mark - 设置是否可以自动刷新
-(void)setAutomaticDimension:(BOOL)automaticDimension{
    _automaticDimension = automaticDimension;
    //这里不能设置为0 ,为就默认为是关闭, 所以,不管怎么样就直接不要为0
    if (automaticDimension) {
        self.table.estimatedRowHeight = 50;
        self.table.estimatedSectionFooterHeight = 0;
        self.table.estimatedSectionHeaderHeight=0;
        self.table.rowHeight = UITableViewAutomaticDimension;
        _cellHeightsDictionary = @{}.mutableCopy;
    }else{
        self.table.estimatedRowHeight = 0;
        self.table.estimatedSectionFooterHeight = 0;
        self.table.estimatedSectionHeaderHeight = 0;
        
    }
}
@end
