//
//  DelegateViewController.h
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/28.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明协议
@protocol delegateOutPutValue;

@interface DelegateViewController : UIViewController


@property(nonatomic,weak)id <delegateOutPutValue>delegate;

//属性传值（从第一个界面传到第二个界面）
@property(nonatomic,copy)NSString *contentText;

@end

//创建代理协议
@protocol delegateOutPutValue <NSObject>

- (void)returnValueAboutDelegate:(NSString *)text;

@end