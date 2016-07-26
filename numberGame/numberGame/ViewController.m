//
//  ViewController.m
//  numberGame
//
//  Created by Etong on 16/7/22.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "ViewController.h"
#import "RankingViewController.h"
#import "SettingViewController.h"
#import "HomeViewController.h"
#import <POP.h>

@interface ViewController (){
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self createSpringAnimation:_titleLab];
    [self startButAction];
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(startButAction) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timer invalidate];
}

- (void)startButAction {
    [self createSpringAnimation:_startBut];
}

//创建弹跳动画
- (void)createSpringAnimation:(UIView *)view {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(0.6, 0.6)];
    //设置弹簧的震动幅度（弹簧来回震动的摆动幅度)
    anim.springBounciness = 20;
    //设置弹簧的弹性系数（弹簧来回震动速度的快慢）
    anim.springSpeed = 10;
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

#pragma CATransition动画实现
- (void)transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.7f;
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAction:(UIButton *)sender forEvent:(UIEvent *)event {
    HomeViewController *Home = [Utilities getStoryboardInstanceByIdentity:@"Main" byIdentity:@"Home"];
    //自定义跳转动画
    [self transitionWithType:@"rippleEffect" WithSubtype:kCATransitionFromLeft ForView:self.navigationController.view];
    [self.navigationController pushViewController:Home animated:YES];
}

- (IBAction)settingAction:(UIButton *)sender forEvent:(UIEvent *)event {
    SettingViewController *Setting = [Utilities getStoryboardInstanceByIdentity:@"Main" byIdentity:@"Setting"];
    [self.navigationController pushViewController:Setting animated:YES];
}

- (IBAction)rankingAction:(UIButton *)sender forEvent:(UIEvent *)event {
    RankingViewController *Ranking = [Utilities getStoryboardInstanceByIdentity:@"Main" byIdentity:@"Ranking"];
    [self.navigationController pushViewController:Ranking animated:YES];
}

- (IBAction)gameAction:(UIButton *)sender forEvent:(UIEvent *)event {
   
}
@end
