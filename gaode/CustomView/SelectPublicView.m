//
//  SelectPublicView.m
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "SelectPublicView.h"
#import "Header.h"
#import "PublishController.h"


#define WIDTH (SCREEN_WIDTH - 200)/4

@implementation SelectPublicView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showSelectPublicView:(UINavigationController *)viewController{
    
    self.naVc = viewController;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    self.viewController = [[UIViewController alloc]init];
    self.viewController.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.viewController;
    
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 15)];
    title.text = @"选择发布类型";
    title.font = [UIFont systemFontOfSize:15];
    title.textAlignment = NSTextAlignmentCenter;
    [self.viewController.view addSubview:title];
    
    NSArray *images = @[@"btn_kanzhe_fsp",@"btn_kanzhe_fyy",@"btn_kanzhe_fpic",@"btn_kanzhe_fxq"];
    for (NSInteger i = 0; i < images.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO;
        button.tag = 100 + i;
        button.frame = CGRectMake( WIDTH/2 + (WIDTH + 50)*i, 220, 50, 50);
        [button addTarget:self action:@selector(onStyleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [self.viewController.view addSubview:button];
    }
    
    NSArray *names = @[@"发视频",@"发语音",@"发照片",@"发心情"];
    for (NSInteger i = 0; i < names.count; i++) {
        UILabel * typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 + (WIDTH + 50)*i, 270, 50, 50)];
        typeLabel.text = names[i];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.font = [UIFont systemFontOfSize:13];
        [self.viewController.view addSubview:typeLabel];
    }
    
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 25, SCREEN_HEIGHT - 90, 50, 50);
    [deleteBtn setImage:[UIImage imageNamed:@"btn_kanzhe_close"] forState:UIControlStateNormal];
    deleteBtn.tag = 200;
    deleteBtn.adjustsImageWhenHighlighted = NO;
    [deleteBtn addTarget:self action:@selector(onStyleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewController.view addSubview:deleteBtn];
    
    
    //The window has to be un-hidden on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.window makeKeyAndVisible];
        
        self.viewController.view.alpha = 0;
        self.viewController.view.layer.shouldRasterize = YES;
        self.viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        [UIView animateWithDuration:DRUATIONTIME animations:^{
           
            self.viewController.view.alpha = 1;
            self.viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:DRUATIONTIME2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewController.view.alpha = 1;
               self.viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            } completion:^(BOOL finished2) {
                
                self.viewController.view.layer.shouldRasterize = NO;
            }];
        }];
        
    });
    
}

#pragma mark
#pragma mark -- UIButton Action
-(void)onStyleBtn:(UIButton *)sender{
    
    [self cleanUp];
    
    switch (sender.tag) {
        case 100:
            
            break;
            
        case 101:
            
            break;
        case 102:
            
            break;
            
        case 103:{
            
            [UIView animateWithDuration:1 animations:^{
                
                PublishController *pulishVc = [[PublishController alloc]init];
                pulishVc.hidesBottomBarWhenPushed = YES;
                [self.naVc pushViewController:pulishVc animated:YES];
            } completion:^(BOOL finished) {
                
            }];

        }
            
            break;
            
        default:
            break;
    }
    
    
}

-(void)cleanUp{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.viewController.view.layer.shouldRasterize = YES;
        
        [UIView animateWithDuration:DRUATIONTIME animations:^{
            
            self.viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:DRUATIONTIME2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewController.view.alpha = 0;
                self.viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            } completion:^(BOOL finished2) {
                
                [[[[UIApplication sharedApplication] delegate]window]makeKeyWindow];
                [self.window removeFromSuperview];
                self.viewController = nil;
                self.window = nil;
            }];
        }];
        
    });
}

@end
