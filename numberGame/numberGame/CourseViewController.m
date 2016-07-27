//
//  CourseViewController.m
//  numberGame
//
//  Created by Etong on 16/7/27.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseTwoViewController.h"
#import <POP.h>

@interface CourseViewController ()<POPAnimationDelegate>{
    NSTimer *timer;
}

@property (strong, nonatomic)UIButton *btn;
@property (strong, nonatomic)UILabel *lab;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏push跳转后的返回按钮
    self.navigationItem.hidesBackButton = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNumber:) name:@"clickWho" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(heightLight) name:@"heightLight" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCtrl:) name:@"pushCtrl" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"who":@1};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"whoCtrl" object:nil userInfo:dic];
    
    [self addImageView];
}

- (void)addImageView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, UI_SCREEN_H)];
    imageView.image = [UIImage imageNamed:@"Screenshot"];
    imageView.userInteractionEnabled = YES;
    imageView.tag = 100;
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_W/4, UI_SCREEN_H, UI_SCREEN_W/2, 40)];
    [_btn setTitle:@"开始" forState:UIControlStateNormal];
    [_btn setTintColor:[UIColor colorWithRed:206.f/255.f green:253.f/255.f blue:251.f/255.f alpha:1]];
    _btn.backgroundColor = [UIColor colorWithRed:14.f/255.f green:145.f/255.f blue:153.f/255.f alpha:1];
    _btn.layer.cornerRadius = 5;
    _btn.layer.shadowColor = [UIColor colorWithRed:5.f/255.f green:92.f/255.f blue:112.f/255.f alpha:1].CGColor;
    _btn.layer.shadowOffset = CGSizeMake(0, 4);
    _btn.layer.shadowOpacity = YES;
    [_btn addTarget:self action:@selector(beginAction) forControlEvents:UIControlEventTouchUpInside];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_W/2 - 150, 0, 300, 20)];
    _lab.text = @"记住,数学讲究的是实事求是。";
    _lab.font = [UIFont systemFontOfSize:22];
    _lab.textColor = [UIColor colorWithRed:206.f/255.f green:253.f/255.f blue:251.f/255.f alpha:1];
    _lab.textAlignment = NSTextAlignmentCenter;
    
    [imageView addSubview:_btn];
    [imageView addSubview:_lab];
    [self.view addSubview:imageView];
    
    [self popDelegateBegin:_btn];
    [self popDelegateBegin:_lab];
}

- (void)beginAction {
    [self popMovePoint:CGRectMake(UI_SCREEN_W/2, UI_SCREEN_H + 40, UI_SCREEN_W/2, 40) labRect:CGRectMake(self.view.center.x + 10, -20, 300, 20)];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(removeImageView) userInfo:nil repeats:NO];
}

- (void)removeImageView {
    UIImageView *imageView  = [self.view viewWithTag:100];
    [imageView removeFromSuperview];
}

//签订POP协议
- (void)popDelegateBegin:(UIView *)view {
    //减速移动
    POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.delegate = self;
    [view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
}

- (void)clickNumber:(NSNotification *)note {
    _clickNumLab.text = [NSString stringWithFormat:@"%@",note.userInfo[@"number"]];
    //结束高亮
    _clickNumLab.textColor = [UIColor colorWithRed:173.f/255.f green:245.f/255.f blue:244.f/255.f alpha:1];
    _levelLab.textColor = [UIColor colorWithRed:173.f/255.f green:245.f/255.f blue:244.f/255.f alpha:1];
}

//高亮
- (void)heightLight {
    _clickNumLab.textColor = [UIColor greenColor];
    _levelLab.textColor = [UIColor greenColor];
}

- (void)pushCtrl:(NSNotification *)note {
    if ([note.userInfo[@"lv"]intValue] == 1) {
        CourseTwoViewController *CourseTwo = [Utilities getStoryboardInstanceByIdentity:@"Main" byIdentity:@"CourseTwo"];
        [self.navigationController pushViewController:CourseTwo animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
    [self popMovePoint:CGRectMake(UI_SCREEN_W/2, UI_SCREEN_H/2, UI_SCREEN_W/2, 40) labRect:CGRectMake(self.view.center.x + 10, self.view.center.y - 80, 300, 20)];
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
