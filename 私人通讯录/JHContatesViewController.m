//
//  JHContatesViewController.m
//  私人通讯录
//
//  Created by piglikeyoung on 15/3/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHContatesViewController.h"
#import "JHAddViewController.h"
#import "NJContatc.h"
#import "JHEditViewController.h"
#import "JHTableViewCell.h"

#define NJContactsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.arc"]

@interface JHContatesViewController ()<UIActionSheetDelegate,JHAddViewControllerDelegate,JHEditViewControllerDelegate>

/** 点击注销按钮 */
- (IBAction)logout:(UIBarButtonItem *)sender;

/**
 *  保存所有用户数据
 */
@property (nonatomic, strong) NSMutableArray *contatcs;

@end

@implementation JHContatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



- (IBAction)logout:(UIBarButtonItem *)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil,nil];
    
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 != buttonIndex) {
        return;
    }
    
    // 移除栈顶控制器
    [self.navigationController popViewControllerAnimated:YES];
}

// 无论是手动类型的segue还是自动类型的segue, 在跳转之前都会执行该方法
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 0.判断目标控制器是添加还是编辑
    // 1.取出目标控制器
    UIViewController *vc = (JHAddViewController *)segue.destinationViewController;
    if ([vc isKindOfClass:[JHAddViewController class]]) {
        JHAddViewController *addVc = (JHAddViewController *) vc;
        // 2.设置代理
        addVc.delegate = self;
    }else if ([vc isKindOfClass:[JHEditViewController class]])
    {
        // 传递数据
        JHEditViewController *editVc = (JHEditViewController *)vc;
        // 通过tableview获取被点击的行号
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        // 取出被点击行的模型
        NJContatc *c = self.contatcs[path.row];
        //NSLog(@"联系人列表 %p" , c);
        // 赋值模型
        editVc.contatc = c;
        // 设置代理
        editVc.delegate = self;
    }
}

#pragma mark - JHEditViewControllerDelegate
- (void)editViewControllerDidClickSavBtn:(JHEditViewController *)editViewController contatc:(NJContatc *)cpmtatc
{
    // 1.修改模型
    //    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    //    self.contatcs[path.row] = cpmtatc;
    
    [NSKeyedArchiver archiveRootObject:self.contatcs toFile:NJContactsPath];
    
    
    // 2.刷新表格
    [self.tableView reloadData];
}

#pragma mark - JHAddViewControllerDelegate
-(void)addViewControllerDidAddBtn:(JHAddViewController *)addViewController contatc:(NJContatc *)contatc
{
    // 1.保存数据到数组中
    [self.contatcs addObject:contatc];
    
    // 在这个地方保存用户添加的所有的联系人信息
    [NSKeyedArchiver archiveRootObject:self.contatcs toFile:NJContactsPath];
    
    
    // 2.刷新表格
    [self.tableView reloadData];
}

-(NSMutableArray *)contatcs
{
    // 从文件中读取数组
    // 如果第一次启动没有文件,就创建一个空的数组用于保存数据
    if (_contatcs == nil) {
        _contatcs = [NSKeyedUnarchiver unarchiveObjectWithFile:NJContactsPath];
        if (_contatcs == nil) {
            _contatcs = [NSMutableArray array];
        }
    }
    
    return _contatcs;
}

#pragma mark - 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contatcs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    // 1.创建cell
    JHContatcCell *cell = [JHContatcCell cellWithTableView:tableView];
    // 2.设置模型
    // 设置数据
    NJContatc *c = self.contatcs[indexPath.row];
    cell.contatc = c;
    
    return cell;
}

@end
