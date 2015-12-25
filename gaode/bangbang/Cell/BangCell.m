//
//  BangCell.m
//  gaode
//
//  Created by 我 on 15/10/27.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BangCell.h"
#import "EGOImageView.h"
#import "Masonry.h"
#import "Header.h"

#define LABEL_WIDTH ((SCREEN_WIDTH - 40)/3 - 19)
@implementation BangCell
{
    
    UIView *_backGroundView;
    EGOImageView * _faceImg;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_titleLabel;
    UIButton *_saveBtn;
    UILabel *_saveLabel;
    UIButton *_shareBtn;
    UILabel *_shareLabel;
    UIButton *_commentBtn;
    UILabel *_commentLabel;
    UILabel *_grayLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backGroundView = [UIView new];
        [self addSubview:_backGroundView];
        [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 185));
        }];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
        [_backGroundView addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _nameLabel = [UILabel new];
        [_backGroundView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 20));
        }];
        _nameLabel.text = @"星星妈妈";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel = [UILabel new];
        [_backGroundView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.top.mas_equalTo(30);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 20));
        }];
        _timeLabel.text = @"20分钟前";
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel = [UILabel new];
        [_backGroundView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(60);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 10));
        }];
        _timeLabel.text = @"孩子的好习惯怎么培养?";
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        for (NSInteger i = 0; i < 3; i++) {
            EGOImageView * image = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
            [_backGroundView addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10 + ((SCREEN_WIDTH - 30)/3 + 5)*i);
                make.top.mas_equalTo(80);
                make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/3, 60));
            }];
        }
        
        _grayLabel = [UILabel new];
        [_backGroundView addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(149);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 0.5));
        }];
        _grayLabel.backgroundColor = [UIColor greenColor];
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_saveBtn];
        [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.top.mas_equalTo(160);
            make.size.mas_equalTo(CGSizeMake(14, 15));
        }];
        [_saveBtn setImage:[UIImage imageNamed:@"ic_bb_zan"] forState:UIControlStateNormal];
        _saveBtn.adjustsImageWhenHighlighted = NO;
        
        _saveLabel = [UILabel new];
        [_backGroundView addSubview:_saveLabel];
        [_saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(59);
            make.top.mas_equalTo(160);
            make.size.mas_equalTo(CGSizeMake(LABEL_WIDTH, 15));
        }];
        _saveLabel.text = @"11";
        _saveLabel.font = [UIFont systemFontOfSize:11];
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(59 + LABEL_WIDTH);
            make.top.mas_equalTo(160);
            make.size.mas_equalTo(CGSizeMake(14, 15));
        }];
        [_shareBtn setImage:[UIImage imageNamed:@"ic_bb_fenxiang"] forState:UIControlStateNormal];
        _shareBtn.adjustsImageWhenHighlighted = NO;
        
        _shareLabel = [UILabel new];
        [_backGroundView addSubview:_shareLabel];
        [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(78 + LABEL_WIDTH);
            make.top.mas_equalTo(160);
            make.size.mas_equalTo(CGSizeMake(LABEL_WIDTH, 15));
        }];
        _shareLabel.text = @"10";
        _shareLabel.font = [UIFont systemFontOfSize:11];
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_commentBtn];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(78 + LABEL_WIDTH*2);
            make.top.mas_equalTo(160);
            make.size.mas_equalTo(CGSizeMake(14, 15));
        }];
        [_commentBtn setImage:[UIImage imageNamed:@"ic_bb_pinlun"] forState:UIControlStateNormal];
        _commentBtn.adjustsImageWhenHighlighted = NO;
        
        _commentLabel = [UILabel new];
        [_backGroundView addSubview:_commentLabel];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(97 + LABEL_WIDTH*2);
            make.top.mas_equalTo(160);
            make.size.mas_equalTo(CGSizeMake(LABEL_WIDTH, 15));
        }];
        _commentLabel.text = @"123";
        _commentLabel.font = [UIFont systemFontOfSize:11];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
