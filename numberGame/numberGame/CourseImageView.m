//
//  CourseImageView.m
//  numberGame
//
//  Created by Etong on 16/7/27.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "CourseImageView.h"
#import <POP.h>

@interface CourseImageView()<POPAnimationDelegate>{
    NSTimer *timer;
    NSTimer *butTimer;
}

@property (strong, nonatomic)UIButton *btn;
@property (strong, nonatomic)UILabel *lab;

@end

@implementation CourseImageView


- (id)initWithFrame:(NSString *)Lab Btn:(NSString *)btn
{
    self = [super initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, UI_SCREEN_H)];
    if (self) {
        [self addImageView];
        _lab.text = Lab;
        [_btn setTitle:btn forState:UIControlStateNormal];
    }
    return self;
}

- (void)addImageView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, UI_SCREEN_H)];
    imageView.image = [UIImage imageNamed:@"Screenshot"];
    imageView.userInteractionEnabled = YES;
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_W/4, UI_SCREEN_H, UI_SCREEN_W/2, 40)];
    [_btn setTintColor:[UIColor colorWithRed:206.f/255.f green:253.f/255.f blue:251.f/255.f alpha:1]];
    _btn.backgroundColor = [UIColor colorWithRed:14.f/255.f green:145.f/255.f blue:153.f/255.f alpha:1];
    _btn.layer.cornerRadius = 5;
    _btn.layer.shadowColor = [UIColor colorWithRed:5.f/255.f green:92.f/255.f blue:112.f/255.f alpha:1].CGColor;
    _btn.layer.shadowOffset = CGSizeMake(0, 4);
    _btn.layer.shadowOpacity = YES;
    [_btn addTarget:self action:@selector(beginAction) forControlEvents:UIControlEventTouchUpInside];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_W/2 - 150, 0, 300, 60)];
    _lab.font = [UIFont systemFontOfSize:22];
    _lab.textColor = [UIColor colorWithRed:206.f/255.f green:253.f/255.f blue:251.f/255.f alpha:1];
    _lab.textAlignment = NSTextAlignmentCenter;
    _lab.numberOfLines = 0;
    
    [imageView addSubview:_btn];
    [imageView addSubview:_lab];
    [self addSubview:imageView];
    
    [self popDelegateBegin:_btn];
    [self popDelegateBegin:_lab];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addSpringAction) userInfo:nil repeats:YES];
}

- (void)addSpringAction {
    [self createSpringAnimation:_btn];
}

- (void)beginAction {
    [self popMovePoint:CGRectMake(UI_SCREEN_W/2, UI_SCREEN_H + 40, UI_SCREEN_W/2, 40) labRect:CGRectMake(self.center.x + 10, -20, 300, 20)];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(removeImageView) userInfo:nil repeats:NO];
}

- (void)removeImageView {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeImageView" object:nil];
}

//签订POP协议
- (void)popDelegateBegin:(UIView *)view {
    //减速移动
    POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.delegate = self;
    [view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
}


//创建弹跳动画
- (void)createSpringAnimation:(UIView *)view {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(0.8, 0.8)];
    //设置弹簧的震动幅度（弹簧来回震动的摆动幅度)
    anim.springBounciness = 8;
    //设置弹簧的弹性系数（弹簧来回震动速度的快慢）
    anim.springSpeed = 0.2;
    [view pop_addAnimation:anim forKey:@"springForwardAnimation"];
    //设置动画完成以后的回调
    anim.completionBlock = ^(POPAnimation *ani,BOOL finished) {
        POPBasicAnimation *basicBackwardAnimation = [POPBasicAnimation animation];
        basicBackwardAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
        basicBackwardAnimation.duration = 0.25f;
        basicBackwardAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        [view pop_addAnimation:basicBackwardAnimation forKey:@"basicBackwardAnimation"];
    };
}

// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    self.frame = CGRectMake(0, 0, UI_SCREEN_W, UI_SCREEN_H);
//}

#pragma mark - POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
    [self popMovePoint:CGRectMake(UI_SCREEN_W/2, UI_SCREEN_H/2, UI_SCREEN_W/2, 40) labRect:CGRectMake(self.center.x + 10, self.center.y - 80, 300, 20)];
}

- (void)popMovePoint:(CGRect)btnRect labRect:(CGRect)labRect {
    POPSpringAnimation *positionAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation1.beginTime = 2.0f;
    positionAnimation1.toValue = [NSValue valueWithCGRect:btnRect];
    [self.btn.layer pop_addAnimation:positionAnimation1 forKey:@"layerPositionAnimation"];
    
    POPSpringAnimation *positionAnimation2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation2.beginTime = 2.0f;
    positionAnimation2.toValue = [NSValue valueWithCGRect:labRect];
    [self.lab.layer pop_addAnimation:positionAnimation2 forKey:@"layerPositionAnimation"];
}


@end
