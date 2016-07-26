//
//  HomeViewController.m
//  numberGame
//
//  Created by Etong on 16/7/22.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "HomeViewController.h"
#import "EndViewController.h"
#import <POP.h>

#define UI_Drag_W [[UIScreen mainScreen] bounds].size.width/2

@interface HomeViewController ()<POPAnimationDelegate>{
    int timeCount; //总时长
    NSTimer *downTimer;
    int level;
    int editLevel;
    int score;
}
@property(nonatomic) UIControl *dragView;

@property(strong, nonatomic)UIActivityIndicatorView *avi;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNumber:) name:@"clickWho" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editLevel:) name:@"levelUp" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(heightLight) name:@"heightLight" object:nil];
    
    [self addDragView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self refreshGameData];
     downTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)refreshAnimation {
    NSDictionary *dic = @{@"flag":@0};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"createNum" object:nil userInfo:dic];
    [_dragView removeFromSuperview];
    [self addDragView];
}

//重置游戏
- (void)refreshGameData {
    level = 0;
    editLevel = 1;
    score = 0;
    timeCount = 60;//60s
    if ([[[StorageMgr singletonStorageMgr]objectForKey:@"level"]intValue] != 1) {
        [[StorageMgr singletonStorageMgr]removeObjectForKey:@"level"];
        [[StorageMgr singletonStorageMgr]addKey:@"level" andValue:@1];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:nil];
    _scoreLab.text = @"0";
    _levelLab.text = @"1";
    [self refreshAnimation];
}

//成功完成一关
- (void)editLevel:(NSNotification *)i {
    editLevel = level + [i.userInfo[@"i"]intValue];
    _levelLab.text = [NSString stringWithFormat:@"%d",editLevel];
    [[StorageMgr singletonStorageMgr]removeObjectForKey:@"level"];
    [[StorageMgr singletonStorageMgr]addKey:@"level" andValue:@(editLevel)];
    //分数增加
    score = score + [i.userInfo[@"i"]intValue];
    _scoreLab.text = [NSString stringWithFormat:@"%d",score];
    //时间增加
    timeCount += 6;
    [self refreshAnimation];
}

- (void)clickNumber:(NSNotification *)note {
    _clickNumLab.text = [NSString stringWithFormat:@"%@",note.userInfo[@"number"]];
    //结束高亮
    _clickNumLab.textColor = [UIColor colorWithRed:173.f/255.f green:245.f/255.f blue:244.f/255.f alpha:1];
    _levelLab.textColor = [UIColor colorWithRed:173.f/255.f green:245.f/255.f blue:244.f/255.f alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timeFireMethod {
    _timeLab.text = [NSString stringWithFormat:@"%ds",timeCount--];
    if (timeCount == -1) {
        EndViewController *End = [Utilities getStoryboardInstanceByIdentity:@"Main" byIdentity:@"End"];
        End.level = [NSString stringWithFormat:@"%d",editLevel];
        End.score = [NSString stringWithFormat:@"%d 分",score];
        [self.navigationController pushViewController:End animated:YES];
        [downTimer invalidate];
    }
}

- (void)heightLight {
    _clickNumLab.textColor = [UIColor greenColor];
    _levelLab.textColor = [UIColor greenColor];
}

- (IBAction)preaseAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //暂停计时器
    [downTimer setFireDate:[NSDate distantFuture]];
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"暂停"  message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //继续计时
        [downTimer setFireDate:[NSDate distantPast]];
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"新游戏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshGameData];
    }];
    UIAlertAction *Action3 = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
    [alertView addAction:Action1];
    [alertView addAction:Action2];
    [alertView addAction:Action3];
    [self presentViewController:alertView animated:YES completion:nil];
}

/*******************POP********************/
- (void)addDragView
{
    self.dragView = [[UIControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - UI_Drag_W/2, self.view.frame.size.height, UI_Drag_W, UI_Drag_W)];
    self.dragView.layer.cornerRadius = CGRectGetWidth(self.dragView.bounds)/2;
    self.dragView.backgroundColor = [UIColor colorWithRed:169.f/255.f green:241.f/255.f blue:240.f/255.f alpha:1];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UI_Drag_W, UI_Drag_W)];
    lab.text = [NSString stringWithFormat:@"%d",editLevel];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:40];
    lab.textColor = [UIColor blackColor];
    [self.dragView addSubview:lab];
    [self.view addSubview:self.dragView];
    
    //签订POP协议
    CGPoint velocity = _dragView.frame.origin;
    POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.delegate = self;
    positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    [_dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
}

#pragma mark - POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
    //将提示小球移动至中央
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.beginTime = 3.0f;
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
    [self.dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(startTwo) userInfo:nil repeats:NO];
    //创造蒙版,防止误触
    _avi = [Utilities getCoverOnView:self.view];
    //出现提示框时,暂停计时器
    [downTimer setFireDate:[NSDate distantFuture]];
}

//将提示小球移走
- (void)startTwo {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.beginTime = 3.0f;
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width/2, -120)];
    [self.dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    NSDictionary *dic = @{@"flag":@1};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"createNum" object:nil userInfo:dic];
    [_avi stopAnimating];
    //提示框移除,继续计时
    [downTimer setFireDate:[NSDate distantPast]];
}
@end
