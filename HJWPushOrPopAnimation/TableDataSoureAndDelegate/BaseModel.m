//
//  BaseModel.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/7.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)init{
    if (self = [super init]) {
        _cellHight = 44.0f;
    }
    return self;
}

+ (NSMutableArray *) returnModelArrWithListArr:(NSArray *)listArr;
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in listArr) {
        BaseModel *model = [self mj_objectWithKeyValues:dic];
        [arr addObject:model];
    }
    return arr;
}

@end
