//
//  BlocksViewController.m
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/28.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import "BlocksViewController.h"

@interface BlocksViewController ()

@property(nonatomic,strong)UITextField *textField;

@end

@implementation BlocksViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    NSLog(@"%@",self.view.backgroundColor);
    self.navigationItem.title = @"Block_传值";
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
    self.textField.placeholder = @"Block_传值";
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

- (void)back:(UIButton *)sender
{
    //寻找合适的时机把要传入的值赋给block中
    if (self.returnvalueBlock) {
        self.returnvalueBlock(self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//把传进来的block语句保存在本垒的实力变量returnValueBlock中
- (void)returnValue:(returnValueBlock)returnvalueBlock
{
    self.returnvalueBlock = returnvalueBlock;
}


@end
