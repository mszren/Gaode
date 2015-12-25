//
//  GrowTreeCommentView.m
//  gaode
//
//  Created by 我 on 15/11/3.
//  Copyright © 2015年 我. All rights reserved.
//

#import "GrowTreeCommentView.h"
#import "DaiDodgeKeyboard.h"
#import "Header.h"

@implementation GrowTreeCommentView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (void)showGrowTreeCommentView:(NSString *)placehodel andBtnTitle:(NSString *)title withDelegate:(id<GrowTreeCommentViewDelegate>)delegate{
    self.delegate = delegate;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.window.rootViewController.view];
    
 
  
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.userInteractionEnabled = YES;
    [_viewController.view addSubview:_backGroundView];
    
    _commentText = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 80, 30)];
    _commentText.placeholder = placehodel;
    _commentText.borderStyle = UITextBorderStyleRoundedRect;
    _commentText.font = [UIFont systemFontOfSize:15];
    [_backGroundView addSubview:_commentText];
    _commentText.delegate = self;
    
    _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _publishBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 7, 50, 26);
    [_publishBtn setTitle:title forState:UIControlStateNormal];
    _publishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _publishBtn.backgroundColor = [UIColor greenColor];
    _publishBtn.layer.cornerRadius = 4;
    _publishBtn.tag = 200;
    _publishBtn.clipsToBounds = YES;
    _publishBtn.layer.shouldRasterize = YES;
    [_publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _publishBtn.adjustsImageWhenHighlighted = NO;
    [_backGroundView addSubview:_publishBtn];
    [_publishBtn addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 40);
    [cleanBtn addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_viewController.view addSubview:cleanBtn];
    cleanBtn.tag = 100;
    
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

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [_commentText resignFirstResponder];
    return YES;
}

#pragma mark -- UIButton Action
- (void)onPublishBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 200:
            if (_commentText.text != nil && _commentText.text.length > 0 ) {
                [self.delegate growTreeCommentViewDelegateWithComment:_commentText.text];
            }
            break;
            
        default:
            break;
    }
    [_commentText resignFirstResponder];
    [self clean];
}

-(void)clean{
    
    
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
