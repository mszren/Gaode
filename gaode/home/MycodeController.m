//
//  MycodeController.m
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import "MycodeController.h"
#import "Header.h"
#import <Masonry.h>
#import "EGOImageView.h"
#import "QRCodeGenerator.h"

@interface MycodeController ()

@end

@implementation MycodeController{
    
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    EGOImageView *_sexImg;
    UILabel *_sexLabel;
    EGOImageView *_codeImg;
    UILabel *_titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"我的二维码"];
    [self initView];
}

- (void)initView{
    
    _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
    [self.view addSubview:_faceImg];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _nameLabel = [UILabel new];
    [self.view addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    _nameLabel.text = @"迷失之刃";
    _nameLabel.font = [UIFont systemFontOfSize:13];
    
    _sexImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_nan"]];
    [self.view addSubview:_sexImg];
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(52);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    _sexLabel = [UILabel new];
    [self.view addSubview:_sexLabel];
    [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(103);
        make.top.mas_equalTo(52);
        make.size.mas_equalTo(CGSizeMake(40, 13));
    }];
    _sexLabel.text = @"男";
    _sexLabel.font = [UIFont systemFontOfSize:13];
    
    
    _codeImg = [[EGOImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2, SCREEN_HEIGHT - 434, 300, 300)];
    [self.view addSubview:_codeImg];
    _codeImg.image = [QRCodeGenerator qrImageForString:@"迷失之刃" imageSize:_codeImg.bounds.size.width];
    
    _titleLabel = [[UILabel alloc]init];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(SCREEN_HEIGHT - 124);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 13));
    }];
    _titleLabel.text = @"扫一扫二维码，加我好友或者家人";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
