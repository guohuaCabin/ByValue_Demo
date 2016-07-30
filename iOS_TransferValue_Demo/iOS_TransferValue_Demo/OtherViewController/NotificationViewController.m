//
//  NotificationViewController.m
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/28.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@property(nonatomic,strong)UITextField *textField;

@end

@implementation NotificationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    self.navigationItem.title = @"Notification_传值";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTextField];
    [self createButton];
}
- (void)createTextField
{
    CGFloat x = 10.0f;
    CGFloat y = 150.0f;
    CGFloat height = 100.0f;
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(x, y, self.view.frame.size.width-2*x, height)];
    self.textField.placeholder = @"Notification_传值";
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.adjustsFontSizeToFitWidth =YES;
    [self.textField becomeFirstResponder];
    
    self.textField.leftViewMode = UITextFieldViewModeWhileEditing;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.backgroundColor = [UIColor grayColor];
    [self.textField setTextColor:[UIColor purpleColor]];
    self.textField.layer.borderWidth = 2.0;//边框画线
    self.textField.layer.cornerRadius = 8.0;
    self.textField.layer.masksToBounds = YES;
    
    //属性传值赋值
    self.textField.text = self.contentText;
    [self.view addSubview:self.textField];
    
}

-(void)createButton
{
    CGFloat width = 200.0f;
    CGFloat y = 400.0f;
    CGFloat height = 50.0f;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-width)/2, y, width, height)];
    [btn setTitle:@"Back" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleShadowColor:[UIColor purpleColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8.0;
    
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}
/**
 *  先在NotificationVC的button点击响应函数中注册notification，取名为notification，并将要传的数据存入NSDictionary中（ 因为notification只能发送NSDictionary数据 ），然后发送
 *
 */
- (void)back:(UIButton *)sender
{
    //通知模式
    NSString *content = self.textField.text;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notification" object:content];
    //或者
    /*
    NSDictionary *dic = @{@"text":self.textField.text};
    NSNotification *nofity = [[NSNotification alloc]initWithName:@"notification" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:nofity];
     */
    
    /**
     *发送通知：调用观察者处的方法
     *
     * [[NSNotificationCenter defaultCenter]postNotificationName:@"XXX" object: XXX]
     *
     *参数：
     *   postNotificationName:通知的名字，也是通知的唯一标示，编译器就通过这个找到通知的。
     *   object ：传递的参数
     */
    //[NSNotificationCenter defaultCenter]postNotificationName:<#(nonnull NSString *)#> object:<#(nullable id)#>
    
    //[NSNotificationCenter defaultCenter]postNotificationName:<#(nonnull NSString *)#> object:<#(nullable id)#> userInfo:<#(nullable NSDictionary *)#>
    [self.navigationController popViewControllerAnimated:YES];
}


@end
