//
//  GrouthTreeHeaderView.m
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import "GrouthTreeHeaderView.h"
#import "Header.h"
#import "EGOImageView.h"
#import <Masonry.h>
#import "FamilyManagerController.h"

@implementation GrouthTreeHeaderView{
    
    EGOImageView *_backgroundImg;
    EGOImageView *_faceImg;
    UIButton *_inviteBtn;
    UIButton *_publishBtn;
    UILabel *_nameLabel;
    UILabel *_ageLabel;
    UILabel *_inviteLabel;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backgroundImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
        [self addSubview:_backgroundImg];
        [_backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 222));
        }];
        _backgroundImg.userInteractionEnabled = YES;
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_kanzhe_mm"]];
        [_backgroundImg addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH/2 - 40);
            make.top.mas_equalTo(71);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        _faceImg.layer.cornerRadius = 30;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _nameLabel = [UILabel new];
        [_backgroundImg addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.top.mas_equalTo(100);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        _nameLabel.text = @"狮子";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor whiteColor];
        
        _ageLabel = [UILabel new];
        [_backgroundImg addSubview:_ageLabel];
        [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.top.mas_equalTo(128);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        _ageLabel.text = @"3岁40天";
        _ageLabel.font = [UIFont systemFontOfSize:13];
        _ageLabel.textColor = [UIColor whiteColor];
        
        _inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backgroundImg addSubview:_inviteBtn];
        [_inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH/2 + 70);
            make.top.mas_equalTo(80);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [_inviteBtn setImage:[UIImage imageNamed:@"btn_kanzhe_fxq"] forState:UIControlStateNormal];
        _inviteBtn.layer.cornerRadius = 20;
        _inviteBtn.clipsToBounds = YES;
        _inviteBtn.layer.shouldRasterize = YES;
        _inviteBtn.adjustsImageWhenHighlighted = NO;
        [_inviteBtn addTarget:self action:@selector(onInviteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _inviteLabel = [UILabel new];
        [_backgroundImg addSubview:_inviteLabel];
        [_inviteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH/2 +70);
            make.top.mas_equalTo(130);
            make.size.mas_equalTo(CGSizeMake(70, 13));
        }];
        _inviteLabel.textColor = [UIColor whiteColor];
        _inviteLabel.text = @"邀请家人";
        _inviteLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}

#pragma mark -- UIButton Action
- (void)onInviteBtn:(UIButton *)sender{
    
    FamilyManagerController *familyVc = [FamilyManagerController new];
    familyVc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:familyVc animated:YES];
    
}

@end
