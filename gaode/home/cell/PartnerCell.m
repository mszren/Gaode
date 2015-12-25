//
//  PartnerCell.m
//  gaode
//
//  Created by 我 on 15/11/6.
//  Copyright © 2015年 我. All rights reserved.
//

#import "PartnerCell.h"
#import "Header.h"
#import <Masonry.h>
#import "EGOImageView.h"

@implementation PartnerCell{
    
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    UIButton *_sexBtn;
    UIButton *_deleteBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@""]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        _nameLabel.text = @"张小丫";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        
        _sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_sexBtn];
        [_sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.top.mas_equalTo(35);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
