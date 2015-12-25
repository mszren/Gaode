//
//  BangDetailCell.m
//  gaode
//
//  Created by 我 on 15/10/28.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BangDetailCell.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "Header.h"


#define BTN_WIDTH (SCREEN_WIDTH - 180)/4
@implementation BangDetailCell{
    
    UILabel *_titleLabel;
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    
    UILabel *_detailLabel;
    UIButton *_saveBtn;
    UILabel *_saveLabel;
    UIButton *_rewardBtn;
    UILabel * _rewardLabel;
    UIButton *_commentBtn;
    UILabel *_commentLabel;
    
    UILabel *_allCommentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 13));
        }];
        _titleLabel.text = @"孩子的好习惯怎么培养?";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(31);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.top.mas_equalTo(30);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 70, 40));
        }];
        _nameLabel.text = @"星星妈妈  20分钟前";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        
        _detailLabel = [UILabel new];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(90);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 70));
        }];
        _detailLabel.text = @"孩子的好习惯怎么培养?     孩子的好习惯怎么培养?     孩子的好习惯怎么培养?     孩子的好习惯怎么培养?     孩子的好习惯怎么培养?     孩子的好习惯怎么培养?     孩子的好习惯怎么培养?     ";
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:13];
        
        for (NSInteger i = 0; i < 3; i++) {
            EGOImageView *img = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(170 + 150*i);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 145));
            }];
        }
        
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(BTN_WIDTH + (60 +BTN_WIDTH)*i);
                make.top.mas_equalTo(650);
                make.size.mas_equalTo(CGSizeMake(60, 60));
            }];
            [button setImage:[UIImage imageNamed:@"btn_bb_dashang"] forState:UIControlStateNormal];
            button.layer.cornerRadius = button.frame.size.width/2;
            button.clipsToBounds = YES;
            button.layer.shouldRasterize = YES;
            button.tag = 400 + i;
            button.adjustsImageWhenHighlighted = NO;
            [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *label = [UILabel new];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(BTN_WIDTH + (60 +BTN_WIDTH)*i);
                make.top.mas_equalTo(720);
                make.size.mas_equalTo(CGSizeMake(60, 13));
            }];
            label.tag = 500 + i;
            label.text = @"11";
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
        }
        

        _allCommentLabel = [UILabel new];
        [self addSubview:_allCommentLabel];
        [_allCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(750);
            make.size.mas_equalTo(CGSizeMake(120, 12));
        }];
        _allCommentLabel.text = @"全部评论123条";
        _allCommentLabel.font = [UIFont systemFontOfSize:13];
        
        UILabel *grayLabel = [UILabel new];
        [self addSubview:grayLabel];
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(110);
            make.top.mas_equalTo(756);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 120, 0.3));
        }];
        grayLabel.backgroundColor = [UIColor greenColor];
        
        
        
        
    }
    return self;
    
}

- (void)onBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 400:
            
            break;
        case 401:{
            [[GrowTreeCommentView sharedInstance] showGrowTreeCommentView:@"请输入金额" andBtnTitle:@"打赏" withDelegate:self];
        }
            break;
        case 402:{
            
            [[GrowTreeCommentView sharedInstance] showGrowTreeCommentView:@"请输入评论" andBtnTitle:@"发送" withDelegate:self];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- GrowTreeCommentViewDelegate
- (void)growTreeCommentViewDelegateWithComment:(NSString *)content{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
