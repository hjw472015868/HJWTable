//
//  BaseModel.h
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/7.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

/***基础高度*/
@property (nonatomic, assign) CGFloat cellHight;

/***是否可以编辑*/
@property (nonatomic, assign) BOOL canEdite;

+ (NSMutableArray *) returnModelArrWithListArr:(NSArray *)listArr;

@end

NS_ASSUME_NONNULL_END
