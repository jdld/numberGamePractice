//
//  Utilities.h
//  Utility
//
//  Created by ZIYAO YANG on 15/8/20.
//  Copyright (c) 2015年 Ziyao Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

/**
 *根据id获取控制器实例
 */
+ (id)getStoryboardInstanceByIdentity:(NSString*)storyboard byIdentity:(NSString*)identity;
/**
 *弹出普通提示框
 */
+ (void)popUpAlertViewWithMsg:(NSString *)msg andTitle:(NSString * )title onView:(UIViewController *)vc;
/**
 *获得保护膜
 */
+ (UIActivityIndicatorView *)getCoverOnView:(UIView *)view;
/**
 *将浮点数转化为保留小数点后若干位数的字符串
 */
+ (NSString *)notRounding:(float)price afterPoint:(int)position;

/**
 *带有选择按钮的提示框
 */
+ (void)popUpAlertViewWithMsg:(NSString *)msg andTitle:(NSString *)title onView:(UIViewController *)vc tureAction:(void(^)(UIAlertAction * action))action;

@end
