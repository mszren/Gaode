//
//  LoginController.m
//  gaode
//
//  Created by 我 on 15/10/30.
//  Copyright © 2015年 我. All rights reserved.
//

#import "LoginController.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "Header.h"
#import "RevordPasswordController.h"
#import "Utils.h"

@interface LoginController () <UITextFieldDelegate>

@end

@implementation LoginController{
    
    UITextField *_phoneText;
    UITextField *_passwordText;
    UIButton *_loginBtn;
    UIButton *_forgetBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"登录"];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor orangeColor];
    [self initView];
}

- (void)initView{
    
    UIView *phoneView = [UIView new];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    phoneView.backgroundColor = [UIColor whiteColor];
    
    EGOImageView *phoneImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_xt_shouji"]];
    [phoneView addSubview:phoneImg];
    [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(23);
        make.size.mas_equalTo(CGSizeMake(11, 15));
    }];
    
    _phoneText = [UITextField new];
    [phoneView addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(36);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 36, 60));
    }];
    _phoneText.placeholder = @"手机号";
    _phoneText.delegate = self;
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneText.font = [UIFont systemFontOfSize:15];
    
    UIView *passwordView = [UIView new];
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(76);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    passwordView.backgroundColor = [UIColor whiteColor];
    
    EGOImageView *passwordImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_xt_mm"]];
    [passwordView addSubview:passwordImg];
    [passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(23);
         make.size.mas_equalTo(CGSizeMake(11, 15));
    }];
    
    _passwordText = [UITextField new];
    [passwordView addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(36);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 36, 60));
    }];
    _passwordText.placeholder = @"密码";
    _passwordText.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordText.font = [UIFont systemFontOfSize:15];
    _passwordText.delegate = self;
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(156);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 24, 50));
    }];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.adjustsImageWhenHighlighted = NO;
    _loginBtn.tag = 100;
    _loginBtn.backgroundColor = [UIColor greenColor];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_loginBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_forgetBtn];
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 80);
        make.top.mas_equalTo(220);
        make.size.mas_equalTo(CGSizeMake(70, 13));
    }];
    [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _forgetBtn.tag = 200;
    [_forgetBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 100:
            
            break;
            
        default:
        {
            
            RevordPasswordController *revordVc = [RevordPasswordController new];
            [self.navigationController pushViewController:revordVc animated:YES];
        }
            break;
    }
}



#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_phoneText resignFirstResponder];
    [_passwordText resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _passwordText) {
        
        return [Utils checNumAndLetter:string];
    }else

        return YES;
        
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
