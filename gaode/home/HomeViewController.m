//
//  HomeViewController.m
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "HomeViewController.h"
#import "Header.h"
#import <Masonry.h>
#import "EGOImageView.h"
#import "PersonCenterController.h"
#import "MycodeController.h"
#import "MyBangBiController.h"
#import "BangbangController.h"
#import "MySaveController.h"
#import "FamilyManagerController.h"

@interface HomeViewController () <UIScrollViewDelegate>

@end

@implementation HomeViewController{
    
    UIScrollView *_scrollView;
    UIView *_faceView;
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    EGOImageView *_sexImg;
    UILabel *_sexLabel;
    UIButton *_codeBtn;
    UIButton *_edtiButton;
    UIView *_bangbiView;
    UILabel *_bangbiLabel;
    UIView *_bangbangView;
    UILabel *_bangbangLabel;
    UIView *_shaishaiView;
    UILabel *_shaishaiLabel;
    UIView *_saveView;
    UILabel *_saveLbel;
    UIView *_familyView;
    UIView *_patnerView;
    UIView *_setView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"我的"];
    [self initView];
}

- (void)initView{
    
    _scrollView = [UIScrollView new];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 113));
    }];
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor orangeColor];
    
    _faceView = [UIView new];
    [_scrollView addSubview:_faceView];
    [_faceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80));
    }];
    _faceView.backgroundColor = WHITE_COLOR;
    
    _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
    [_faceView addSubview:_faceImg];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _nameLabel = [UILabel new];
    [_faceView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    _nameLabel.text = @"迷失之刃";
    _nameLabel.font = [UIFont systemFontOfSize:13];
    
    _sexImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_nan"]];
    [_faceView addSubview:_sexImg];
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(52);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    _sexLabel = [UILabel new];
    [_faceView addSubview:_sexLabel];
    [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(103);
        make.top.mas_equalTo(52);
        make.size.mas_equalTo(CGSizeMake(40, 13));
    }];
    _sexLabel.text = @"男";
    _sexLabel.font = [UIFont systemFontOfSize:13];
    
    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_faceView addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 97);
        make.top.mas_equalTo(28.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    _codeBtn.tag = 100;
    [_codeBtn setImage:[UIImage imageNamed:@"ic_wojia_ewm"] forState:UIControlStateNormal];
    _codeBtn.adjustsImageWhenHighlighted = NO;
    [_codeBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _edtiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_faceView addSubview:_edtiButton];
    [_edtiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 60);
        make.top.mas_equalTo(27.5);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    [_edtiButton setTitle:@"编辑" forState:UIControlStateNormal];
    _edtiButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _edtiButton.layer.cornerRadius = 12;
    _edtiButton.clipsToBounds = YES;
    _edtiButton.layer.shouldRasterize = YES;
    _edtiButton.tag = 200;
    _edtiButton.backgroundColor = [UIColor grayColor];
    _edtiButton.adjustsImageWhenHighlighted = NO;
    [_edtiButton addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];

    _bangbiView = [UIView new];
    [_scrollView addSubview:_bangbiView];
    [_bangbiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _bangbiView.backgroundColor = WHITE_COLOR;
    _bangbiView.tag = 300;
    UITapGestureRecognizer *bangbiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_bangbiView addGestureRecognizer:bangbiTap];
    _bangbiView.userInteractionEnabled = YES;
    
    EGOImageView *bangbiImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_bangbi"]];
    [_bangbiView addSubview:bangbiImg];
    [bangbiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *bangbiLabel = [UILabel new];
    [_bangbiView addSubview:bangbiLabel];
    [bangbiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    bangbiLabel.text = @"我的帮币";
    bangbiLabel.font = [UIFont systemFontOfSize:13];
    
    _bangbiLabel = [UILabel new];
    [_bangbiView addSubview:_bangbiLabel];
    [_bangbiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 50);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    _bangbiLabel.text = @"360";
    _bangbiLabel.textAlignment = NSTextAlignmentRight;
    _bangbiLabel.font = [UIFont systemFontOfSize:11];
    
    _bangbangView = [UIView new];
    [_scrollView addSubview:_bangbangView];
    [_bangbangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(160.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _bangbangView.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *bangbangTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _bangbangView.userInteractionEnabled = YES;
    _bangbangView.tag = 301;
    [_bangbangView addGestureRecognizer:bangbangTap];
    
    EGOImageView *bangbangImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_bangbang"]];
    [_bangbangView addSubview:bangbangImg];
    [bangbangImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *bangbangLabel = [UILabel new];
    [_bangbangView addSubview:bangbangLabel];
    [bangbangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    bangbangLabel.text = @"我的帮帮";
    bangbangLabel.font = [UIFont systemFontOfSize:13];
    
    _bangbangLabel = [UILabel new];
    [_bangbangView addSubview:_bangbangLabel];
    [_bangbangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 50);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    _bangbangLabel.text = @"3";
    _bangbangLabel.textAlignment = NSTextAlignmentRight;
    _bangbangLabel.font = [UIFont systemFontOfSize:11];
    
    _shaishaiView = [UIView new];
    [_scrollView addSubview:_shaishaiView];
    [_shaishaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(221.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _shaishaiView.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *shaishaiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _shaishaiView.userInteractionEnabled = YES;
    _shaishaiView.tag = 302;
    [_shaishaiView addGestureRecognizer:shaishaiTap];
    
    EGOImageView *shaishaiImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_shaishai"]];
    [_shaishaiView addSubview:shaishaiImg];
    [shaishaiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *shaishaiLabel = [UILabel new];
    [_shaishaiView addSubview:shaishaiLabel];
    [shaishaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    shaishaiLabel.text = @"我的晒晒";
    shaishaiLabel.font = [UIFont systemFontOfSize:13];
    
    _shaishaiLabel = [UILabel new];
    [_shaishaiView addSubview:_shaishaiLabel];
    [_shaishaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 50);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    _shaishaiLabel.text = @"9";
    _shaishaiLabel.textAlignment = NSTextAlignmentRight;
    _shaishaiLabel.font = [UIFont systemFontOfSize:11];
    
    _saveView = [UIView new];
    [_scrollView addSubview:_saveView];
    [_saveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(282.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _saveView.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *saveTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _saveView.userInteractionEnabled = YES;
    _saveView.tag = 303;
    [_saveView addGestureRecognizer:saveTap];
    
    EGOImageView *saveImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_shoucang"]];
    [_saveView addSubview:saveImg];
    [saveImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *saveLabel = [UILabel new];
    [_saveView addSubview:saveLabel];
    [saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    saveLabel.text = @"我的收藏";
    saveLabel.font = [UIFont systemFontOfSize:13];
    
    _saveLbel = [UILabel new];
    [_saveView addSubview:_saveLbel];
    [_saveLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 50);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    _saveLbel.text = @"7";
    _saveLbel.textAlignment = NSTextAlignmentRight;
    _saveLbel.font = [UIFont systemFontOfSize:11];
    
    _familyView = [UIView new];
    [_scrollView addSubview:_familyView];
    [_familyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(351);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _familyView.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *familyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _familyView.userInteractionEnabled = YES;
    _familyView.tag = 304;
    [_familyView addGestureRecognizer:familyTap];
    
    EGOImageView *familyImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_jiaren"]];
    [_familyView addSubview:familyImg];
    [familyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *familyLabel = [UILabel new];
    [_familyView addSubview:familyLabel];
    [familyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    familyLabel.text = @"家人管理";
    familyLabel.font = [UIFont systemFontOfSize:13];
    
    EGOImageView *familyTopImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_jiantou"]];
    [_familyView addSubview:familyTopImg];
    [familyTopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 18);
        make.top.mas_equalTo(23.5);
        make.size.mas_equalTo(CGSizeMake(8, 13));
    }];
    
    _patnerView = [UIView new];
    [_scrollView addSubview:_patnerView];
    [_patnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(411.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _patnerView.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *partnerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _patnerView.userInteractionEnabled = YES;
    _patnerView.tag = 305;
    [_patnerView addGestureRecognizer:partnerTap];
    
    EGOImageView *partnerImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_huoban"]];
    [_patnerView addSubview:partnerImg];
    [partnerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *partnerLabel = [UILabel new];
    [_patnerView addSubview:partnerLabel];
    [partnerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    partnerLabel.text = @"伙伴管理";
    partnerLabel.font = [UIFont systemFontOfSize:13];
    
    EGOImageView *partnerTopImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_jiantou"]];
    [_patnerView addSubview:partnerTopImg];
    [partnerTopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 18);
        make.top.mas_equalTo(23.5);
        make.size.mas_equalTo(CGSizeMake(8, 13));
    }];
    
    _setView = [UIView new];
    [_scrollView addSubview:_setView];
    [_setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(481);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _setView.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *setTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _setView.userInteractionEnabled = YES;
    _setView.tag = 306;
    [_setView addGestureRecognizer:setTap];
    
    EGOImageView *setImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_shezhi"]];
    [_setView addSubview:setImg];
    [setImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *setLabel = [UILabel new];
    [_setView addSubview:setLabel];
    [setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    setLabel.text = @"设置";
    setLabel.font = [UIFont systemFontOfSize:13];
    
    EGOImageView *setTopImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_jiantou"]];
    [_setView addSubview:setTopImg];
    [setTopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 18);
        make.top.mas_equalTo(23.5);
        make.size.mas_equalTo(CGSizeMake(8, 13));
    }];
 
    _scrollView.contentSize = CGSizeMake(0, 541.5);
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 100:{
            
            MycodeController *myCodeVc = [MycodeController new];
            myCodeVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myCodeVc animated:YES];
        }
            break;
        case 200:{
            
            PersonCenterController *personVc = [PersonCenterController new];
            personVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personVc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 300:{
            
            MyBangBiController *myBangBiVc = [MyBangBiController new];
            myBangBiVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myBangBiVc animated:YES];
        }
            
            break;
        case 301:{
            
            BangbangController *bangVc = [BangbangController new];
            bangVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bangVc animated:YES];
        }
            
            break;
        case 302:
            
            break;
        case 303:{
            
            MySaveController *mySaveVc = [MySaveController new];
            mySaveVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mySaveVc animated:YES];
        }
            
            break;
        case 304:{
            
            FamilyManagerController *familyVc = [FamilyManagerController new];
            familyVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:familyVc animated:YES];
        }
            
            break;
        case 305:
            
            break;
        case 306:
            
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
   
}

@end
