//
//  BangBiCell.m
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BangBiCell.h"
#import <Masonry.h>
#import "Header.h"

@implementation BangBiCell{
    
    UIView *_backgroundView;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_priceLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backgroundView = [UIView new];
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
        }];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [UILabel new];
        [_backgroundView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 13));
        }];
        _titleLabel.text = @"打赏帮帮这盘棋怎么解啊?求大神们指教!";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel = [UILabel new];
        [_backgroundView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(42);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        _timeLabel.text = @"06-22";
        _timeLabel.font = [UIFont systemFontOfSize:11];
        
        _priceLabel = [UILabel new];
        [_backgroundView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 80);
            make.top.mas_equalTo(42);
            make.size.mas_equalTo(CGSizeMake(70, 13));
        }];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        NSMutableString *string = [NSMutableString stringWithFormat:@"-5帮币"];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, string.length - 2)];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:[string rangeOfString:@"帮币"]];
        [attributeString addAttribute:NSForegroundColorAttributeName value:GREEN_COLOR range:NSMakeRange(0, string.length)];
        _priceLabel.attributedText = attributeString;

        UILabel *grayLabel = [UILabel new];
        [_backgroundView addSubview:grayLabel];
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(59.5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        grayLabel.backgroundColor = GREEN_COLOR;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
