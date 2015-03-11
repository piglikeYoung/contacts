//
//  JHEditViewController.h
//  私人通讯录
//
//  Created by piglikeyoung on 15/3/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHEditViewController,NJContatc;

@protocol JHEditViewControllerDelegate <NSObject>

-(void)editViewControllerDidClickSavBtn:(JHEditViewController *)editViewController contatc:(NJContatc *)cpmtatc;

@end

@interface JHEditViewController : UIViewController

/**
 *  用于接收联系人列表传递过来的数据
 */
@property (nonatomic, strong) NJContatc *contatc;

@property (nonatomic, weak) id<JHEditViewControllerDelegate> delegate;

@end
