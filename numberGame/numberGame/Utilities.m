//
//  Utilities.m
//  Utility
//
//  Created by ZIYAO YANG on 15/8/20.
//  Copyright (c) 2015年 Zhong Rui. All rights reserved.
//

#import "Utilities.h"


@implementation Utilities

+ (id)getStoryboardInstanceByIdentity:(NSString*)identity
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:identity];
}
+ (id)getStoryboardInstanceByIdentity:(NSString * )storyboard byIdentity:(NSString *) identity{

    UIStoryboard* std = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
    return [std instantiateViewControllerWithIdentifier:identity];

}
+ (void)popUpAlertViewWithMsg:(NSString *)msg andTitle:(NSString* )title onView:(UIViewController *)vc
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title == nil ? @"提示" : title message:msg == nil ? @"操作失败" : msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    [alertView addAction:cancelAction];
    [vc presentViewController:alertView animated:YES completion:nil];
}

+ (void)popUpAlertViewWithMsg:(NSString *)msg andTitle:(NSString *)title onView:(UIViewController *)vc tureAction:(void(^ )(UIAlertAction * action))action {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title == nil ? @"提示" : title message:msg == nil ? @"操作失败" : msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *trueAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:action];
    UIAlertAction *falseAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertView addAction:falseAction];
    [alertView addAction:trueAction];
    [vc presentViewController:alertView animated:YES completion:nil];
}

+ (UIActivityIndicatorView *)getCoverOnView:(UIView *)view
{
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [aiv setColor:[UIColor clearColor]];
    aiv.backgroundColor = [UIColor clearColor];
    aiv.frame = view.bounds;
    [view addSubview:aiv];
    [aiv startAnimating];
    return aiv;
}

+ (NSString *)notRounding:(float)price afterPoint:(int)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}



@end
