//
//  BlocksViewController.h
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/28.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import <UIKit/UIKit.h>

//创建block
typedef void(^returnValueBlock)(NSString *content);

@interface BlocksViewController : UIViewController


@property(nonatomic,copy) returnValueBlock  returnvalueBlock;

- (void)returnValue:(returnValueBlock)returnvalueBlock;

//属性传值（从第一个界面传到第二个界面）
@property(nonatomic,copy)NSString *contentText;

@end






