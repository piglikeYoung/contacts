//
//  JHAddViewController.h
//  私人通讯录
//
//  Created by piglikeyoung on 15/3/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHAddViewController,NJContatc;

@protocol JHAddViewControllerDelegate <NSObject>

- (void)addViewControllerDidAddBtn:(JHAddViewController *)addViewController contatc:(NJContatc *)contatc;

@end

@interface JHAddViewController : UIViewController


@property (nonatomic, weak) id<JHAddViewControllerDelegate> delegate;

@end
