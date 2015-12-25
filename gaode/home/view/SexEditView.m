//
//  SexEditView.m
//  gaode
//
//  Created by 我 on 15/11/4.
//  Copyright © 2015年 我. All rights reserved.
//

#import "SexEditView.h"
#import "Header.h"

@implementation SexEditView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showEditView:(NSString *)sex andDelegate:(id<SexEditViewDelegate>)delegate{
    self.selectSex = sex;
    self.deldegate = delegate;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    self.window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_viewController.view addGestureRecognizer:tap];
    _viewController.view.tag = 100;
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT/2 - 71, SCREEN_WIDTH - 80, 142.5)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.cornerRadius = 6;
    _backGroundView.clipsToBounds = YES;
    _backGroundView.layer.shouldRasterize = YES;
    _backGroundView.layer.rasterizationScale = [[UIScreen mainScreen]scale];
    [_viewController.view addSubview:_backGroundView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 80, 60)];
    _titleLabel.text = @"选择性别";
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.tag = 101;
    [_backGroundView addSubview:_titleLabel];
    UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)   ];
    [_titleLabel addGestureRecognizer:titleTap];
    
    UILabel *greenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 61, SCREEN_WIDTH - 80, 1)];
    greenLabel.backgroundColor = [UIColor blueColor];
    [_backGroundView addSubview:greenLabel];
    UITapGestureRecognizer *greenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [greenLabel addGestureRecognizer:greenTap];
    
    UIView *boyView = [[UIView alloc]initWithFrame:CGRectMake(0, 62, SCREEN_WIDTH - 80, 40)];
    boyView.backgroundColor = [UIColor whiteColor];
    [_backGroundView addSubview:boyView];
    boyView.tag = 102;
    UITapGestureRecognizer *boyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [boyView addGestureRecognizer:boyTap];
    
    _boyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    _boyLabel.text = @"男";
    _boyLabel.tag = 202;
    _boyLabel.font = [UIFont systemFontOfSize:15];
    [boyView addSubview:_boyLabel];
    
    UIButton *boyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    boyBtn.frame = CGRectMake(SCREEN_WIDTH - 120, 10, 20, 20);
    [boyBtn setImage:[UIImage imageNamed:@"ic_xt_delete"] forState:UIControlStateNormal];
    [boyBtn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateSelected];
    boyBtn.adjustsImageWhenHighlighted = NO;
    boyBtn.userInteractionEnabled = NO;
    [boyView addSubview:boyBtn];
    
    UIView *girlView = [[UIView alloc]initWithFrame:CGRectMake(0, 102.5, SCREEN_WIDTH - 80, 40)];
    girlView.backgroundColor = [UIColor whiteColor];
    [_backGroundView addSubview:girlView];
    girlView.tag = 104;
    UITapGestureRecognizer *girlTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [girlView addGestureRecognizer:girlTap];
    
    _girlLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    _girlLabel.text = @"女";
    _girlLabel.tag = 204;
    _girlLabel.font = [UIFont systemFontOfSize:15];
    [girlView addSubview:_girlLabel];
    
    UIButton *girlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    girlBtn.frame = CGRectMake(SCREEN_WIDTH - 120, 10, 20, 20);
    [girlBtn setImage:[UIImage imageNamed:@"ic_xt_delete"] forState:UIControlStateNormal];
    [girlBtn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateSelected];
    girlBtn.adjustsImageWhenHighlighted = NO;
    girlBtn.userInteractionEnabled = NO;
    [girlView addSubview:girlBtn];
    
    UILabel *hGrayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 102, SCREEN_WIDTH - 80, 0.5)];
    hGrayLabel.backgroundColor = [UIColor grayColor];
    [_backGroundView addSubview:hGrayLabel];
    
    if ([sex isEqualToString:@"男"]) {
        boyBtn.selected = YES;
    }else{
        girlBtn.selected = YES;
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
            
            _backGroundView.layer.shouldRasterize = NO;
        }];
        
    });
    
    
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    if (sender.view.tag == 102 || sender.view.tag == 104) {
        
        UILabel *label = (UILabel *)[_backGroundView viewWithTag:sender.view.tag + 100];
        self.selectSex = label.text;
        [self.deldegate SexEditViewSelectSex:self.selectSex];
        [self clean];
    }else if (sender.view.tag == 101){
        
    }else{
        
        [self clean];
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
                self.window.alpha = 0;
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
