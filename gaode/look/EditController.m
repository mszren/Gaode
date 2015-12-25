//
//  FamilyManagerController.m
//  
//
//  Created by 我 on 15/10/19.
//
//

#import "EditController.h"
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Header.h"

@interface EditController ()<UITextViewDelegate>

@end

@implementation EditController{
    
    UITextView *_textField;
    UIView *_backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"编辑"];
    [self initView];
}

-(void)initView{
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(onRigtnBtn:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self addBackgroundView];
}

-(void)addBackgroundView{
    
    _backgroundView = [[UIView alloc]init];
    [self.view addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addTextField];
}

-(void)addTextField{
    
    _textField = [[UITextView alloc]init];
    [_backgroundView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.text = _editContent;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.delegate = self;
}

#pragma mark
#pragma mark -- UIBarButtonItem Action
-(void)onRigtnBtn:(UIBarButtonItem *)sender{
    
    if (_editBlock) {
        
        _editBlock(_textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [_textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
