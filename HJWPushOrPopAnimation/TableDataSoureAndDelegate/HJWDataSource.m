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
    NSString    *_cellIdentifier;//cellid
    HJWDataSourceBlock _hjwDataSourceBlock;//回调block
    BOOL _isTwoDimension;//是否是二维, 这里只支持一二维
}
@end

@implementation HJWDataSource


- (instancetype)initWithDataArr:(NSArray *)dataArr WithTable:(UITableView*)table WithIsTwoDimension:(BOOL)isTwoDimension cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(HJWDataSourceBlock)hjwDataSourceBlock;{
    self = [super init];
    if (self) {
        _dataArr = dataArr;
        _cellIdentifier = aCellIdentifier;
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
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    id item = [self itemAtIndexPath:indexPath];
    _hjwDataSourceBlock(cell, item, indexPath);
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里暂时控制的是所有的cell, 并没做单独indexpathh处理, 自己写吧
    return !self.canMoveRow;
}

//- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    id item = nil;
//    if (_isTwoDimension) {
//        item = self.dataArr[indexPath.section][indexPath.row];
//        [self.dataArr[indexPath.section] removeObject:item];
//    }else{
//        item = self.dataArr[indexPath.row];
//        [self.dataArr removeObject:item];
//    }
//    [self.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//}



@end
