//
//  CourseThrViewController.m
//  numberGame
//
//  Created by Etong on 16/7/27.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "CourseThrViewController.h"
#import "CourseImageView.h"

@interface CourseThrViewController (){
    NSTimer *downTimer;
    int timeCount; //总时长
    BOOL flag;
}

@property(nonatomic) CourseImageView *imageView;

@end

@implementation CourseThrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = YES;
    timeCount = 10;
    //隐藏push跳转后的返回按钮
    self.navigationItem.hidesBackButton = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNumber:) name:@"clickWho" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(heightLight) name:@"heightLight" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCtrl:) name:@"pushCtrl" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeImageView) name:@"removeImageView" object:nil];
    
    _imageView = [[CourseImageView alloc]initWithFrame:@"非常好!现在需要计时。" Btn:@"下一步"];
    [self.view addSubview:_imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"who":@3};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"whoCtrl" object:nil userInfo:dic];
}

- (void)removeImageView {
    if (flag) {
        [_imageView removeFromSuperview];
        downTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        flag = NO;
    }else {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
}

- (void)timeFireMethod {
    _timeLab.text = [NSString stringWithFormat:@"%ds",timeCount--];
    if (timeCount < 3) {
        _timeLab.textColor = [UIColor redColor];
    }
    if (timeCount == -1) {
        [downTimer invalidate];
        _imageView = [[CourseImageView alloc]initWithFrame:@"我想你已经明白了数学的真谛。" Btn:@"没错"];
        [self.view addSubview:_imageView];
    }
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
    if ([note.userInfo[@"lv"]intValue] == 3) {
        [downTimer invalidate];
        _imageView = [[CourseImageView alloc]initWithFrame:@"我想你已经明白了数学的真谛。" Btn:@"没错"];
        [self.view addSubview:_imageView];
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

@end
