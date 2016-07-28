//
//  CourseViewController.m
//  numberGame
//
//  Created by Etong on 16/7/27.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseTwoViewController.h"
#import "CourseImageView.h"

@interface CourseViewController (){
    float HW;
    BOOL imageFlag;
}

@property(nonatomic) CourseImageView *imageView;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏push跳转后的返回按钮
    self.navigationItem.hidesBackButton = YES;
    HW = (UI_SCREEN_W - 120)/4;
    imageFlag = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNumber:) name:@"clickWho" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(heightLight) name:@"heightLight" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCtrl:) name:@"pushCtrl" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeImageView) name:@"removeImageView" object:nil];
    
    _imageView = [[CourseImageView alloc]initWithFrame:@"记住,数学讲究的是实事求是。" Btn:@"开始"];
    [self.view addSubview:_imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"who":@1};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"whoCtrl" object:nil userInfo:dic];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    imageFlag = YES;
}


- (void)removeImageView {
    if (imageFlag) {
        imageFlag = NO;
        [_imageView removeFromSuperview];
        NSDictionary *dict = @{@"whoNum":@1};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"optionHand" object:nil userInfo:dict];
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
@end
