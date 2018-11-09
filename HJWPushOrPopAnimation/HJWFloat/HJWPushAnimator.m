//
//  HJWPushAnimator.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/5.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "HJWPushAnimator.h"
#import "HJWAnimatorView.h"
static CGFloat const dur = 0.2;

@interface HJWPushAnimator ()<CAAnimationDelegate>

@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation HJWPushAnimator
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
{
    return 1.f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //fromView   fromViewController  toView   toViewController   containerView
    UIView *containerView = transitionContext.containerView;
    self.transitionContext = transitionContext;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
//    [(id<protocol>(instance) message)];
    HJWAnimatorView *animatorView = [[HJWAnimatorView alloc] initWithFrame:toView.bounds];
    [containerView addSubview:animatorView];
    
    //截屏
    UIGraphicsBeginImageContext(toView.frame.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    toView.hidden = YES;
    
    //animatorView是从floatView当前的frame, 展开到toView.frame
    [animatorView startAnimateWithView:toView fromRect:self.floatFrame toRect:toView.frame floatCenter:self.floatCenter];
    
    //移除fromView   fromViewController
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dur * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:YES];
    });
}

#pragma mark -- CAAnimationDelegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    
}
@end
