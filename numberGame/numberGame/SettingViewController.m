//
//  SettingViewController.m
//  numberGame
//
//  Created by Etong on 16/7/22.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "SettingViewController.h"
#import "CourseViewController.h"

@interface SettingViewController (){
    bool music;
    bool backMusic;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    music = NO;
    backMusic = NO;
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"navBack"];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"setting"]];
    image.frame = CGRectMake(0, 0, 40, 40);
    image.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = image;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:170.f/255.f green:242.f/255.f blue:242.f/255.f alpha:1];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"序幕" style:UIBarButtonItemStyleDone target:self action:@selector(moveAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:170.f/255.f green:242.f/255.f blue:242.f/255.f alpha:1];

}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)moveAction {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onMusicAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if (music == NO) {
        [_musicBut setTitleColor:[UIColor colorWithRed:135.f/255.f green:225.f/255.f blue:0.f/255.f alpha:1] forState:UIControlStateNormal];
        music = YES;
    }else{
        [_musicBut setTitleColor:[UIColor colorWithRed:171.f/255.f green:241.f/255.f blue:241.f/255.f alpha:1] forState:UIControlStateNormal];
        music = NO;
    }
}

- (IBAction)backMusicAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if (backMusic == NO) {
        [_backMusicBut setTitleColor:[UIColor colorWithRed:135.f/255.f green:225.f/255.f blue:0.f/255.f alpha:1] forState:UIControlStateNormal];
        backMusic = YES;
    }else{
        [_backMusicBut setTitleColor:[UIColor colorWithRed:171.f/255.f green:241.f/255.f blue:241.f/255.f alpha:1] forState:UIControlStateNormal];
        backMusic = NO;
    }
}

- (IBAction)loginGoogleAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)CourseAction:(UIButton *)sender forEvent:(UIEvent *)event {
    CourseViewController *Coures = [Utilities getStoryboardInstanceByIdentity:@"Main" byIdentity:@"Coures"];
    [self.navigationController pushViewController:Coures animated:NO];
}
@end
