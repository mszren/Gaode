//
//  AlertView.m
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import "AlertView.h"
#import "Header.h"

@implementation AlertView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showAlertView:(NSString *)title andMessage:(NSString *)content withDelegate:(id<AlertViewDelegate>)delegate{
    self.deletate = delegate;
    self.isCertain = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_viewController.view addGestureRecognizer:tap];
    _viewController.view.tag = 200;
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 240)/2, SCREEN_HEIGHT/2 - 80, 240, 160)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.cornerRadius = 6;
    _backGroundView.clipsToBounds = YES;
    _backGroundView.layer.shouldRasterize = YES;
    [_viewController.view addSubview:_backGroundView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 240, 40)];
    _titleLabel.text = title;
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.tag = 300;
    [_backGroundView addSubview:_titleLabel];
    UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)   ];
    [_titleLabel addGestureRecognizer:titleTap];
    
    UILabel *greenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, 240, 1)];
    greenLabel.backgroundColor = [UIColor blueColor];
    [_backGroundView addSubview:greenLabel];
    UITapGestureRecognizer *greenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [greenLabel addGestureRecognizer:greenTap];
    
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, 10, 80)];
    coverView.backgroundColor = [UIColor whiteColor];
    [_backGroundView addSubview:coverView];
    UITapGestureRecognizer *coverTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [coverView addGestureRecognizer:coverTap];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 41, 230, 80)];
    _contentLabel.text = content;
    _contentLabel.userInteractionEnabled = YES;
    _contentLabel.tag = 400;
    _contentLabel.font = [UIFont systemFontOfSize:13];
    [_backGroundView addSubview:_contentLabel];
    UITapGestureRecognizer *contentTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_contentLabel addGestureRecognizer:contentTap];
    
    UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 121, 240, 0.5)];
    grayLabel.backgroundColor = [UIColor grayColor];
    [_backGroundView addSubview:grayLabel];
    
    
    NSArray *arry = @[@"取消",@"确定"];
    for (NSInteger i = 0; i < arry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + 120*i, 121.5, 120, 40);
        [button setTitle:arry[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100 + i;
        button.adjustsImageWhenHighlighted = NO;
        [_backGroundView addSubview:button];
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *hGrayLabel = [[UILabel alloc]initWithFrame:CGRectMake(120.5, 122, 0.5, 40)];
    hGrayLabel.backgroundColor = [UIColor grayColor];
    [_backGroundView addSubview:hGrayLabel];
    
    // The window has to be un-hidden on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.window makeKeyAndVisible];
        
        _backGroundView.alpha = 0;
        _backGroundView.layer.shouldRasterize = YES;
        _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.alpha = 1;
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _backGroundView.alpha = 1;
                _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            } completion:^(BOOL finished2) {
                _backGroundView.layer.shouldRasterize = NO;
                
            }];
            
            
            
        }];
        
    });
    
    
}

#pragma  mark  -- UITapGestureRecognizer
-(void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 200:
            [self clean];
            break;
            
        default:
            break;
    }
    
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            self.isCertain = NO;
            break;
            
        default:
            self.isCertain = YES;
            break;
    }
    [self.deletate AlertViewDelegateIsCertain:self.isCertain];
    [self clean];
}

-(void)clean{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _backGroundView.alpha = 0;
                _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            } completion:^(BOOL finished2) {
                
                [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
                [self.window removeFromSuperview];
                [self.backGroundView removeFromSuperview];
                self.viewController = nil;
                self.window = nil;
                
                
            }];
            
        }];
        
    });
}

@end
