//
//  ProjectCell.m
//  gaode
//
//  Created by 我 on 15/10/29.
//  Copyright © 2015年 我. All rights reserved.
//

#import "ProjectCell.h"
#import "Masonry.h"
#import "Header.h"
#import "EGOImageView.h"

@implementation ProjectCell{
    
    EGOImageView *_faceImg;
    UILabel *_titleLabel;
    UILabel *_descripeLabel;
    UILabel *_priceLabel;
    UIButton *_buyBtn;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backgroundView = [UIView new];
        [self addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
        }];
        backgroundView.backgroundColor = [UIColor whiteColor];
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
        [backgroundView addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(70, 80));
        }];
        
        _titleLabel = [UILabel new];
        [backgroundView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(90);
            make.top.mas_equalTo(13);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 12));
        }];
        _titleLabel.text = @"儿童手绘坊";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _descripeLabel = [UILabel new];
        [backgroundView addSubview:_descripeLabel];
        [_descripeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(90);
            make.top.mas_equalTo(31);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 110, 35));
        }];
        _descripeLabel.text = @"开儿童乐园，厂家直销儿童乐园品牌，集儿童娱乐、健身、益智游戏,集儿童娱乐、健身、益智游戏";
        _descripeLabel.numberOfLines = 0;
        _descripeLabel.font = [UIFont systemFontOfSize:12];
        
        _priceLabel = [UILabel new];
        [backgroundView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(90);
            make.top.mas_equalTo(70);
            make.size.mas_equalTo(CGSizeMake(100, 12));
        }];
        _priceLabel.text = @"¥5/小时";
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = [UIColor redColor];
        
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backgroundView addSubview:_buyBtn];
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 80);
            make.top.mas_equalTo(65);
            make.size.mas_equalTo(CGSizeMake(70, 25));
        }];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _buyBtn.backgroundColor = [UIColor greenColor];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(onBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

#pragma mark -- UIButton Action
- (void)onBuyBtn:(UIButton *)sender{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
