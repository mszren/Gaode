//
//  QuickLoginController.m
//  gaode
//
//  Created by 我 on 15/10/30.
//  Copyright © 2015年 我. All rights reserved.
//

#import "QuickLoginController.h"
#import "Header.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "UMSocial.h"
#import "LoginController.h"
#import "RegisterFirstController.h"

#define BTN_WIDTH (SCREEN_WIDTH - 141)/6
@interface QuickLoginController ()

@end

@implementation QuickLoginController{
    
    EGOImageView *_backgroundImg;
    UIButton *_registerBtn;
    UIButton *_loginBtn;
    UIButton *_weiboBtn;
    UIButton *_qqBtn;
    UIButton *_weichatBtn;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

-(void)initView{
    
    _backgroundImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_kanzhe_czsbg"]];
    [self.view addSubview:_backgroundImg];
    [_backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    _backgroundImg.userInteractionEnabled = YES;
    
    NSArray *titles = @[@"手机号注册",@"已有账号登录"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backgroundImg addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(37 + ((SCREEN_WIDTH - 118)/2 + 44)*i);
            make.top.mas_equalTo(SCREEN_HEIGHT - 190);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 118)/2, 40));
        }];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100 + i;
        button.adjustsImageWhenHighlighted = NO;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *grayLabel1 = [UILabel new];
    [_backgroundImg addSubview:grayLabel1];
    [grayLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(SCREEN_HEIGHT - 108);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 80)/2, 0.5));
    }];
    grayLabel1.backgroundColor = [UIColor whiteColor];
    
    UILabel *grayLabel2 = [UILabel new];
    [_backgroundImg addSubview:grayLabel2];
    [grayLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH - 80)/2 + 68);
        make.top.mas_equalTo(SCREEN_HEIGHT - 108);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 80)/2, 0.5));
    }];
    grayLabel2.backgroundColor = [UIColor whiteColor];
    
    EGOImageView *orImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_xt_or"]];
    [_backgroundImg addSubview:orImg];
    [orImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH - 80)/2 + 30);
        make.top.mas_equalTo(SCREEN_HEIGHT - 118);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    NSArray *loginStyles = @[@"btn_xt_sina",@"btn_xt_qq",@"btn_xt_weixin"];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backgroundImg addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BTN_WIDTH + (BTN_WIDTH*2 + 47)*i);
            make.top.mas_equalTo(SCREEN_HEIGHT - 80);
            make.size.mas_equalTo(CGSizeMake(47, 47));
        }];
        button.tag = 200 + i;
        button.adjustsImageWhenHighlighted = NO;
        [button setImage:[UIImage imageNamed:loginStyles[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            
            RegisterFirstController *registerVc = [RegisterFirstController new];
            [self.navigationController pushViewController:registerVc animated:YES];
        }
            
            break;
        case 101:{
            
            LoginController *loginVc = [LoginController new];
            [self.navigationController pushViewController:loginVc animated:YES];
        }
            
            break;
        case 200:{
            
            //新浪微博授权登陆
            
            
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                
                //判断是否处于授权状态
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    NSLog(@"SnsInformation is %@",response.data);
                    
                }else{
                    
                    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
                    
                    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                        
                        //          获取微博用户名、uid、token等
                        
                        if (response.responseCode == UMSResponseCodeSuccess) {
                            
                            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                            
                            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                            
                        }});
                    
                }
                
                
            }];
        }
            
            break;
        case 201:{
            
            //QQ授权登陆
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                //          获取微博用户名、uid、token等
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                    
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                }});
        }
            
            break;
        case 202:{
            
            //微信授权登陆
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
                    
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                }
                
            });
        }
            
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
