//
//  JHTableViewCell.h
//  私人通讯录
//
//  Created by piglikeyoung on 15/3/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJContatc;

@interface JHContatcCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NJContatc *contatc;

@end
