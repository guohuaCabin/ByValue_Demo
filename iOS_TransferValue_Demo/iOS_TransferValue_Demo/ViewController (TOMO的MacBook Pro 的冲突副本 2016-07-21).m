//
//  ViewController.m
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/28.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import "ViewController.h"

#import "BlocksViewController.h"
#import "DelegateViewController.h"
#import "NotificationViewController.h"
#import "KVCViewController.h"
#import "UsersDefaultViewController.h"
#import "SingletonViewController.h"

@interface ViewController ()<UITextFieldDelegate,delegateOutPutValue>

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,assign)NSInteger btnTag;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获得持久化存储文件
    [self obtainUserDefaultsObject];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createButton];
    [self createTextField];
    
}
- (void)createTextField
{
    CGFloat x = 10;
    CGFloat height = 80;
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(x, 70, self.view.frame.size.width-2*x, height)];
    self.textField.placeholder = @"传值显示";
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
    
   
    
    [self.view addSubview:self.textField];
    
}

- (void)createButton
{
    static NSInteger count = 6;
    NSArray *arrayTitle = @[@"Block传值",@"delegate_代理传值",@"Notification_通知传值",@"KVC_传值",@"UserDefaults_本地持久化传值",@"Singleton_单例传值"];
    
    CGFloat width = 250;
    CGFloat height = 50;
    
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-width)/2, 180+90*i, width, height)];
        [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [btn setTitleShadowColor:[UIColor purpleColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 8.0;
        
        [btn addTarget:self action:@selector(btnCilcked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 +i;
        [self.view addSubview:btn];
    }
}

-(void)btnCilcked:(UIButton *)sender
{
    NSLog(@"%li",sender.tag);
    
    NSString *content = self.textField.text;
    switch (sender.tag) {
        case 100:
        {
            __weak ViewController *weekSelf = self;
            BlocksViewController *blockVC  = [[BlocksViewController alloc]init];
            [blockVC returnValue:^(NSString *content) {
                weekSelf.textField.text = content;
            }];
            blockVC.contentText = content;
            [self.navigationController pushViewController:blockVC animated:YES];
            break;
        }
        case 101:
        {
            DelegateViewController *delegateVC = [[DelegateViewController alloc]init];
            delegateVC.delegate = self;
            delegateVC.contentText = content;
            [self.navigationController pushViewController:delegateVC animated:YES];
            break;
        }
        case 102:
        {
             NotificationViewController *notificationVC = [[NotificationViewController alloc]init];
            notificationVC.contentText = content;
            //设置监听器
            [self registerNotification];
            
            [self.navigationController pushViewController:notificationVC animated:YES];
            break;
        }
        case 103:
        {
            KVCViewController *kvcVC = [[KVCViewController alloc]init];
            kvcVC.contentText = content;
            [self.navigationController pushViewController:kvcVC animated:YES];
            break;
        }
        case 104:
        {
             UsersDefaultViewController *userDefaultVC = [[UsersDefaultViewController alloc]init];
            userDefaultVC.contentText = content;
            
            [self.navigationController pushViewController:userDefaultVC animated:YES];
            break;
        }
        case 105:
        {
            SingletonViewController *singletonVC = [[SingletonViewController alloc]init];
            singletonVC.contentText = content;
            [self.navigationController pushViewController:singletonVC animated:YES];
            break;
        }
    }
  
}

//实现代理方法
- (void)returnValueAboutDelegate:(NSString *)text
{
    self.textField.text = text;
}

//设置监听器
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showNotificationInfo:) name:@"notification" object:nil];
}

- (void)showNotificationInfo:(NSNotification *)nofity
{
    self.textField.text = nofity.object;
    //或者
    //self.textField.text = [nofity.userInfo objectForKey:@"text"];
}

//得到本地持久化存储文件
- (void)obtainUserDefaultsObject
{
    NSString *content = [[NSUserDefaults standardUserDefaults]objectForKey:@"content"];
    self.textField.text = content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
