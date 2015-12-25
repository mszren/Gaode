//
//  GrouthTreeDetailCell.m
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import "GrouthTreeDetailCell.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "Header.h"


#define BTN_WIDTH (SCREEN_WIDTH - 180)/4
@implementation GrouthTreeDetailCell 
{
    
    UILabel *_titleLabel;
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    EGOImageView *_contentImg;
    UIButton *_saveBtn;
    UILabel *_saveLabel;
    UIButton *_rewardBtn;
    UILabel * _rewardLabel;
    UIButton *_commentBtn;
    UILabel *_commentLabel;
    UIButton *_addressBtn;
    UILabel *_addressLabel;
    UILabel *_allCommentLabel;
    UIButton *_loveBtn;
    UILabel *_loveLabel;
    UIButton *_deleteBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 13));
        }];
        _titleLabel.text = @"啦啦啦啦啦啦啦啦";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(51);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.top.mas_equalTo(50);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        _nameLabel.text = @"爸爸  20分钟前";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        
        _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_addressBtn];
        [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 156);
            make.top.mas_equalTo(65);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        [_addressBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        
        _addressLabel = [UILabel new];
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 140);
            make.top.mas_equalTo(65);
            make.size.mas_equalTo(CGSizeMake(130 , 12));
        }];
        _addressLabel.text = @"靠近万达广场2号写字楼";
        _addressLabel.font = [UIFont systemFontOfSize:11];
        
        _contentImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"img_shaishai_banner"]];
        [self addSubview:_contentImg];
        [_contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(100);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 220));
        }];
        
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(BTN_WIDTH + (60 +BTN_WIDTH)*i);
                make.top.mas_equalTo(340);
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
                make.top.mas_equalTo(410);
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
            make.top.mas_equalTo(480);
            make.size.mas_equalTo(CGSizeMake(120, 12));
        }];
        _allCommentLabel.text = @"全部评论0条";
        _allCommentLabel.font = [UIFont systemFontOfSize:13];
        
        UILabel *grayLabel = [UILabel new];
        [self addSubview:grayLabel];
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(110);
            make.top.mas_equalTo(485);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 120, 0.3));
        }];
        grayLabel.backgroundColor = [UIColor greenColor];
        
        _loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_loveBtn];
        [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(450);
            make.size.mas_equalTo(CGSizeMake(12, 11));
        }];
        [_loveBtn setImage:[UIImage imageNamed:@"ic_kanzhe_zan"] forState:UIControlStateNormal];
        _loveBtn.adjustsImageWhenHighlighted = NO;
        
        _loveLabel = [UILabel new];
        [self addSubview:_loveLabel];
        [_loveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(29);
            make.top.mas_equalTo(450);
            make.size.mas_equalTo(CGSizeMake(120, 11));
        }];
        _loveLabel.text = @"迷失之刃赞了一下";
        _loveLabel.font = [UIFont systemFontOfSize:11];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 21);
            make.top.mas_equalTo(450);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        [_deleteBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        _deleteBtn.adjustsImageWhenHighlighted = NO;
        _deleteBtn.tag = 100;
        [_deleteBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 100:
            
            [[AlertView sharedInstance] showAlertView:@"删除确认" andMessage:@"我们将删除该条记录" withDelegate:self];
            break;
        case 400:
            
            break;
        case 401:
            
            break;
        case 402://评论按钮
            
            [[GrowTreeCommentView sharedInstance] showGrowTreeCommentView:@"评论" andBtnTitle:@"发送" withDelegate:self];
            break;
            
            
        default:
            break;
    }
}

#pragma mark -- GrowTreeCommentViewDelegate
- (void)growTreeCommentViewDelegateWithComment:(NSString *)content{
    
}

#pragma mark -- AlertViewDelegate
- (void)AlertViewDelegateIsCertain:(BOOL)isCertain{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
