//
//  JHLoginViewController.m
//  私人通讯录
//
//  Created by piglikeyoung on 15/3/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHLoginViewController.h"
#import "MBProgressHUD+JH.h"

@interface JHLoginViewController ()
/**
 *  账号输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *accountField;
/**
 *  密码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
/**
 *  登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/**
 *  点击记住密码
 */
- (IBAction)remPwdChange:(id)sender;
/**
 *  点击自动登录
 */
- (IBAction)autoLoginChange:(id)sender;
/**
 *  记住密码
 */
@property (weak, nonatomic) IBOutlet UISwitch *remPwdSwitch;
/**
 *  自动登录
 */
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
/**
 *  点击登录按钮
 */
- (IBAction)loginOnClick:(id)sender;
@end

@implementation JHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.拿到通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 2.注册监听
    // 注意点:一定要写上通知的发布者
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
}

-(void)textChange
{
    self.loginBtn.enabled = (self.accountField.text.length>0 && self.pwdField.text.length>0);
}

-(IBAction)remPwdChange:(id)sender
{
    // 1.判断是否记住密码
    if (self.remPwdSwitch.isOn == NO) {
        // 2.如果取消记住密码取消自动登录
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginChange:(id)sender
{
    // 1.判断是否自动登录
    if (self.autoLoginSwitch.isOn) {
        // 2.如果自动登录就记住密码
        [self.remPwdSwitch setOn:YES animated:YES];
    }

}

- (IBAction)loginOnClick:(id)sender {
    
    // 添加蒙版禁止用户操作，并且提示用户正在登录
    [MBProgressHUD showMessage:@"正在拼命加载ing...."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        /*
         // 1.判断账号密码是否正确(lnj/123)
         if ([self.accountField.text isEqualToString:@"lnj"] &&
         [self.pwdField.text isEqualToString:@"123"]) {
         // 2.如果正如,跳转到联系人界面(手动执行segue)
         [self performSegueWithIdentifier:@"login2contatc" sender:nil];
         
         // 3.登录成功后移除蒙版
         [MBProgressHUD hideHUD];
         }else
         {
         
         
         
         // [MBProgressHUD showError:@"用户名或者密码不正确!!!"];
         }
         */
        
        
        
        
        
        if (![self.accountField.text isEqualToString:@"yjh"]) {
            // 移除蒙版
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"用户名不正确!!"];
            return ;
        }
        
        if (![self.pwdField.text isEqualToString:@"123"]) {
            // 移除蒙版
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"密码不正确!!"];
            return ;
        }
        
        // 登录成功后移除蒙版
        [MBProgressHUD hideHUD];
        // 如果正确,跳转到联系人界面(手动执行segue)
        [self performSegueWithIdentifier:@"login2contatc" sender:nil];
    });
}


// 在segue跳转之前调用, 会传入performSegueWithIdentifier方法创建好的segue对象
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 1.拿到目标控制器
    UIViewController *vc = segue.destinationViewController;
    // 2.设置目标控制器的标题
    vc.title = [NSString stringWithFormat:@"%@的联系人列表",self.accountField.text];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
