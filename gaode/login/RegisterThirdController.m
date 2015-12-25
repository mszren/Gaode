//
//  RegisterThirdController.m
//  gaode
//
//  Created by 我 on 15/10/30.
//  Copyright © 2015年 我. All rights reserved.
//

#import "RegisterThirdController.h"
#import "Masonry.h"
#import "Header.h"
#import "Utils.h"

@interface RegisterThirdController () <UITextFieldDelegate>

@end

@implementation RegisterThirdController{
    
    UITextField *_cardText;
    UITextField *_password;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"注册3/3"];
    [self initView];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)initView{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIView *phoneView = [UIView new];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    phoneView.backgroundColor = [UIColor whiteColor];
    
    _cardText = [UITextField new];
    [phoneView addSubview:_cardText];
    [_cardText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 60));
    }];
    _cardText.placeholder = @"验证码";
    _cardText.delegate = self;
    _cardText.font = [UIFont systemFontOfSize:15];
    _cardText.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *passwordView = [UIView new];
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(101);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    passwordView.backgroundColor = [UIColor whiteColor];
    
    _password = [UITextField new];
    [passwordView addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 60));
    }];
    _password.placeholder = @"密码";
    _password.delegate = self;
    _password.keyboardType = UIKeyboardTypeASCIICapable;
    _password.font = [UIFont systemFontOfSize:15];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _password) {
        
        #pragma 判断是否是数字或字母
        return [Utils checNumAndLetter:string];
    }else {
        
        if (range.location > 5) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"验证码只有6位"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            
            return NO;
        }
        return YES;
    }
    
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_password resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
