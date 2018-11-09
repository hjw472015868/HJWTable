//
//  HJWBaseTableHeadOrFootView.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/9.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "HJWBaseTableHeadOrFootView.h"

@implementation HJWBaseTableHeadOrFootView

- (instancetype)init{
    if (self = [super init]) {
        _viewHeight = 50;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _viewHeight = 50;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
