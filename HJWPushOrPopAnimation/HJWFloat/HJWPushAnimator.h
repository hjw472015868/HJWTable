//
//  HJWPushAnimator.h
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/5.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface HJWPushAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect floatFrame;

@property (nonatomic, assign) CGPoint floatCenter;

@end

NS_ASSUME_NONNULL_END
