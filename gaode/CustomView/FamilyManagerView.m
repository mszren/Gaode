//
//  publishVIew.m
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "FamilyManagerView.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"
#import "SearchAccountView.h"

#define WIDTH (SCREEN_WIDTH - 150)/6
@implementation FamilyManagerView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showFamilyManagerView:(UIView *)view{

    self.view = view;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
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
  
    NSArray *imgArry = @[@"ic_kanzhe_yydx",@"ic_kanzhe_yyewm",@"ic_kanzhe_qtr"];
    for (NSInteger i = 0; i < imgArry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH + (50 + WIDTH*2)*i , 55, 50, 50);
        [button setBackgroundImage:[UIImage imageNamed:imgArry[i]] forState:UIControlStateNormal];
        button.layer.cornerRadius = 25;
        button.clipsToBounds = YES;
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 200 + i;
        [_backGroundView addSubview:button];
        
    }
    
    NSArray *namesArry = @[@"查找账号",@"面对面",@"新用户"];
    for (NSInteger i = 0; i < namesArry.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0 + SCREEN_WIDTH/3*i , 120, SCREEN_WIDTH/3, 13)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.text = namesArry[i];
        [_backGroundView addSubview:label];
    }
    
 
    
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


#pragma mark
#pragma mark -- UIButton Action
-(void)onPublishBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 100:
            
            break;
        case 200:
            [[SearchAccountView sharedInstance]showSearchAccountView:self.view];
            break;
        case 201:
            
            break;
        case 202:{
            [self showShareView];
            
        }
            
            break;
            
        default:
            break;
    }
    
    [self clean];
    
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
