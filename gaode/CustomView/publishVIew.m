//
//  publishVIew.m
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "publishVIew.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"
#import "SelectPublicView.h"
#import "MessageController.h"

#define WIDTH (SCREEN_WIDTH - 100)/3
@implementation publishVIew

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showPublishView:(BaseNavController *)viewController{
    
  
    self.naVc = viewController;
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
    
    NSArray *types = @[@"btn_kanzhe_flyb",@"btn_kanzhe_fczs"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        publishBtn.tag = 200 + i;
        publishBtn.adjustsImageWhenHighlighted = NO;
        publishBtn.frame = CGRectMake(WIDTH + (WIDTH + 50)*i , 60, 50, 50);
        [publishBtn setImage:[UIImage imageNamed:types[i]] forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:publishBtn];
    }
    
    NSArray * names = @[@"留言",@"浇水"];
    for (NSInteger i =0; i < 2; i ++) {
        UILabel * publishLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH + (WIDTH + 50)*i , 120, 50, 20)];
        publishLabel.text = names[i];
        publishLabel.textAlignment = NSTextAlignmentCenter;
        publishLabel.font = [UIFont systemFontOfSize:11];
        publishLabel.textColor =  [UIColor blackColor];
        [_backGroundView addSubview:publishLabel];
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
#pragma mark -- NSNotificationCenter
- (void)tapCloseAction:(id)sender{
    [self clean];
}

#pragma mark
#pragma mark -- UIButton Action
-(void)onPublishBtn:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case 200:{
         
            [UIView animateWithDuration:1 animations:^{
                
                MessageController *messageVc = [[MessageController alloc]init];
                messageVc.hidesBottomBarWhenPushed = YES;
                [self.naVc pushViewController:messageVc animated:YES];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case 201:
            
            [[SelectPublicView sharedInstance] showSelectPublicView:self.naVc];
              
            
            break;
            
        default:
            break;
    }
    
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
