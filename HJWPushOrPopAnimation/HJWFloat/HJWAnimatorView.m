//
//  HJWAnimatorView.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/5.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "HJWAnimatorView.h"

@interface HJWAnimatorView ()<CAAnimationDelegate>
{
    CAShapeLayer *_shapeLayer;
    UIView *_toView;
}
@end

@implementation HJWAnimatorView

- (void)startAnimateWithView:(UIView *)toView fromRect:(CGRect)fromRect toRect:(CGRect)toRect floatCenter:(CGPoint)floatCenter{
    
    _toView = toView;
    
    //作为一个mask来自操作
    //和floatView大小一致的mask
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30.f].CGPath;
    self.layer.mask = _shapeLayer;
    
    //绘制圆形
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:fromRect];
    //创建两个圆形的 UIBezierPath 实例；一个是 button 的 size ，另外一个则拥有足够覆盖屏幕的半径。最终的动画则是在这两个贝塞尔路径之间进行的
    //按钮中心离屏幕最远的那个角的点
    CGPoint finalPoint;
    //判断触发点在那个象限
    if(fromRect.origin.x > (toView.bounds.size.width / 2)){
        if (fromRect.origin.y < (toView.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPointMake(0, CGRectGetMaxY(toView.frame));
        }else{
            //第四象限
            finalPoint = CGPointMake(0, 0);
        }
    }else{
        if (fromRect.origin.y < (toView.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(CGRectGetMaxX(toView.frame), CGRectGetMaxY(toView.frame));
        }else{
            //第三象限
            finalPoint = CGPointMake(CGRectGetMaxX(toView.frame), 0);
        }
    }
    
    CGPoint startPoint = floatCenter;
    //计算向外扩散的半径 = 按钮中心离屏幕最远的那个角距离 - 按钮半径
    CGFloat radius = sqrt((finalPoint.x-startPoint.x) * (finalPoint.x-startPoint.x) + (finalPoint.y-startPoint.y) * (finalPoint.y-startPoint.y)) - sqrt(fromRect.size.width/2 * fromRect.size.width/2 + fromRect.size.height/2 * fromRect.size.height/2);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(fromRect, -radius, -radius)];
    
    
    //执行动画
    //绘制圆形
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.fromValue = (__bridge id)startPath.CGPath;
    anim.toValue = (__bridge id)endPath.CGPath;
    anim.duration = 0.2f;
    //下面两句接和起来是动画结束后回到原来的状态
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [_shapeLayer addAnimation:anim forKey:nil];
    
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _toView.hidden = NO;
    [_shapeLayer removeFromSuperlayer];
    _shapeLayer = nil;
    [self removeFromSuperview];
    
    
}
-(void)dealloc{
    NSLog(@"销毁");
}
@end
