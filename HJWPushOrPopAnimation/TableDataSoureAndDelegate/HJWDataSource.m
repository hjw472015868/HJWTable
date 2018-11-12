//
//  HJWDataSource.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/6.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "HJWDataSource.h"

@interface HJWDataSource ()
{
    id    _cellIdentifier;//cellid
    HJWDataSourceBlock _hjwDataSourceBlock;//回调block
    BOOL _isTwoDimension;//是否是二维, 这里只支持一二维
    BOOL _isMoreCell;//判断是不是多个不同的cell
}
@end

@implementation HJWDataSource


- (instancetype)initWithDataArr:(NSMutableArray *)dataArr WithTable:(UITableView*)table WithIsTwoDimension:(BOOL)isTwoDimension WithCellIdentifier:(id)cellIdentifie configureCellBlock:(HJWDataSourceBlock)hjwDataSourceBlock;{
    self = [super init];
    if (self) {
        _dataArr = dataArr;
        _cellIdentifier = cellIdentifie;
        if ([cellIdentifie isKindOfClass:[NSArray class]]) {
            _isMoreCell = YES;
        }
        _hjwDataSourceBlock = hjwDataSourceBlock;
        _isTwoDimension = isTwoDimension;
        _table = table;
    }
    return self;
}
//-(void)setDataArr:(NSArray *)dataArr{
//    _dataArr = dataArr;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.table reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
//    });
//
//}
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isTwoDimension){
        NSArray *subArr = _dataArr[(NSInteger)indexPath.section];
        return subArr[indexPath.row];
    }
    return _dataArr[(NSInteger)indexPath.row];
}

#pragma mark tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  _isTwoDimension ? _dataArr.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isTwoDimension) {
        NSArray *subArr = _dataArr[section];
        return [subArr count];
    }
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = nil;
    if (_isMoreCell) {
        NSArray *arr = (NSArray *)_cellIdentifier;
        cellIdentifier = arr[indexPath.section];
    }else{
        cellIdentifier = (NSString *)_cellIdentifier;
    }
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    id item = [self itemAtIndexPath:indexPath];
    _hjwDataSourceBlock(cell, item, indexPath);
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //先以model里面的为主
    id item = [self itemAtIndexPath:indexPath];
    if ([item isKindOfClass:[BaseModel class]]) {
        BaseModel *model = (BaseModel *)item;
        return model.canEdite;
    }//如果字典里面没有就代表可以编辑
    else if (_cantEditRowDic) {
        NSString *key = [NSString stringWithFormat:@"%ld-%ld",indexPath.section, indexPath.row];
        if (_cantEditRowDic[key]) {
            return NO;
        }else{
            return YES;
        }
    }
    return !self.canMoveRow;
}



@end
