//
//  SelectAdressView.m
//  gaode
//
//  Created by 我 on 15/10/29.
//  Copyright © 2015年 我. All rights reserved.
//

#import "SelectAdressView.h"
#import "Header.h"
#import <UIKit/UIKit.h>

@implementation SelectAdressView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showSelectAdressView:(id<SelectAdressViewDelegate>)delegate andTag:(NSInteger)tag{
   
    self.delegate = delegate;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(10, 69, 100, 60)];
    _backGroundView.backgroundColor = [UIColor blackColor];
    _backGroundView.alpha = 0.3;
    _backGroundView.layer.cornerRadius = 4;
    _backGroundView.clipsToBounds = YES;
    _backGroundView.userInteractionEnabled = YES;
    _backGroundView.layer.shouldRasterize = YES;
    [_viewController.view addSubview:_backGroundView];
    
 
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [_viewController.view addGestureRecognizer:tap];
    
    
    UILabel *whiteLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 29, 80, 0.5)];
    whiteLabel.backgroundColor = [UIColor whiteColor];
    [_backGroundView addSubview:whiteLabel];
    
    NSArray *title = @[@"利辛乐园",@"阜阳乐园"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.alpha = 0.5;
        button.frame = CGRectMake(0, 0 + 30*i, 100, 30);
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        button.tag = 100 + i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:button];
    }
 
    _oldBtn = (UIButton *)[_backGroundView viewWithTag:tag];
    _oldBtn.selected = YES;
    
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
-(void)onTap{
    [self clean];
}

#pragma  mark  -- UIButton Action
-(void)onBtn:(UIButton *)sender{
 
        
        UIButton *button = (UIButton *)[_backGroundView viewWithTag:sender.tag];
        button.selected = !button.selected;
        _oldBtn.selected = !_oldBtn.selected;
        _oldBtn = button;
        
        [self.delegate SelectAdressViewDelegateWithTag:button.titleLabel.text];
  
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

