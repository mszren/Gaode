//
//  MessageController.m
//  gaode
//
//  Created by 我 on 15/10/23.
//  Copyright © 2015年 我. All rights reserved.
//

#import "MessageController.h"
#import "Masonry.h"
#import "Header.h"
#import "AudioView.h"
#import "DaiDodgeKeyboard.h"
#import "MessageCell.h"
#import "MessageFrame.h"
#import "Message.h"

#define WIDTH (SCREEN_WIDTH - 100)/3
@interface MessageController () <AudioViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation MessageController{
    UIView *_backgroundView;
    UITextField *_editText;
    
    UITableView *_tableView;
    NSMutableArray  *_allMessagesFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"留言板"];
    [self initView];
}

- (void)initView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.userInteractionEnabled = YES;
    [self addGroundView];
    [self addTableView];
}

-(void)addTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.userInteractionEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    [self.view addSubview:_tableView];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    
    _allMessagesFrame = [NSMutableArray array];
    NSString *previousTime = nil;
    for (NSDictionary *dict in array) {
        
        MessageFrame *messageFrame = [[MessageFrame alloc] init];
        Message *message = [[Message alloc] init];
        message.dict = dict;
        
        messageFrame.showTime = ![previousTime isEqualToString:message.time];
        
        messageFrame.message = message;
        
        previousTime = message.time;
        
        [_allMessagesFrame addObject:messageFrame];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)addGroundView{
    _backgroundView = [UIView new];
    [self.view addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(SCREEN_HEIGHT - 114);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 200));
    }];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    
    UILabel *grayLabel = [UILabel new];
    [_backgroundView addSubview:grayLabel];
    [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    grayLabel.backgroundColor = [UIColor greenColor];
    
    [self addEditView];
}

-(void)addEditView{
    UIButton * audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:audioBtn];
    [audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    audioBtn.layer.cornerRadius = 15;
    audioBtn.clipsToBounds = YES;
    audioBtn.tag = 100;
    audioBtn.adjustsImageWhenHighlighted = NO;
    [audioBtn setImage:[UIImage imageNamed:@"bg_kanzhe_fyy"] forState:UIControlStateNormal];
    [audioBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:imgBtn];
    [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    imgBtn.layer.cornerRadius = 15;
    imgBtn.clipsToBounds = YES;
    imgBtn.tag = 200;
    imgBtn.adjustsImageWhenHighlighted = NO;
    [imgBtn setImage:[UIImage imageNamed:@"bg_kanzhe_xuanze"] forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _editText = [UITextField new];
    [_backgroundView addSubview:_editText];
    [_editText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(90);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 160, 30));
    }];
    _editText.placeholder = @"和家人说点什么吧";
    _editText.font = [UIFont systemFontOfSize:13];
    _editText.borderStyle = UITextBorderStyleRoundedRect;
    _editText.delegate = self;
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:publishBtn];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 60);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [publishBtn setTitle:@"发送" forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishBtn.backgroundColor = GREEN_COLOR;
    publishBtn.adjustsImageWhenHighlighted = NO;
    publishBtn.layer.cornerRadius = 4;
    publishBtn.clipsToBounds = YES;
    publishBtn.tag = 300;
    [publishBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *selectArry = @[@"bg_kanzhe_fpic",@"bg_kanzhe_fsp"];
    for (NSInteger i = 0; i < selectArry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backgroundView addSubview:button];
        button.tag = 400 + i;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(WIDTH + (WIDTH + 50)*i);
            make.top.mas_equalTo(87);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            
        }];
        [button setBackgroundImage:[UIImage imageNamed:selectArry[i]] forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
        button.layer.cornerRadius = 25;
        button.clipsToBounds = YES;
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    NSArray *namesArry = @[@"相册",@"视频"];
    for (NSInteger i = 0; i < namesArry.count; i ++) {
        UILabel *label = [UILabel new];
        [_backgroundView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WIDTH + (WIDTH + 50)*i);
            make.top.mas_equalTo(137);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        label.text = namesArry[i];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
    }
}

#pragma mark -- UItouch
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {//遍历集合。touches表示所有触摸点，但是默认情况下只支持单指触摸（也就是只有一个触摸点）。
        //判断是不是点住了_imageView拖动
        if (touch.view != _backgroundView) {//UITouch的view属性表示正在触摸的视图
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 114, SCREEN_WIDTH, 200);
            } completion:^(BOOL finished) {
                
            }];
            
            [_editText resignFirstResponder];
        }
    }
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            
            [[AudioView sharedInstance] showAudioView:self];
            [_editText resignFirstResponder];
            _backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 114, SCREEN_WIDTH, 50);
            _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114);
            // 3、滚动至当前行
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
            [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
            
            break;
        case 200:{
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 264, SCREEN_WIDTH, 200);
                _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 264);
                // 3、滚动至当前行
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
                [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
            
            break;
        case 300:
        {
            
            // 1、增加数据源
            NSString *content = _editText.text;
            if (_editText.text != nil && _editText.text.length > 0) {
                
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                NSDate *date = [NSDate date];
                fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
                NSString *time = [fmt stringFromDate:date];
                [self addMessageWithContent:content time:time];
            }

            // 2、刷新表格
            [_tableView reloadData];
            // 3、滚动至当前行
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
            [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            _editText.text = nil;
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 114, SCREEN_WIDTH, 200);
                _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114);
            } completion:^(BOOL finished) {
                
            }];
            

        }
            
            break;
        case 400:
            
            break;
        case 401:
            
            break;
            
        default:
            break;
    }
}

#pragma mark -- AudioViewDelegate
- (void)AudioViewDelegateWithAudioFile:(NSURL *)fileUrl{
    
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_editText resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 114, SCREEN_WIDTH, 200);
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark 给数据源增加内容
- (void)addMessageWithContent:(NSString *)content time:(NSString *)time{
    
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content = content;
    msg.time = time;
    msg.icon = @"icon01.png";
    msg.type = MessageTypeMe;
    mf.showTime = YES;
    mf.message = msg;
    
    
    [_allMessagesFrame addObject:mf];
}

#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessagesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置数据
    cell.messageFrame = _allMessagesFrame[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_allMessagesFrame[indexPath.row] cellHeight];
}

#pragma mark - 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (_tableView.frame.size.height == SCREEN_HEIGHT - 264) {
        
       [UIView animateWithDuration:0.1 animations:^{
           
           _backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 114, SCREEN_WIDTH, 200);
           _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114);
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
           [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
       }];
    }else{
    
        [self.view endEditing:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
     [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
