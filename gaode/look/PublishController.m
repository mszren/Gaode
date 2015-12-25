//
//  FamilyManagerController.m
//  
//
//  Created by 我 on 15/10/19.
//
//

#import "PublishController.h"
#import "Masonry.h"
#import "Header.h"
#import "MyDatePicker.h"
#import "FirstTagView.h"
#import "FeelingView.h"
#import "EditController.h"
#import "AudioView.h"
#import "PublishAlbumTopView.h"
#import "UzysAssetsPickerController.h"

#define ORIGIN_X SCREEN_WIDTH - 210
@interface PublishController ()<UITextViewDelegate,UIGestureRecognizerDelegate,MyDatePickerDelegate,FirstTagViewDelegate,FeelingViewDelegate,AudioViewDelegate,PublishAlbumTopViewDelegate,UzysAssetsPickerControllerDelegate>

@end

@implementation PublishController{
    
    UIView *_descripeView;
    UITextView *_textView;
    UILabel *_promptLabel;
    
    UIView *_dateView;
    UILabel * _datePromptLabel;
    UILabel * _dateLabel;
    
    UIView *_addressView;
    UILabel *_addressPromptLabel;
    UILabel *_addressLabel;
    UIView *_backgroundView;
    PublishAlbumTopView *_publishAlbumTopView;
    UIScrollView *_scrollView;
    UzysAssetsPickerController* _picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"发布"];
    [self initView];
}

-(void)initView{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(onPublishBtn:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64));
    }];
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = 0;
    _picker.maximumNumberOfSelectionPhoto = 9;
    
    [self addDescripeViw];
    [self addDateView];
    [self addAddressView];
    [self addPhotoView];
}

-(void)addDescripeViw{
    _descripeView = [[UIView alloc]init];
    [_scrollView addSubview:_descripeView];
    [_descripeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    _descripeView.backgroundColor = [UIColor whiteColor];
    [self addTextView];
    [self addPromptLabel];
    [self addSelectBtn];
}

-(void)addTextView{
    
    _textView = [[UITextView alloc]init];
    [_descripeView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.delegate = self;
    
}

-(void)addPromptLabel{
    
    _promptLabel = [[UILabel alloc]init];
    [_textView addSubview:_promptLabel];
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.top.mas_equalTo(9);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 13));
    }];
    _promptLabel.font = [UIFont systemFontOfSize:13];
    _promptLabel.text = @"宝宝此刻在笑、在走路...还是...";
}

-(void)addSelectBtn{
    
    for (NSInteger i = 0 ; i < 3; i++) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_descripeView addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10 + 30 *i);
            make.top.mas_equalTo(70);
            if (i == 2) {

                make.size.mas_equalTo(CGSizeMake(80, 20));
            }else{
                make.size.mas_equalTo(CGSizeMake(20, 20));
                selectBtn.layer.cornerRadius = 10;
                selectBtn.clipsToBounds = YES;
                
            }

        }];
        selectBtn.adjustsImageWhenHighlighted = NO;
        selectBtn.tag = 100 + i;
        [selectBtn setImage:[UIImage imageNamed:@"ic_kanzhe_zt_normal"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"ic_kanzhe_zt_selected"] forState:UIControlStateSelected];
        if (i == 2) {
            [selectBtn setTitle:@"第一次" forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:11];
            selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 60);
            selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        }
        [selectBtn addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)addDateView{
    
    _dateView = [[UIView alloc]init];
    [_scrollView addSubview:_dateView];
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(290);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    _dateView.backgroundColor = [UIColor whiteColor];
    [self addDatePrompLabel];
    [self addDateLabel];
}

-(void)addDatePrompLabel{
    
    _datePromptLabel = [[UILabel alloc]init];
    [_dateView addSubview:_datePromptLabel];
    [_datePromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    _datePromptLabel.text = @"记录时间";
    _datePromptLabel.font = [UIFont systemFontOfSize:13];
}

-(void)addPhotoView{
    _backgroundView = [UIView new];
    [_scrollView addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(110);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 170));
    }];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    
    UILabel *promtLabel = [UILabel new];
    [_backgroundView addSubview:promtLabel];
    [promtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 13));
    }];
    promtLabel.text = @"最多可添加9张图";
    promtLabel.font = [UIFont systemFontOfSize:13];
    
    _publishAlbumTopView = [[PublishAlbumTopView alloc] init];
    [_publishAlbumTopView setViewDefault];
    [_backgroundView addSubview:_publishAlbumTopView];
    [_publishAlbumTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,48 + PublishImageTileHeight));
    }];
    _publishAlbumTopView.delegate = self;
    _publishAlbumTopView.imageMaxCount = 9;
}

-(void)addDateLabel{
    
    _dateLabel = [[UILabel alloc]init];
    [_dateView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ORIGIN_X);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.font = [UIFont systemFontOfSize:13];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    _dateLabel.text = dateTime;
    _dateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_dateLabel addGestureRecognizer:onTap];
    
}

-(void)addAddressView{
    
    _addressView = [[UIView alloc]init];
    [_scrollView addSubview:_addressView];
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(331);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    _addressView.backgroundColor = [UIColor whiteColor];
    _addressView.userInteractionEnabled = YES;
    _addressView.tag = 500;
     UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_addressView addGestureRecognizer:tap];
    [self addAddressPrompt];
    [self addAddress];
}

-(void)addAddressPrompt{
    
    _addressPromptLabel = [[UILabel alloc]init];
    [_addressView addSubview:_addressPromptLabel];
    [_addressPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    _addressPromptLabel.text = @"地       址";
    _addressPromptLabel.font = [UIFont systemFontOfSize:13];
}

-(void)addAddress{
    _addressLabel = [[UILabel alloc]init];
    [_addressView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 210);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    _addressLabel.numberOfLines = 0;
    _addressLabel.textAlignment = NSTextAlignmentRight;
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.text = @"安徽合肥市蜀山区天鹅湖旺达广场";
    
}

#pragma mark
#pragma mark -- UIGestureRecognizerDelegate
-(void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 500:{
            
            EditController *editVc = [[EditController alloc]init];
            editVc.editContent = _addressLabel.text;
            editVc.editBlock = ^(NSString * editContent){
              
                _addressLabel.text = editContent;
            };
            editVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:editVc animated:YES];
        }
            break;
            
        default:
            
            [[MyDatePicker sharedInstance]initWithSelectTitle:_dateLabel.text  delegate:self];
            break;
            
    }
   
    
    
}

#pragma amrk
#pragma mark-- UITextFieldDelegate
- (void)textViewDidChange:(UITextView*)textView
{
    _textView.text = textView.text;
    if (_textView.text.length == 0) {
        _promptLabel.text = @"宝宝此刻在笑、在走路...还是...";
    }
    else {
        _promptLabel.text = @"";
    }
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

#pragma mark
#pragma mark -- MyDatePickerDelegate
- (void)MyDatePickerDidConfirm:(NSString*)confirmString
{
    _dateLabel.text = confirmString;
 
}

#pragma mark
#pragma mark -- UIButton Action
-(void)onSelectBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            [[AudioView sharedInstance] showAudioView:self];
        }
            
            break;
        case 101:{
            [[FeelingView sharedInstance] showFeelingView:self];
        }

            break;
        case 102:{
            [[FirstTagView sharedInstance] showFirstTagView:self];
        }
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark
#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [_textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark
#pragma mark -- FeelingViewDelegate
-(void)FeelingViewDelegateWithTag:(NSString *)tag{
    
}

#pragma mark
#pragma mark -- FirstTagViewDelegate
-(void)FirstTagViewDelegateWithTag:(NSString *)tag{
    
    
}

#pragma mark
#pragma mark -- AudioViewDelegate
-(void)AudioViewDelegateWithAudioFile:(NSURL *)fileUrl{
    NSLog(@"fileurl :%@",fileUrl);
}

#pragma mark
#pragma mark -- UIBarButtonItem Action
-(void)onPublishBtn:(UIBarButtonItem *)sender{
    
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

//刷新视图布局
//-(void)pickImgsViewHeight:(NSInteger)height{
//    
//    [UIView animateWithDuration:0.1 animations:^{
//        
//        _backgroundView.frame = CGRectMake(0, 110, SCREEN_WIDTH, 50 + height);
//        _publishAlbumTopView.frame = CGRectMake(0, 50, SCREEN_WIDTH, height);
//        [_publishAlbumTopView setNeedsDisplay];
//        _dateView.frame = CGRectMake(0, 170 + height, SCREEN_WIDTH, 40);
//        _addressView.frame = CGRectMake(0, 211 + height, SCREEN_WIDTH, 40);
//        if ((254 + height) > (SCREEN_HEIGHT - 64)) {
//            _scrollView.contentSize = CGSizeMake(0, 254 + height);
//        }else{
//            _scrollView.contentSize = CGSizeMake(0, 0);
//        }
//         
//    }];
//}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
