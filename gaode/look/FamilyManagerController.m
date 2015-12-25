//
//  FamilyManagerController.m
//  
//
//  Created by 我 on 15/10/19.
//
//

#import "FamilyManagerController.h"
#import "Masonry.h"
#import "FamilyManagerView.h"
#import "Header.h"
#import "EGOImageView.h"

@interface FamilyManagerController ()

@end

@implementation FamilyManagerController{
    
    EGOImageView *_guardianImg;
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    
    EGOImageView *_yeyeImg;
    UILabel *_yeyeLabel;
    EGOImageView *_nainaiImg;
    UILabel *_nainaiLabel;
    EGOImageView *_waigonImg;
    UILabel *_waigonLabel;
    EGOImageView *_waipuoImg;
    UILabel *_waipuoLabel;
    EGOImageView *_babaImg;
    UILabel *_babaLabel;
    EGOImageView *_mamaImg;
    UILabel *_mamaLabel;
    EGOImageView *_babayImg;
    UILabel *_babyLabel;
    EGOImageView *_backgroundImg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"家人管理"];
    [self initView];
}

-(void)initView{
    
    _titleLabel = [UILabel new];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH/2 - 120);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    _titleLabel.text = @"当前看护人为";
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textAlignment = NSTextAlignmentRight;
 
    _guardianImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_guardianImg];
    [_guardianImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH/2 - 30);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    UITapGestureRecognizer *guardianTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _guardianImg.tag = 100;
    _guardianImg.userInteractionEnabled = YES;
    [_guardianImg addGestureRecognizer:guardianTap];
    
    _statusLabel = [[UILabel alloc]init];
    [self.view addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH/2 + 40);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    _statusLabel.text = @"(爸爸)";
    _statusLabel.textColor = [UIColor greenColor];
    _statusLabel.font = [UIFont systemFontOfSize:13];
    
    _yeyeImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_yeyeImg];
    [_yeyeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    _yeyeImg.tag = 101;
    _yeyeImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *yeyeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_yeyeImg addGestureRecognizer:yeyeTap];
    
    _yeyeLabel = [UILabel new];
    [self.view addSubview:_yeyeLabel];
    [_yeyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(150);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    _yeyeLabel.textAlignment = NSTextAlignmentCenter;
    _yeyeLabel.text = @"爷爷";
    _yeyeLabel.font = [UIFont systemFontOfSize:13];
    
    _nainaiImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_nainaiImg];
    [_nainaiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    _nainaiImg.tag = 102;
    _nainaiImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *nainaiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_nainaiImg addGestureRecognizer:nainaiTap];
    
    _nainaiLabel = [UILabel new];
    [self.view addSubview:_nainaiLabel];
    [_nainaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(150);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    _nainaiLabel.text = @"奶奶";
    _nainaiLabel.font = [UIFont systemFontOfSize:13];
    _nainaiLabel.textAlignment = NSTextAlignmentCenter;
    
    _waigonImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_waigonImg];
    [_waigonImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 160);
        make.top.mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    _waigonImg.tag = 103;
    _waigonImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *waigonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_waigonImg addGestureRecognizer:waigonTap];
    
    _waigonLabel = [[UILabel alloc]init];
    [self.view addSubview:_waigonLabel];
    [_waigonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 160);
        make.top.mas_equalTo(150);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    _waigonLabel.textAlignment = NSTextAlignmentCenter;
    _waigonLabel.text = @"外公";
    _waigonLabel.font = [UIFont systemFontOfSize:13];
    
    _waipuoImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_waipuoImg];
    [_waipuoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 80);
        make.top.mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    _waipuoImg.tag = 104;
    _waipuoImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *waipuoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_waipuoImg addGestureRecognizer:waipuoTap];
    
    _waipuoLabel = [UILabel new];
    [self.view addSubview:_waipuoLabel];
    [_waipuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 80);
        make.top.mas_equalTo(150);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    _waipuoLabel.text = @"外婆";
    _waipuoLabel.textAlignment = NSTextAlignmentCenter;
    _waipuoLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *grayLabel1 = [UILabel new];
    [self.view addSubview:grayLabel1];
    [grayLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(170);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel1.backgroundColor = [UIColor greenColor];
    
    UILabel * grayLabel2 = [UILabel new];
    [self.view  addSubview:grayLabel2];
    [grayLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(130);
        make.top.mas_equalTo(170);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel2.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel3 = [UILabel new];
    [self.view addSubview:grayLabel3];
    [grayLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(190);
        make.size.mas_equalTo(CGSizeMake(80, 0.5));
    }];
    grayLabel3.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel4 = [UILabel new];
    [self.view addSubview:grayLabel4];
    [grayLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 130);
        make.top.mas_equalTo(170);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel4.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel5 = [UILabel new];
    [self.view addSubview:grayLabel5];
    [grayLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 50);
        make.top.mas_equalTo(170);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel5.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel6 = [UILabel new];
    [self.view addSubview:grayLabel6];
    [grayLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 130);
        make.top.mas_equalTo(190);
        make.size.mas_equalTo(CGSizeMake(80, 0.5));
    }];
    grayLabel6.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel7 = [UILabel new];
    [self.view addSubview:grayLabel7];
    [grayLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(90);
        make.top.mas_equalTo(190);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel7.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel8 = [UILabel new];
    [self.view addSubview:grayLabel8];
    [grayLabel8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 90);
        make.top.mas_equalTo(190);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel8.backgroundColor = [UIColor greenColor];
    
    _babaImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_babaImg];
    [_babaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(210);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    _babaImg.tag = 105;
    _babaImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *babaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_babaImg addGestureRecognizer:babaTap];
    
    _babaLabel = [UILabel new];
    [self.view addSubview:_babaLabel];
    [_babaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(300);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    _babaLabel.text = @"爸爸";
    _babaLabel.textAlignment = NSTextAlignmentCenter;
    _babaLabel.font = [UIFont systemFontOfSize:13];
    
    _mamaImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_mamaImg];
    [_mamaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 160);
        make.top.mas_equalTo(210);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    _mamaImg.tag = 106;
    UITapGestureRecognizer *mamaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _mamaImg.userInteractionEnabled = YES;
    [_mamaImg addGestureRecognizer:mamaTap];
    
    _mamaLabel = [UILabel new];
    [self.view addSubview:_mamaLabel];
    [_mamaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 160);
        make.top.mas_equalTo(300);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    _mamaLabel.text = @"妈妈";
    _mamaLabel.textAlignment = NSTextAlignmentCenter;
    _mamaLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *grayLabel9 = [UILabel new];
    [self.view addSubview:grayLabel9];
    [grayLabel9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(320);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel9.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel10 = [UILabel new];
    [self.view addSubview:grayLabel10];
    [grayLabel10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 120);
        make.top.mas_equalTo(320);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel10.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel11 = [UILabel new];
    [self.view addSubview:grayLabel11];
    [grayLabel11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(340);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 240, 0.5));
    }];
    grayLabel11.backgroundColor = [UIColor greenColor];
    
    UILabel *grayLabel12 = [UILabel new];
    [self.view addSubview:grayLabel12];
    [grayLabel12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(160);
        make.top.mas_equalTo(340.5);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    grayLabel12.backgroundColor = [UIColor greenColor];
    
    _babayImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_kanzhe_nainai"]];
    [self.view addSubview:_babayImg];
    [_babayImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(360);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    _babayImg.tag = 107;
    UITapGestureRecognizer *babyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    _babayImg.userInteractionEnabled = YES;
    [_babayImg addGestureRecognizer:babyTap];
    
    _babyLabel = [UILabel new];
    [self.view addSubview:_babyLabel];
    [_babyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(450);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    _babyLabel.text = @"狮子";
    _babyLabel.textAlignment = NSTextAlignmentCenter;
    _babyLabel.font = [UIFont systemFontOfSize:13];
    
    _backgroundImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"img_saisai_hdzt1"]];
    [self.view addSubview:_backgroundImg];
    [_backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(SCREEN_HEIGHT - 174);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 110));
    }];
}

#pragma mark -- UITapGestureRecognizer Action
-(void)onTap:(UITapGestureRecognizer *)sender{
    
    [[FamilyManagerView sharedInstance] showFamilyManagerView:self.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
