//
//  EndViewController.m
//  numberGame
//
//  Created by Etong on 16/7/25.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "EndViewController.h"

@interface EndViewController ()

@end

@implementation EndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"navBack"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:170.f/255.f green:242.f/255.f blue:242.f/255.f alpha:1];
    
    _levelLab.text = _level;
    _scoreLab.text = _score;
}

- (void)backAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
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

- (IBAction)onceAgainAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
