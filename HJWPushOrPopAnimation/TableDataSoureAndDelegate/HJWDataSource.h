//
//  HJWDataSource.h
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/6.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseModel.h"

typedef void (^HJWDataSourceBlock)(UITableViewCell *cell, id item, NSIndexPath *indexPath);

NS_ASSUME_NONNULL_BEGIN

@interface HJWDataSource : NSObject<UITableViewDataSource>
/***数据源*/
@property (nonatomic, strong) NSMutableArray *dataArr;
/***table*/
@property (nonatomic, strong) UITableView *table;
///***是否可以编辑的IndexPath*/
@property (nonatomic, strong) NSMutableDictionary *cantEditRowDic;
/***是否可以移动的IndexPath*/
@property (nonatomic, assign) BOOL *canMoveRow;
/***初始化*/
- (instancetype)initWithDataArr:(NSMutableArray *)dataArr WithTable:(UITableView*)table WithIsTwoDimension:(BOOL)isTwoDimension WithCellIdentifier:(id)cellIdentifie configureCellBlock:(HJWDataSourceBlock)hjwDataSourceBlock;
/***根据indexPath拿到这个传进来的内容*/
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
