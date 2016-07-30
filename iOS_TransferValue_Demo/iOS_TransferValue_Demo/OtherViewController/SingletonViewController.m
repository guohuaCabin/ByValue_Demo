//
//  SingletonViewController.m
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/28.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import "SingletonViewController.h"
#import "kSingleton.h"
@interface SingletonViewController ()

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)kSingleton *single;

@end

@implementation SingletonViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    self.navigationItem.title = @"Singleton_传值";
    
    // 如果用SingleInstance *single = [[SingleInstance alloc] init]也可以创建对象，不过这个创建出来的对象就不是共享的的了，所以本例中创建单例的方法并不是严格的只能创建一个实例。而是说，如果使用[SingleInstance sharedInstance]那创建出来的实例就是共享的，也就只有一个实例了。
    
    //初始化单例
    self.single = [kSingleton sharedInstance];
    self.textField.text = self.single.string;
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
    self.textField.placeholder = @"Singleton_传值";
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

- (void)back:(UIButton *)sender
{
    self.single.string = self.textField.text;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
