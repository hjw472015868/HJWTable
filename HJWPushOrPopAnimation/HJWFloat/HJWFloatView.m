//
//  HJWFloatView.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/5.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "HJWFloatView.h"
#import "HJWPushAnimator.h"

@interface HJWFloatView ()<UINavigationControllerDelegate>
{
    CGPoint _lastPoint;//记录点击的值相对于父视图的
    CGPoint _pointInSelf;//在当前视图上的点的位置
}
@property (nonatomic, copy) NSString *controllerName;
@end

static HJWFloatView *floatView;

static CGFloat const WH = 60.f;
static CGFloat const LRMargin = 5.f;
static CGFloat const dur = 0.2;

@implementation HJWFloatView

+ (void)showWithControllerName:(NSString *)controllerName{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatView = [[HJWFloatView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-WH-LRMargin, [UIScreen mainScreen].bounds.size.height-100, WH, WH)];
    });
    
    floatView.alpha = 1.f;
    //添加在keywindow层, 因为他只有一个
    if (!floatView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:floatView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:floatView];
    }
    floatView.controllerName = controllerName;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //给view赋值图片
        self.layer.contents = (__bridge id)[UIImage imageNamed:@"ic_copy_link"].CGImage;
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = WH/2;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:dur];
//        self.alpha = 0.3;
    }
    return self;
}


//用touch的三个事件,  开始先拖动
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    _lastPoint = [touch locationInView:self.superview];
    _pointInSelf = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    //计算出floatView的center的坐标,相对于他的父视图, 这里是keywindow
    CGFloat centerX = currentPoint.x + (self.frame.size.width/2 - _pointInSelf.x);
    CGFloat centerY = currentPoint.y + (self.frame.size.height/2 - _pointInSelf.y);
    
    //限制center坐标的范围, 不超过屏幕
    CGFloat x = MAX(WH/2+LRMargin, MIN([UIScreen mainScreen].bounds.size.width-WH/2-LRMargin, centerX));
    CGFloat y = MAX(WH/2+LRMargin, MIN([UIScreen mainScreen].bounds.size.height-WH/2-LRMargin, centerY));
    self.center = CGPointMake(x, y);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    //比较开始和结束的点击位置是否一样, 一样才算是点击, 如果不一样是拖动
    if (CGPointEqualToPoint(_lastPoint, currentPoint)) {
        //进行点击效果的跳转
        NSLog(@"点击了");
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *vc = [[NSClassFromString(self.controllerName) alloc] init];
        nav.delegate = self;
        [nav pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - 转场动画代理
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);{
    
    if(operation == UINavigationControllerOperationPush){
        HJWPushAnimator *animator = [HJWPushAnimator new];
        animator.floatFrame = self.frame;
        animator.floatCenter = self.center;
        [UIView animateWithDuration:dur animations:^{
            self.alpha = 0;
            [self removeFromSuperview];
        }];
        return animator;
    }
    
    return nil;
}


@end
