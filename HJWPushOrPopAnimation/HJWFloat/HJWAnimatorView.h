//
//  HJWAnimatorView.h
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/5.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJWAnimatorView : UIImageView

- (void)startAnimateWithView:(UIView *)toView  fromRect:(CGRect)fromRect toRect:(CGRect)toRect floatCenter:(CGPoint)floatCenter;

@end

NS_ASSUME_NONNULL_END
