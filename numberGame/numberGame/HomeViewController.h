//
//  HomeViewController.h
//  numberGame
//
//  Created by Etong on 16/7/22.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

- (IBAction)preaseAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *clickNumLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

@end
