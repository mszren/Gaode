//
//  EditController.m
//  gaode
//
//  Created by 我 on 15/11/4.
//  Copyright © 2015年 我. All rights reserved.
//

#import "HomeEditController.h"
#import <Masonry.h>
#import "Header.h"

@interface HomeEditController () <UITextFieldDelegate>

@end

@implementation HomeEditController{
    
    UITextField *_contentText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"修改昵称"];
    [self initView];
}

- (void)initView{
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.view.backgroundColor = [UIColor orangeColor];
    UIView *backgroundView = [UIView new];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    backgroundView.backgroundColor = [UIColor whiteColor];
    
    _contentText = [UITextField new];
    [backgroundView addSubview:_contentText];
    [_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 50, 60));
    }];
    _contentText.font = [UIFont systemFontOfSize:13];
    _contentText.text = self.text;
    _contentText.delegate = self;
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backgroundView addSubview:cleanBtn];
    [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 30);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [cleanBtn setImage:[UIImage imageNamed:@"ic_xt_delete"] forState:UIControlStateNormal];
    cleanBtn.adjustsImageWhenHighlighted = NO;
    [cleanBtn addTarget:self action:@selector(onCleanBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onCleanBtn:(UIButton *)sender{
    
    _contentText.text = nil;
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_contentText resignFirstResponder];
    return YES;
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
    if (_editBlock) {
        _editBlock(_contentText.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
