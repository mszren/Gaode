//
//  GrouthTreeCell.m
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import "GrouthTreeCell.h"
#import "Header.h"
#import <Masonry.h>
#import "EGOImageView.h"


@implementation GrouthTreeCell{
    
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    UILabel *_timeLbel;
    UILabel *_birthLabel;
    EGOImageView *_contentImg;
    UILabel * _contentLabel;
    UIButton *_addressBtn;
    UILabel *_addressLabel;
    UILabel *_feelLabel;
    UIButton *_deleteBtn;
    UIButton *_commentBtn;
    CMPopTipView * _cmPopView;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_kanzhe_czstb"]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(27);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(40, 12));
        }];
        _nameLabel.text = @"爸爸";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLbel = [UILabel new];
        [self addSubview:_timeLbel];
        [_timeLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(75);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(120, 12));
        }];
        _timeLbel.text = @"38分钟前  10:38";
        _timeLbel.font = [UIFont systemFontOfSize:11];
        
        _birthLabel = [UILabel new];
        [self addSubview:_birthLabel];
        [_birthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 100);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(90, 12));
        }];
        _birthLabel.text = @"3岁40天";
        _birthLabel.textAlignment = NSTextAlignmentRight;
        _birthLabel.font = [UIFont systemFontOfSize:13];
        
        _contentImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"img_shaishai_banner"]];
        [self addSubview:_contentImg];
        [_contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(50);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 220));
        }];
        
        _contentLabel = [UILabel new];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(290);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 12));
        }];
        _contentLabel.text = @"啦啦啦啦啦啦啦啦";
        _contentLabel.font = [UIFont systemFontOfSize:13];
        
        _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_addressBtn];
        [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(320);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        [_addressBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        
        _addressLabel = [UILabel new];
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.top.mas_equalTo(320);
            make.size.mas_equalTo(CGSizeMake(150, 12));
        }];
        _addressLabel.text = @"靠近万达广场2号写字楼";
        _addressLabel.font = [UIFont systemFontOfSize:11];
        
        _feelLabel = [UILabel new];
        [self addSubview:_feelLabel];
        [_feelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(180);
            make.top.mas_equalTo(320);
            make.size.mas_equalTo(CGSizeMake(40, 12));
        }];
        _feelLabel.text = @".开心.";
        _feelLabel.font = [UIFont systemFontOfSize:11];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(230);
            make.top.mas_equalTo(320);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        [_deleteBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        _deleteBtn.adjustsImageWhenHighlighted = NO;
        _deleteBtn.tag = 100;
        [_deleteBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_commentBtn];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 32);
            make.top.mas_equalTo(320);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        [_commentBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        _commentBtn.tag = 200;
        [_commentBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *grayLabel = [UILabel new];
        [self addSubview:grayLabel];
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(349.5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        grayLabel.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 100://删除
        [[AlertView sharedInstance] showAlertView:@"删除确认" andMessage:@"我们将删除该条记录" withDelegate:self];
            break;
            
        case 300:
           
            break;
            
        case 301:{
            [self.visiblePopTipViews removeObject:_cmPopView];
            self.currentPopTipViewTarget = nil;
            [_cmPopView dismissByUser];
            [self showShareView];
        }
            break;
            
        case 302:{
            
            [self.visiblePopTipViews removeObject:_cmPopView];
            self.currentPopTipViewTarget = nil;
            [_cmPopView dismissByUser];
            [[GrowTreeCommentView sharedInstance] showGrowTreeCommentView:@"评论" andBtnTitle:@"发送" withDelegate:self];
        }
            
            break;
            
        default:{
            //评论
            if (self.currentPopTipViewTarget == sender) {
                [self.visiblePopTipViews removeObject:_cmPopView];
                self.currentPopTipViewTarget = nil;
                
                return;
            }
            
            UIView * customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
            customView.userInteractionEnabled = YES;
            
            NSArray *arry = @[@"btn_xq_zan",@"btn_xq_fenxiang",@"btn_xq_pinlun"];
            for (NSInteger i = 0; i < arry.count; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [customView addSubview:button];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10 + 50*i);
                    make.top.mas_equalTo(0);
                    make.size.mas_equalTo(CGSizeMake(30, 30));
                }];
                button.tag = 300 + i;
                button.adjustsImageWhenHighlighted = NO;
                [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
                [button setImage:[UIImage imageNamed:arry[i]] forState:UIControlStateNormal];
            }
            
            _cmPopView = [[CMPopTipView alloc]initWithCustomView:customView];
            _cmPopView.delegate = self;
            _cmPopView.backgroundColor = [UIColor blackColor];
            _cmPopView.alpha = 0.3;
            _cmPopView.dismissTapAnywhere = YES;
            _cmPopView.animation = arc4random() % 2;
            _cmPopView.has3DStyle = (BOOL)(arc4random() % 2);
            [_cmPopView presentPointingAtView:_commentBtn inView:self animated:YES];
            [self.visiblePopTipViews addObject:_cmPopView];
            self.currentPopTipViewTarget = sender;
            
        }
            break;
    }
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}

- (void)CMPopTipViewIsUserTap:(CMPopTipView *)popTipView{
    
    
}

-(void)showShareView{
    
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:self.window.rootViewController.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv = [[ButtonView alloc]initWithText:@"新浪微博" image:[UIImage imageNamed:@"share_platform_sina"] handler:^(ButtonView *buttonView){
            NSLog(@"点击新浪微博");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"Email" image:[UIImage imageNamed:@"share_platform_email"] handler:^(ButtonView *buttonView){
            NSLog(@"点击Email");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"印象笔记" image:[UIImage imageNamed:@"share_platform_evernote"] handler:^(ButtonView *buttonView){
            NSLog(@"点击印象笔记");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"QQ" image:[UIImage imageNamed:@"share_platform_qqfriends"] handler:^(ButtonView *buttonView){
            NSLog(@"点击QQ");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"share_platform_wechat"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"share_platform_wechattimeline"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
        }];
        [self.activityView addButtonView:bv];
        
    }
    [self.activityView setBgColor:[UIColor whiteColor]];
    
    [self.activityView show];
}

#pragma mark -- AlertViewDelegate
- (void)AlertViewDelegateIsCertain:(BOOL)isCertain{
    
}

#pragma mark -- GrowTreeCommentViewDelegate
- (void)growTreeCommentViewDelegateWithComment:(NSString *)content{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
