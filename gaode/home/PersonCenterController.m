//
//  PersonCenterController.m
//  gaode
//
//  Created by 我 on 15/11/4.
//  Copyright © 2015年 我. All rights reserved.
//

#import "PersonCenterController.h"
#import "Header.h"
#import <Masonry.h>
#import "EGOImageView.h"
#import "UzysAssetsPickerController.h"
#import "HomeEditController.h"
#import "SexEditView.h"
#import "CityPickerView.h"
#import "MycodeController.h"

@interface PersonCenterController () <UzysAssetsPickerControllerDelegate,SexEditViewDelegate,CityPickerViewDelegate>

@end

@implementation PersonCenterController{
    
    UIScrollView *_scrollView;
    UIButton * _sexBtn;
    UIView *_faceView;
    EGOImageView *_faceImg;
    UIView *_nichengView;
    UILabel *_nichengLabel;
    UIView *_addressView;
    UILabel *_addressLabel;
    UIView *_sexView;
    UILabel *_sexLabel;
    UIView *_codeView;
    
    UzysAssetsPickerController* _picker;
    NSMutableArray *_arrImg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"个人资料"];
    [self initView];
}

- (void)initView{
    
    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = 0;
    _picker.maximumNumberOfSelectionPhoto = 1;
    _picker.delegate = self;
    
    _scrollView = [UIScrollView new];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64));
    }];
    _scrollView.backgroundColor = [UIColor orangeColor];
    
    EGOImageView *backrroundImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_wojia"]];
    [_scrollView addSubview:backrroundImg];
    [backrroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 200));
    }];
    
    _sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backrroundImg addSubview:_sexBtn];
    [_sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(160);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    [_sexBtn setTitle:@"男" forState:UIControlStateNormal];
    _sexBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_sexBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sexBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 10);
    _sexBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 15);
    [_sexBtn setImage:[UIImage imageNamed:@"ic_wojia_nan"] forState:UIControlStateNormal];
    _sexBtn.adjustsImageWhenHighlighted = NO;
    _sexBtn.layer.cornerRadius = 15;
    _sexBtn.backgroundColor = [UIColor blackColor];
    _sexBtn.alpha = 0.2;
    _sexBtn.clipsToBounds = YES;
    _sexBtn.layer.shouldRasterize = YES;

    _faceView = [UIView new];
    [_scrollView addSubview:_faceView];
    [_faceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(210);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _faceView.backgroundColor = WHITE_COLOR;
    _faceView.userInteractionEnabled = YES;
    
    EGOImageView *faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_txpic"]];
    [_faceView addSubview:faceImg];
    [faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *faceLabel = [UILabel new];
    [_faceView addSubview:faceLabel];
    [faceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    faceLabel.text = @"修改头像";
    faceLabel.font = [UIFont systemFontOfSize:13];
 
    _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"bg_wojia"]];
    [_faceView addSubview:_faceImg];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 50);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    _faceImg.tag = 100;
    UITapGestureRecognizer *faceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_faceImg addGestureRecognizer:faceTap];
    _faceImg.userInteractionEnabled = YES;
    
    _nichengView = [UIView new];
    [_scrollView addSubview:_nichengView];
    [_nichengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(270.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _nichengView.backgroundColor = WHITE_COLOR;
    _nichengView.userInteractionEnabled = YES;
    _nichengView.tag = 101;
    UITapGestureRecognizer *nichengTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_nichengView addGestureRecognizer:nichengTap];
    
    EGOImageView *nichengImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_name"]];
    [_nichengView addSubview:nichengImg];
    [nichengImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *nichengLabel = [UILabel new];
    [_nichengView addSubview:nichengLabel];
    [nichengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    nichengLabel.text = @"昵称";
    nichengLabel.font = [UIFont systemFontOfSize:13];
    
    _nichengLabel = [UILabel new];
    [_nichengView addSubview:_nichengLabel];
    [_nichengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 110);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    _nichengLabel.text = @"迷失之刃";
    _nichengLabel.textAlignment = NSTextAlignmentRight;
    _nichengLabel.font = [UIFont systemFontOfSize:13];
    
    _addressView = [UIView new];
    [_scrollView addSubview:_addressView];
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(331.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _addressView.backgroundColor = WHITE_COLOR;
    _addressView.userInteractionEnabled = YES;
    _addressView.tag = 102;
    UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_addressView addGestureRecognizer:addressTap];
    
    EGOImageView *addressImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_add"]];
    [_addressView addSubview:addressImg];
    [addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *addressLabel = [UILabel new];
    [_addressView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    addressLabel.text = @"地点";
    addressLabel.font = [UIFont systemFontOfSize:13];
    
    _addressLabel = [UILabel new];
    [_addressView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 110);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    _addressLabel.text = @"合肥";
    _addressLabel.textAlignment = NSTextAlignmentRight;
    _addressLabel.font = [UIFont systemFontOfSize:13];
    
    _sexView = [UIView new];
    [_scrollView addSubview:_sexView];
    [_sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(392.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _sexView.backgroundColor = WHITE_COLOR;
    _sexView.userInteractionEnabled = YES;
    _sexView.tag = 103;
    UITapGestureRecognizer *sexTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_sexView addGestureRecognizer:sexTap];
    
    EGOImageView *sexImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_xb"]];
    [_sexView addSubview:sexImg];
    [sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *sexLabel = [UILabel new];
    [_sexView addSubview:sexLabel];
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    sexLabel.text = @"性别";
    sexLabel.font = [UIFont systemFontOfSize:13];
    
    _sexLabel = [UILabel new];
    [_sexView addSubview:_sexLabel];
    [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 110);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    _sexLabel.text = @"男";
    _sexLabel.textAlignment = NSTextAlignmentRight;
    _sexLabel.font = [UIFont systemFontOfSize:13];
    
    _codeView = [UIView new];
    [_scrollView addSubview:_codeView];
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(453.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _codeView.backgroundColor = WHITE_COLOR;
    _codeView.userInteractionEnabled = YES;
    _codeView.tag = 104;
    UITapGestureRecognizer *codeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_codeView addGestureRecognizer:codeTap];
    
    EGOImageView *codeImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_wojia_ewm"]];
    [_codeView addSubview:codeImg];
    [codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(18.5);
        make.size.mas_equalTo(CGSizeMake(37, 23));
    }];
    
    UILabel *codeLabel = [UILabel new];
    [_codeView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    codeLabel.text = @"二维码图片";
    codeLabel.font = [UIFont systemFontOfSize:13];
    
    _scrollView.contentSize = CGSizeMake(0, 514);
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 100:{
            
            [_arrImg removeAllObjects];
            [self presentViewController:_picker
                               animated:YES
                             completion:^{
                                 
                             }];
        }
            break;
            
        case 101:{
            
            HomeEditController *editVc = [HomeEditController new];
            editVc.hidesBottomBarWhenPushed = YES;
            editVc.text = _nichengLabel.text;
            editVc.editBlock = ^(NSString * nicheng){
                _nichengLabel.text = nicheng;
            };
            [self.navigationController pushViewController:editVc animated:YES];
        }
            
            break;
        case 102:
            [[CityPickerView sharedInstance]showCityPickerView:_addressLabel.text andDelegate:self];
            break;
        case 103:{
            
            [[SexEditView sharedInstance] showEditView:_sexLabel.text andDelegate:self];
        }
            
            break;
        case 104:{
            
            MycodeController *myCodeVc = [MycodeController new];
            [self.navigationController pushViewController:myCodeVc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- SexEditViewDelegate
- (void)SexEditViewSelectSex:(NSString *)sex{
  
    _sexLabel.text = sex;
}

#pragma mark -- CityPickerViewDelegate
- (void)CityPickerViewReturnCity:(NSString *)resultCity{

    _addressLabel.text = resultCity;
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        
        [_arrImg addObjectsFromArray:assets];
        ALAsset* asset = assets[0];
        UIImage* tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        _faceImg.image = tempImg;
        
    }
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController*)picker
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedStringFromTable(@"已经超出上传图片数量！", @"UzysAssetsPickerController", nil)
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
