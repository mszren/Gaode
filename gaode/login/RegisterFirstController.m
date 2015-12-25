//
//  RegisterFirstController.m
//  gaode
//
//  Created by 我 on 15/10/30.
//  Copyright © 2015年 我. All rights reserved.
//

#import "RegisterFirstController.h"
#import "Header.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "DaiDodgeKeyboard.h"
#import "UzysAssetsPickerController.h"
#import "RegisterSecondController.h"

@interface RegisterFirstController () <UITextFieldDelegate,UzysAssetsPickerControllerDelegate>

@end

@implementation RegisterFirstController{
    
    UIButton *_faceBtn;
    UIButton *_oldBtn;
    UITextField *_nichengText;
    UITextField *_addressText;
    UzysAssetsPickerController* _picker;
    NSMutableArray *_arrImg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"注册1/3"];
    [self initView];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)initView{
    
    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = 0;
    _picker.maximumNumberOfSelectionPhoto = 1;
    _picker.delegate = self;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_faceBtn];
    [_faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH/2 - 45 );
        make.top.mas_equalTo(55);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    _faceBtn.adjustsImageWhenHighlighted = NO;
    _faceBtn.tag = 100;
    _faceBtn.layer.shouldRasterize = YES;
    [_faceBtn setImage:[UIImage imageNamed:@"btn_xt_txpic"] forState:UIControlStateNormal];
    [_faceBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *sexArry = @[@"帅哥",@"美女"];
    NSArray *nomalImgs = @[@"ic_xt_nan_normal",@"ic_xt_nv_normal"];
    NSArray *selectImgs = @[@"ic_xt_nan_selected",@"ic_xt_nv_selected"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_WIDTH - 170)/3 + (85 + (SCREEN_WIDTH - 170)/3)*i);
            make.top.mas_equalTo(220);
            make.size.mas_equalTo(CGSizeMake(85, 30));
        }];
        [button setTitle:sexArry[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tag = 200 + i;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 10);
        button.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 15);
        [button setImage:[UIImage imageNamed:nomalImgs[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImgs[i]] forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (button.selected == NO) {
            button.backgroundColor = [UIColor whiteColor];
        }else{
            button.backgroundColor = [UIColor greenColor];
        }
        button.layer.cornerRadius = 15;
        button.clipsToBounds = YES;
        button.layer.shouldRasterize = YES;
    }
    
    UIView *nichengView = [UIView new];
    [self.view addSubview:nichengView];
    [nichengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(280);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    nichengView.backgroundColor = [UIColor whiteColor];
    
    _nichengText = [UITextField new];
    [nichengView addSubview:_nichengText];
    [_nichengText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 60));
    }];
    _nichengText.backgroundColor = [UIColor whiteColor];
    _nichengText.placeholder = @"昵称";
    _nichengText.font = [UIFont systemFontOfSize:15];
    _nichengText.delegate = self;
    
    
    UIView *addressView = [UIView new];
    [self.view addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(341);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    addressView.backgroundColor = [UIColor whiteColor];
    
    _addressText = [UITextField new];
    [addressView addSubview:_addressText];
    [_addressText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 60));
    }];
    _addressText.backgroundColor = [UIColor whiteColor];
    _addressText.placeholder = @"所在地";
    _addressText.font = [UIFont systemFontOfSize:15];
    _addressText.delegate = self;

    EGOImageView *agreenImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_xt_dh"]];
    [self.view addSubview:agreenImg];
    [agreenImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(412);
        make.size.mas_equalTo(CGSizeMake(20, 17));
    }];
    
    UILabel *agreenLabel = [UILabel new];
    [self.view addSubview:agreenLabel];
    [agreenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (40);
        make.top.mas_equalTo(412);
        make.size.mas_equalTo(CGSizeMake(260, 13));
    }];
    agreenLabel.text = @"点击下一步，表示同意《用户协议》";
    agreenLabel.font = [UIFont systemFontOfSize:15];
    
    _oldBtn = (UIButton *)[self.view viewWithTag:200];
    _oldBtn.selected = YES;
    _oldBtn.backgroundColor = [UIColor greenColor];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_nichengText resignFirstResponder];
    [_addressText resignFirstResponder];
    return YES;
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    if (sender.tag == 100) {
        
        [_arrImg removeAllObjects];
        [self presentViewController:_picker
                           animated:YES
                         completion:^{
                             
                         }];
    }else{
        if (sender.tag != _oldBtn.tag) {
            
            UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag];
            button.selected = YES;
            button.backgroundColor = [UIColor greenColor];
            _oldBtn.selected = NO;
            _oldBtn.backgroundColor = [UIColor whiteColor];
            _oldBtn = button;
        }
    }
}

#pragma mark -- UIBarButtonItem Acyion
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
    RegisterSecondController *secondVc = [RegisterSecondController new];
    [self.navigationController pushViewController:secondVc animated:YES];
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        
        [_arrImg addObjectsFromArray:assets];
        _faceBtn.layer.cornerRadius = 45;
        _faceBtn.clipsToBounds = YES;
        ALAsset* asset = assets[0];
        UIImage* tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [_faceBtn setImage:tempImg forState:UIControlStateNormal];
        
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



//- (void)viewDidDisappear:(BOOL)animated{
//    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
