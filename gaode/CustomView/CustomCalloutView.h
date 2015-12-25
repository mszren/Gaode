//
//  CustomCalloutView.h
//  gaode
//
//  Created by 我 on 15/9/30.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kPortraitMargin 5 
#define kPortraitWidth 70 
#define kPortraitHeight 50
#define kTitleWidth 120 
#define kTitleHeight 20
@interface CustomCalloutView : UIView

@property (nonatomic, strong) UIImage *image; //商户图
@property (nonatomic, copy) NSString *title; //商户名
@property (nonatomic, copy) NSString *subtitle; //地址

@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;

- (id)initWithFrame:(CGRect)frame;

@end
