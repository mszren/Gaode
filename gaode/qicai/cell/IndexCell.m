//
//  IndexCell.m
//  gaode
//
//  Created by 我 on 15/10/29.
//  Copyright © 2015年 我. All rights reserved.
//

#import "IndexCell.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "Header.h"

@implementation IndexCell{
    
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    EGOImageView *_vedio;
    UIView *_backgroundView;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backgroundView = [UIView new];
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 230));
        }];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_shoucang_selected"]];
        [_backgroundView addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _nameLabel = [UILabel new];
        [_backgroundView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        _nameLabel.text = @"迷失";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
        _timeLabel = [UILabel new];
        [_backgroundView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 120);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(110, 40));
        }];
        _timeLabel.text = @"2015-10-13 10:00";
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        _titleLabel = [UILabel new];
        [_backgroundView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(60);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 12));
        }];
        _titleLabel.text = @"大家好，这是我的游玩日记";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _vedio = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"img_saisai_hdzt1"]];
        [_backgroundView addSubview:_vedio];
        [_vedio mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(80);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 150));
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
