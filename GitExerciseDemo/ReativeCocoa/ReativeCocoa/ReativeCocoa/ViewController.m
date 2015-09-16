//
//  ViewController.m
//  ReativeCocoa
//
//  Created by wangjiangjiao on 15/9/13.
//  Copyright (c) 2015年 wangjiangjiao. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property (nonatomic, strong) UITextField * userNameTextField;
@property (nonatomic, strong) UITextField * passwordTextField;
@property (nonatomic, strong) UIButton * signInButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ReactiveCocoa";
    
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 160)/2.0, 100, 160, 30)];
    _userNameTextField.placeholder = @"User Name";
    _userNameTextField.font = [UIFont systemFontOfSize:15.0f];
    _userNameTextField.layer.cornerRadius = 2.0f;
    _userNameTextField.layer.borderWidth = 1.0f;
    _userNameTextField.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_userNameTextField];
    
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 160)/2.0, 180, 160, 30)];
    _passwordTextField.placeholder = @"Password";
    _passwordTextField.font = [UIFont systemFontOfSize:15.0f];
    _passwordTextField.layer.cornerRadius = 2.0f;
    _passwordTextField.layer.borderWidth = 1.0f;
    _passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_passwordTextField];
    
    
    _signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _signInButton.frame = CGRectMake(SCREEN_WIDTH - 100, 250, 50, 30);
    _signInButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_signInButton setTitle:@"signIn" forState:UIControlStateNormal];
    [_signInButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_signInButton addTarget:self action:@selector(loginInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_signInButton];
    
    @weakify(self);
    
//    [self racOnlySubscribeNextByTextSignal];
//    [self racFilterSubscribeNextByTextSignal];
    [self racMapFilterSubscribeNextByTextSignal];
    [self racMapValidFilterSubscribeNextByTextSignal];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark --
//刚才所创建的只是一个很简单的管道。这就是响应式编程的本质，根据数据流来表达应用的功能。

- (void)racOnlySubscribeNextByTextSignal
{
    [self.userNameTextField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"rac_textSignal and subscribeNext %@",x);
    }];
}


//rac_textSignal是起始事件。然后数据通过一个filter，如果这个事件包含一个长度超过3的字符串，那么该事件就可以通过。管道的最后一步就是subscribeNext:，block在这里打印出事件的值。
- (void)racFilterSubscribeNextByTextSignal
{
    [[self.userNameTextField.rac_textSignal filter:^BOOL(id value) {
        NSString * text = value;
        return text.length > 3;
    }]
     subscribeNext:^(id x) {
         NSLog(@"rac_textSignal and filter and subscribeNext %@",x);
         
     }];
    
    
    //下面与上面相同
    
    RACSignal * usernameSourceSignal = self.userNameTextField.rac_textSignal;
    
    RACSignal * filteredUsername = [usernameSourceSignal filter:^BOOL(id value) {
        NSString * text = value;
        return text.length > 3;
    }];
    
    [filteredUsername subscribeNext:^(id x) {
        NSLog(@"rac_textSignal and filter and subscribeNext %@",x);
    }];
}

//什么是事件呢？到目前为止，本篇教程已经描述了不同的事件类型，但是还没有说明这些事件的结构。有意思的是（？），事件可以包括任何事情。新加的map操作通过block改变了事件的数据。map从上一个next事件接收数据，通过执行block把返回值传给下一个next事件。在上面的代码中，map以NSString为输入，取字符串的长度，返回一个NSNumber。

- (void)racMapFilterSubscribeNextByTextSignal
{
    [[[self.userNameTextField.rac_textSignal map:^id(NSString*text) {
        return @(text.length);
    }] filter:^BOOL(NSNumber * length) {
        return [length integerValue] > 3;
    }] subscribeNext:^(id x) {
        NSLog(@"rac_textSignal map and filter and subscribeNext %@",x);
    }];
}

//创建有效状态信号
//首先要做的就是创建一些信号，来表示用户名和密码输入框中的输入内容是否有效。把下面的代码添加到

- (void)racMapValidFilterSubscribeNextByTextSignal
{
    @weakify(self);
    RACSignal * validUserNameSignal = [self.userNameTextField.rac_textSignal map:^id(NSString * text) {
        @strongify(self);
        return @([self isValidUserName:text]);
    }];
  
    
    RACSignal * validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString * password) {
        return @([self isValidUserName:password]);
    }];
    
    
    RAC(self.userNameTextField, backgroundColor) =
    [validUserNameSignal
     map:^id(NSNumber *passwordValid){
         return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
     }];

    
    RAC(self.passwordTextField, backgroundColor) = [validPasswordSignal map:^id(NSNumber *passwordValid) {
         return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
    }];

    
    //上面方式与下面相同
//    [[validPasswordSignal map:^id(NSNumber *passwordValid) {
//        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//    }]
//    subscribeNext:^(UIColor *color) {
//        self.passwordTextField.backgroundColor = color;
//    }];
//    
    
    
}

//聚合信号

- (void)racCombineLatest
{
    RACSignal * validUserNameSignal = [self.userNameTextField.rac_textSignal map:^id(NSString * text) {
        @strongify(self);
        return @([self isValidUserName:text]);
    }];
    
    
    RACSignal * validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString * password) {
        return @([self isValidUserName:password]);
    }];

    RACSignal * signUpActiveSignal = [RACSignal combineLatest:@[validUserNameSignal, validPasswordSignal]
                                                       reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
                                                           return @([usernameValid boolValue]&&[passwordValid boolValue]);
                                                       }];
}

- (BOOL)isValidUserName:(NSString *)text
{
    if (text.length > 3) {
        return YES;
    }
    
    return NO;
}

#pragma mark -- loginInButtonClick

- (void)loginInButtonClick:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
