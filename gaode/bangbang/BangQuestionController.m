//
//  BangQuestionController.m
//  gaode
//
//  Created by 我 on 15/10/27.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BangQuestionController.h"
#import "Masonry.h"
#import "Header.h"
#import "PublishAlbumTopView.h"
#import "UzysAssetsPickerController.h"

@interface BangQuestionController ()<UITextFieldDelegate,UITextViewDelegate,PublishAlbumTopViewDelegate,UzysAssetsPickerControllerDelegate>

@end

@implementation BangQuestionController{
    
    UIView *_backgroundView;
    UITextField *_titleText;
    UITextView *_textView;
    UILabel *_coverLabel;
    PublishAlbumTopView *_publishAlbumTopView;
    UzysAssetsPickerController* _picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"描述你的问题"];
    self.view.backgroundColor = [UIColor greenColor];
    [self initView];
}

-(void)initView{
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _backgroundView = [UIView new];
    [self.view addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 330));
    }];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    
    _titleText = [UITextField new];
    [_backgroundView addSubview:_titleText];
    [_titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 13));
    }];
    _titleText.placeholder = @"标题";
    _titleText.font = [UIFont systemFontOfSize:13];
    _titleText.delegate = self;
    
    UILabel  *grayLabel1 = [UILabel new];
    [_backgroundView addSubview:grayLabel1];
    [grayLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(53);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    grayLabel1.backgroundColor = [UIColor greenColor];
    
    _textView = [UITextView new];
    [_backgroundView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(63);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 90));
    }];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.delegate = self;
    
    _coverLabel = [UILabel new];
    [_textView addSubview:_coverLabel];
    [_coverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.top.mas_equalTo(9);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 13));
    }];
    _coverLabel.text = @"尽可能清晰、详尽的将你的问题描述出来...";
    _coverLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *grayLabel2 = [UILabel new];
    [_backgroundView addSubview:grayLabel2];
    [grayLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(160);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    grayLabel2.backgroundColor = [UIColor greenColor];
    
    UILabel *promtLabel = [UILabel new];
    [_backgroundView addSubview:promtLabel];
    [promtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(190);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 13));
    }];
    promtLabel.text = @"最多可添加3张图";
    promtLabel.font = [UIFont systemFontOfSize:13];
    
    _publishAlbumTopView = [[PublishAlbumTopView alloc] init];
    [_publishAlbumTopView setViewDefault];
    [_backgroundView addSubview:_publishAlbumTopView];
    [_publishAlbumTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(210);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,48 + PublishImageTileHeight));
    }];
    _publishAlbumTopView.delegate = self;
    _publishAlbumTopView.imageMaxCount = 3;
    
    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = 0;
    _picker.maximumNumberOfSelectionPhoto = 3 ;
}

#pragma mark PublishAlbumTopViewDelegate
- (void)showPickImgs:(NSMutableArray*)dataList
{
    
#if 0
    UzysAppearanceConfig *appearanceConfig = [[UzysAppearanceConfig alloc] init];
    appearanceConfig.finishSelectionButtonColor = [UIColor blueColor];
    appearanceConfig.assetsGroupSelectedImageName = @"checker.png";
    appearanceConfig.cellSpacing = 1.0f;
    appearanceConfig.assetsCountInALine = 4;
    [UzysAssetsPickerController setUpAppearanceConfig:appearanceConfig];
#endif
    _picker.delegate = self;
    [self presentViewController:_picker
                       animated:YES
                     completion:^{
                         
                     }];
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [_publishAlbumTopView addImgUrls:assets];
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

#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_titleText resignFirstResponder];
    return YES;
}

#pragma mark-- UITextFieldDelegate
- (void)textViewDidChange:(UITextView*)textView
{
    _textView.text = textView.text;
    if (_textView.text.length == 0) {
        _coverLabel.text = @"尽可能清晰、详尽的将你的问题描述出来...";
    }
    else {
        _coverLabel.text = @"";
    }
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [_textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
