//
//  MBProgressHUD+JH.h
//  私人通讯录
//
//  Created by piglikeyoung on 15/3/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (JH)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end