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
#import "kSingleton.h"
@interface ViewController ()<UITextFieldDelegate,delegateOutPutValue>

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)kSingleton *single;

@property(nonatomic,assign)NSInteger btnTag;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获得持久化存储文件
   // [self obtainUserDefaultsObject];//使用其他几个传值时注释该行
    
    /**初始化单例*/
    /**
     *  如果用SingleInstance *single = [[SingleInstance alloc] init]也可以创建对象，不过创建出来的对象就不是共享的的了，所以本例中创建单例的方法并不是严格的只能创建一个实例。而是说，如果使用[SingleInstance sharedInstance]那创建出来的实例就是共享的，也就只有一个实例了。
     */
    
    //使用其他几个传值时注释该行
//    self.single = [kSingleton sharedInstance];
//    self.textField.text = self.single.string;
    
  
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createButton];
    [self createTextField];
    //self.textField.text = self.single.string;
    
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
//点击事件，跳转到不同界面。
-(void)btnCilcked:(UIButton *)sender
{
    NSLog(@"%li",sender.tag);
    
    NSString *content = self.textField.text;
    switch (sender.tag) {
        case 100:
        {
            BlocksViewController *blockVC  = [[BlocksViewController alloc]init];
            __weak ViewController *weekSelf = self;
            /**
             *  1、使用弱引用来解决block循环引用问题
             *
             *  2、block能截取自动变量，并且是不能在block块中进行修改的（除非用 __block修饰符）这里的 weekSelf.textField.text 的值是被修改了，并且没有使用 __block修饰符。原因是因为textField是全局变量，如果定义一个局部变量，比如：定义个 “text”是不能被修改的，编译器会报错，
             */
           // NSString *text = @"hello Objective-C";
            //block回调传值
            [blockVC returnValue:^(NSString *content) {
                weekSelf.textField.text = content;
               // text = content;//这里会提示错失__block;
                NSLog(@"block = %@",self.textField.text);
            }];
            //正向传值，以下雷同。。
            blockVC.contentText = content;
            [self.navigationController pushViewController:blockVC animated:YES];
            break;
        }
        case 101:
        {
            //代理传值
            DelegateViewController *delegateVC = [[DelegateViewController alloc]init];
            delegateVC.delegate = self;
            delegateVC.contentText = content;
            [self.navigationController pushViewController:delegateVC animated:YES];
            break;
        }
        case 102:
        {
            //通知传值
             NotificationViewController *notificationVC = [[NotificationViewController alloc]init];
            notificationVC.contentText = content;
            //设置监听器
            [self registerNotification];
            
            [self.navigationController pushViewController:notificationVC animated:YES];
            break;
        }
        case 103:
        {
            //KVC传值
            KVCViewController *kvcVC = [[KVCViewController alloc]init];
            [kvcVC setValue:self.textField.text forKey:@"string"];
            [self.navigationController pushViewController:kvcVC animated:YES];
            break;
        }
        case 104:
        {
            //本地持久化传值
             UsersDefaultViewController *userDefaultVC = [[UsersDefaultViewController alloc]init];
            userDefaultVC.contentText = content;
            
            [self.navigationController pushViewController:userDefaultVC animated:YES];
            break;
        }
        case 105:
        {
            //单例传值
            SingletonViewController *singletonVC = [[SingletonViewController alloc]init];
            [kSingleton sharedInstance].string = self.textField.text;
            [self.navigationController pushViewController:singletonVC animated:YES];
            break;
        }
    }
  
}

//实现代理协议方法
- (void)returnValueAboutDelegate:(NSString *)text
{
    self.textField.text = text;
    NSLog(@"delegate = %@",self.textField.text);
}

//设置监听器
- (void)registerNotification
{
    //设置notification监听器，监听名为"GetText"的notification，如果监听到，就触发响应方法。
    //"GetText"是要传值的界面注册的。这里是要监听这个通知
    //注册通知：既要在什么地方接受消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showNotificationInfo:) name:@"notification" object:nil];
    
    /**
     *  NSNotificationCenter 是专门供程序中不同类见的信息而设置的
     *参数介绍：
     * addObserver: 观察者，即在什么地方接受通知；
     *    selector: 接受通知后调用何种方法；
     *        name: 通知的名字，也是通知的唯一标示，编译器集通过这个找到通知。
     */
}

- (void)showNotificationInfo:(NSNotification *)nofity
{
    self.textField.text = nofity.object;
    NSLog(@"Notification = %@",self.textField.text);
    //或者
    //self.textField.text = [nofity.userInfo objectForKey:@"text"];
    
}

- (void)dealloc
{
    //移除通知中心
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notification" object:nil];
}
//得到本地持久化存储文件
- (void)obtainUserDefaultsObject
{
    NSString *content = [[NSUserDefaults standardUserDefaults]objectForKey:@"content"];
    self.textField.text = content;
}


@end
