//
//  BangbangDetailController.m
//  gaode
//
//  Created by 我 on 15/10/28.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BangbangDetailController.h"
#import "Masonry.h"
#import "EGOTableView.h"
#import "BangDetailCell.h"

@interface BangbangDetailController ()<EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) EGOTableView* tableView;
@end

@implementation BangbangDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"帮帮详情"];
    [self initView];
}

-(void)initView{
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"actionbar_btn_scan"] style:UIBarButtonItemStyleDone target:self action:@selector(onRightItem:)];
    shareItem.tag = 100;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"actionbar_btn_scan"] style:UIBarButtonItemStyleDone target:self action:@selector(onRightItem:)];
    [saveItem setImageInsets:UIEdgeInsetsMake(0, 25, 0, -25)];
    saveItem.tag = 200;
    
    self.navigationItem.rightBarButtonItems = @[shareItem,saveItem];
    
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight) style:UITableViewStylePlain];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    [self.view addSubview:_tableView];
}

#pragma mark EGOTableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BangIdentifier";
    BangDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BangDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 770;
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    return [NSDate date];
}
- (NSDate*)pullingTableViewLoadingFinishedDate
{
    return [NSDate date];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    [_tableView tableViewDidScroll:scrollView];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [_tableView tableViewDidEndDragging:scrollView];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    switch (sender.tag) {
        case 200:
            [self showShareView];
            break;
            
        default:
            break;
    }
}

-(void)showShareView{
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
