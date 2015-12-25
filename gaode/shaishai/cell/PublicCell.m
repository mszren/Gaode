//
//  PublicCell.m
//  gaode
//
//  Created by 我 on 15/11/3.
//  Copyright © 2015年 我. All rights reserved.
//

#import "PublicCell.h"
#import "EGOImageView.h"
#import <Masonry.h>
#import "Header.h"

@implementation PublicCell{
    
    UILabel *_titleLabel;
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    EGOImageView *_contentImg;
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
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(320);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 13));
        }];
        _titleLabel.text = @"啦啦啦啦啦啦啦啦";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        _nameLabel.text = @"爸爸  20分钟前";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        
        _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_addressBtn];
        [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 156);
            make.top.mas_equalTo(35);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        [_addressBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        
        _addressLabel = [UILabel new];
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 140);
            make.top.mas_equalTo(35);
            make.size.mas_equalTo(CGSizeMake(130 , 12));
        }];
        _addressLabel.text = @"靠近万达广场2号写字楼";
        _addressLabel.font = [UIFont systemFontOfSize:11];
        
        _contentImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"img_shaishai_banner"]];
        [self addSubview:_contentImg];
        [_contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(80);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 220));
        }];
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_commentBtn];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 21);
            make.top.mas_equalTo(350);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        [_commentBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        _commentBtn.adjustsImageWhenHighlighted = NO;
        _commentBtn.tag = 200;
        [_commentBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _feelLabel = [UILabel new];
        [self addSubview:_feelLabel];
        [_feelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(350);
            make.size.mas_equalTo(CGSizeMake(60, 12));
        }];
        _feelLabel.text = @".开心.";
        _feelLabel.font = [UIFont systemFontOfSize:13];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(80);
            make.top.mas_equalTo(350);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        _deleteBtn.tag = 100;
        [_deleteBtn setImage:[UIImage imageNamed:@"ic_kanzhe_czsbq"] forState:UIControlStateNormal];
        _deleteBtn.adjustsImageWhenHighlighted = NO;
        [_deleteBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *grayLbel = [UILabel new];
        [self addSubview:grayLbel];
        [grayLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(380);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        grayLbel.backgroundColor = [UIColor greenColor];
    }
    return self;
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 100:
            [[AlertView sharedInstance] showAlertView:@"删除确认" andMessage:@"我们将删除该条记录" withDelegate:self];
            break;
        case 200:{
            
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
            
        default:
            break;
    }
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

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}

- (void)CMPopTipViewIsUserTap:(CMPopTipView *)popTipView{
    
    
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
