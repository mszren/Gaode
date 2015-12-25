//
//  MyHeadCell.m
//  gaode
//
//  Created by 我 on 15/10/29.
//  Copyright © 2015年 我. All rights reserved.
//

#import "MyHeadCell.h"
#import "Header.h"
#import "EGOImageView.h"
#import "Masonry.h"

@implementation MyHeadCell{
    
    UIScrollView *_scrollView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _scrollView = [UIScrollView new];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 140));
        }];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        for (NSInteger  i = 0; i < 4; i++) {
            EGOImageView *img = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"img_saisai_hdzt4"]];
            [_scrollView addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10 + 110 *i);
                make.top.mas_equalTo(20);
                make.size.mas_equalTo(CGSizeMake(90, 80));
            }];
            img.tag = 100 + i;
            
            UILabel *label = [UILabel new];
            [_scrollView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10 + 110*i);
                make.top.mas_equalTo(110);
                make.size.mas_equalTo(CGSizeMake(90, 20));
            }];
            label.text = @"儿童手绘坊";
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = 200 + i;
            
        }
        
        _scrollView.contentSize = CGSizeMake(450, 0);
        
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(140);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        }];
        titleLabel.text = @"     游玩动态";
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor greenColor];
        titleLabel.textColor = [UIColor whiteColor];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
