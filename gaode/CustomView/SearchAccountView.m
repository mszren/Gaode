//
//  publishVIew.m
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "SearchAccountView.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"
#import "SelectPublicView.h"
#import "FamilyManagerView.h"
#import "DaiDodgeKeyboard.h"

#define WIDTH (SCREEN_WIDTH - 100)/3
@implementation SearchAccountView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


-(void)showSearchAccountView:(UIView *)view{
    self.view = view;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_viewController.view];
    
    UIButton *styleView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
    styleView.tag = 100;
    [_viewController.view addSubview:styleView];
    [styleView addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
    _backGroundView.alpha = 1;
    _backGroundView.backgroundColor = [UIColor whiteColor];
    [_viewController.view addSubview:_backGroundView];
    
    UILabel *greenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    greenLabel.backgroundColor = GREEN_COLOR;
    [_backGroundView addSubview:greenLabel];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 12, 23, 24);
    [backButton setImage:[UIImage imageNamed:@"btn_back_green"] forState:UIControlStateNormal];
    [_backGroundView addSubview:backButton];
    backButton.adjustsImageWhenHighlighted = NO;
    backButton.tag = 200;
    [backButton addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _searText = [[UITextField alloc]initWithFrame:CGRectMake(35, 12, SCREEN_WIDTH - 105, 24)];
    _searText.font = [UIFont systemFontOfSize:13];
    _searText.placeholder = @"输入昵称或手机号";
    _searText.borderStyle = UITextBorderStyleRoundedRect;
    _searText.delegate = self;
    [_backGroundView addSubview:_searText];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 12, 50, 24);
    searchBtn.tag = 300;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.adjustsImageWhenHighlighted = NO;
    searchBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    searchBtn.backgroundColor = GREEN_COLOR;
    searchBtn.layer.cornerRadius = 4;
    searchBtn.clipsToBounds = YES;
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backGroundView addSubview:searchBtn];
    
    
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

#pragma amrk
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searText resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark -- NSNotificationCenter
- (void)tapCloseAction:(id)sender{
    [self clean];
}

#pragma mark
#pragma mark -- UIButton Action
-(void)onPublishBtn:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case 100:
            [self clean];
            
            break;
            
        case 200:
            
            [[FamilyManagerView sharedInstance]showFamilyManagerView:self.view];
            [self clean];
            
            break;
            
        case 300:{
            
            [_searText resignFirstResponder];
            
        }
            break;
            
        default:
            break;
    }
    
   
    
}



-(void)clean{
    
    [_searText resignFirstResponder];
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
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
