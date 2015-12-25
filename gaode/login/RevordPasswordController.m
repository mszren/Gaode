//
//  RevordPasswordController.m
//  gaode
//
//  Created by 我 on 15/10/30.
//  Copyright © 2015年 我. All rights reserved.
//

#import "RevordPasswordController.h"
#import "Header.h"
#import "Masonry.h"
#import "Utils.h"
#import "RevordPasswordSecondController.h"

@interface RevordPasswordController ()

@end

@implementation RevordPasswordController{
    
    UITextField *_phoneText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"重置密码"];
    self.view.backgroundColor = [UIColor grayColor];
    [self initView];
}

- (void)initView{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIView *phoneView = [UIView new];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    phoneView.backgroundColor = [UIColor whiteColor];
    
    _phoneText = [UITextField new];
    [phoneView addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 60));
    }];
    _phoneText.placeholder = @"请输入绑定账号的手机号";
    _phoneText.font = [UIFont systemFontOfSize:15];
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    
}

#pragma mark -- UIBarButtonItem Acyion
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
    [_phoneText resignFirstResponder];
    if ([Utils checkTelNumber:_phoneText.text]) {
        
        [self creatAlertController];
        
    }else{
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"请输入正确的手机号"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}

//创建提示选择框
- (void)creatAlertController{
    
    UIAlertController*al=[UIAlertController alertControllerWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送验证码到该手机:%@",_phoneText.text] preferredStyle:UIAlertControllerStyleAlert];
    [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        RevordPasswordSecondController *revordVc = [RevordPasswordSecondController new];
        [self.navigationController pushViewController:revordVc animated:YES];
 
    }]];
    
    [al addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }]];
    [self presentViewController:al animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
