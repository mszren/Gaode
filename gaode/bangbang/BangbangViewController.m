//
//  BangbangViewController.m
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "BangbangViewController.h"
#import "KGModal.h"
#import "HYActivityView.h"
#import "UMSocial.h"


@interface BangbangViewController ()

@property (nonatomic, strong) HYActivityView *activityView;

@end

@implementation BangbangViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setWhiteNavBg];
    [self initializeNavTitleView:@"帮帮"];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:@"中间弹出视图" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareBtn.frame = CGRectMake(100, 150, 100, 40);
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareBtn setTitle:@"分享弹出视图" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(onShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    NSArray * name = @[@"btn_xt_sina",@"btn_xt_qq",@"btn_xt_weixin"];
    for (NSInteger i = 0; i < name.count; i++) {
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(50 + 70*i, 220, 40, 40);
        loginBtn.tag = 100 + i;
        [loginBtn setImage:[UIImage imageNamed:name[i]] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(onLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginBtn];
    }
    
    NSArray * type = @[@"发语音",@"发视频"];
    for (NSInteger i = 0; i < type.count ; i++) {
        
        UIButton * typeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        typeBtn.frame = CGRectMake(70 + 100*i,280, 80, 40);
        [typeBtn setTitle:type[i] forState:UIControlStateNormal];
        [self.view addSubview:typeBtn];
        typeBtn.tag = 103 + i;
        [typeBtn addTarget:self action:@selector(onLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:typeBtn];
    }
    
    
    
    [KGModal sharedInstance].closeButtonType = KGModalCloseButtonTypeRight;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShow:) name:KGModalWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShow:) name:KGModalDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide:) name:KGModalWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHide:) name:KGModalDidHideNotification object:nil];
}

-(void)onLoginBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            
            
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
            
        case 101:{
            
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
            
        case 102:{
            
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
            
        case 103:{
            
        }
            
            break;
        case 104:{
            
        }
            
            break;

            
        default:
            
            break;
    }
}

// 点击每个平台后默认会进入内容编辑页面，若想点击后直接分享内容，可以实现下面的回调方法。
//-(BOOL)isDirectShareInIconActionSheet{
//    return YES;
//}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

//分享弹出视图
-(void)onShareBtn:(UIButton *)sender{
    
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:self.view];
        
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

//是否支持横屏
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}

//中间弹出视图
-(void)onBtn:(UIButton *)sender{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 250)];
    
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Welcome to KGModal!";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:welcomeLabel];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect) + 50;
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"hello";
    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor blackColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:infoLabel];
    
    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
//    [contentView addSubview:btn];
    
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
 
}

- (void)willShow:(NSNotification *)notification{
    NSLog(@"will show");
}

- (void)didShow:(NSNotification *)notification{
    NSLog(@"did show");
}

- (void)willHide:(NSNotification *)notification{
    NSLog(@"will hide");
}

- (void)didHide:(NSNotification *)notification{
    NSLog(@"did hide");
}

- (void)changeCloseButtonType:(id)sender{
    UIButton *button = (UIButton *)sender;
    KGModal *modal = [KGModal sharedInstance];
    KGModalCloseButtonType type = modal.closeButtonType;
    
    if(type == KGModalCloseButtonTypeLeft){
        modal.closeButtonType = KGModalCloseButtonTypeRight;
        [button setTitle:@"Close Button Right" forState:UIControlStateNormal];
    }else if(type == KGModalCloseButtonTypeRight){
        modal.closeButtonType = KGModalCloseButtonTypeNone;
        [button setTitle:@"Close Button None" forState:UIControlStateNormal];
    }else{
        modal.closeButtonType = KGModalCloseButtonTypeLeft;
        [button setTitle:@"Close Button Left" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
