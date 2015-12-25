//
//  publishVIew.m
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "FirstTagView.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"

#define WIDTH (SCREEN_WIDTH - 240)/4
@implementation FirstTagView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showFirstTagView:(id<FirstTagViewDelegate>)delegate{
    
    self.delegate = delegate;

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
  
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, 200, 50)];
    titleLabel.text = @"请选择宝宝大事记标签";
    titleLabel.textColor = GREEN_COLOR;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [_backGroundView addSubview:titleLabel];
    
    NSInteger k = 1;
    NSArray *titles = @[@[@". 哭 .",@". 喊妈妈 .",@". 爬 ."],@[@". 走路 .",@". 跑 .",@". 坐车 ."]];
    for (NSInteger i = 0; i < titles.count; i++) {
        for (NSInteger j = 0; j < 3; j++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(WIDTH + ( 80 +WIDTH)*j, 50 + 35*i, 80, 25);
            [button setTitle:titles[i][j] forState:UIControlStateNormal];
            button.adjustsImageWhenHighlighted = NO;
            button.tag = 100 + k;
            k++;
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_backGroundView addSubview:button];
            [button addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];

        }
        
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
        case 100:{
            
            [self.delegate FirstTagViewDelegateWithTag:self.tag];
            [self clean];
        }
            break;
            
        default:{
            
            
            UIButton * button = (UIButton *)[_backGroundView viewWithTag:sender.tag];
            self.tag = button.titleLabel.text;
            button.layer.borderWidth = 1;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.9, 0, 0, 1 });
            CGColorSpaceRelease(colorSpace);
            button.layer.borderColor = borderColorRef;
            CGColorRelease(borderColorRef);
            
            _oldBtn.layer.borderWidth = 0;
            _oldBtn = button;
            
        }
            break;
    }
    

    
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
