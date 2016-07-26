//
//  EndViewController.h
//  numberGame
//
//  Created by Etong on 16/7/25.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndViewController : UIViewController

@property (strong, nonatomic)NSString *level;
@property (strong, nonatomic)NSString *score;;

- (IBAction)onceAgainAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

@end
