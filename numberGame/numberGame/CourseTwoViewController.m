//
//  CourseTwoViewController.m
//  numberGame
//
//  Created by Etong on 16/7/27.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "CourseTwoViewController.h"
#import "CourseThrViewController.h"
#import "CourseImageView.h"

@interface CourseTwoViewController ()

@property(nonatomic) CourseImageView *imageView;

@end

@implementation CourseTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏push跳转后的返回按钮
    self.navigationItem.hidesBackButton = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNumber:) name:@"clickWho" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(heightLight) name:@"heightLight" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCtrl:) name:@"pushCtrl" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeImageView) name:@"removeImageView" object:nil];
    
    _imageView = [[CourseImageView alloc]initWithFrame:@"真棒!看看这个吧。" Btn:@"出发"];
    [self.view addSubview:_imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"who":@2};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"whoCtrl" object:nil userInfo:dic];
}

- (void)removeImageView {
    [_imageView removeFromSuperview];
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
    if ([note.userInfo[@"lv"]intValue] == 2) {
        CourseThrViewController *CourseTwo = [Utilities getStoryboardInstanceByIdentity:@"Main" byIdentity:@"CourseThr"];
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

@end
