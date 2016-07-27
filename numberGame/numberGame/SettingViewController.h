//
//  SettingViewController.h
//  numberGame
//
//  Created by Etong on 16/7/22.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
- (IBAction)onMusicAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)backMusicAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)loginGoogleAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)CourseAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UIButton *musicBut;
@property (weak, nonatomic) IBOutlet UIButton *backMusicBut;


@end
