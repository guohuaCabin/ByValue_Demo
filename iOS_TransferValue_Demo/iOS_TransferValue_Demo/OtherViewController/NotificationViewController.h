//
//  NotificationViewController.h
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/28.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController

//属性传值（从第一个界面传到第二个界面）
@property(nonatomic,copy)NSString *contentText;

@end
