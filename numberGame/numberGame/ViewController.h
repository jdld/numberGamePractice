//
//  ViewController.h
//  numberGame
//
//  Created by Etong on 16/7/22.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)playAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)settingAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)rankingAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)gameAction:(UIButton *)sender forEvent:(UIEvent *)event;


@property (weak, nonatomic) IBOutlet UIButton *startBut;
@property (weak, nonatomic) IBOutlet UIImageView *titleLab;

@end

