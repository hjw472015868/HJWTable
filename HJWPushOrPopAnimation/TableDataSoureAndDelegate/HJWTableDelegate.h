//
//  HJWTableDelegate.h
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/6.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^HJWTableDelegateBlock)(id item, NSIndexPath *indexPath);

/***
 item 数组中的元素
 indexPath 当前点击的indexpath
 index 当前点击的是第几个, 从又右往左
 */
typedef void(^HJWEditActionsBlock)(id item, NSIndexPath* indexPath, NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface HJWTableDelegate : NSObject<UITableViewDelegate>
/***是否自动算高*/
@property (nonatomic, assign) BOOL automaticDimension;//自动算行高
/***行高*/
@property (nonatomic, assign) CGFloat cellHeight;
/***头部视图高度*/
@property (nonatomic, assign) CGFloat headHeight;
/***尾部视图高度*/
@property (nonatomic, assign) CGFloat footHeight;
/***头部视图数组*/
@property (nonatomic, strong) NSArray *headViews;
/***尾部视图数组*/
@property (nonatomic, strong) NSArray *footViews;
/***数据源*/
@property (nonatomic, strong) NSArray *dataArr;
/***table*/
@property (nonatomic, strong) UITableView *table;
/***左滑的title的数据源*/
@property (nonatomic, strong) NSArray *editActionsTitleArr;
/***左滑的title的背景颜色*/
@property (nonatomic, strong) NSArray *editActionsColorArr;
/***左滑出来的cell的编辑的操作*/
@property (nonatomic, copy) HJWEditActionsBlock hjwEditActionsBlock;
/***cell高度的缓存*/
@property (nonatomic, strong) NSMutableDictionary *cellHeightsDictionary;

/****/
/***初始化
 dataArr数据源
 isTwoDimension是否是d2维数组
 tableDelegateBlock 回调
 automaticDimension 是否自动算行高
 */
- (instancetype)initWithDataArr:(NSArray *)dataArr WithTable:(UITableView *)table WithIsTwoDimension:(BOOL)isTwoDimension configureCellBlock:(HJWTableDelegateBlock)tableDelegateBlock;
/***根据indexPath拿到这个传进来的内容*/
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
