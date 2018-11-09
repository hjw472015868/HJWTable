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

@property (nonatomic, assign) CGFloat cellHight;

+ (NSMutableArray *) returnModelArrWithListArr:(NSArray *)listArr;

@end

NS_ASSUME_NONNULL_END
