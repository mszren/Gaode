//
//  MyController.m
//  gaode
//
//  Created by 我 on 15/10/29.
//  Copyright © 2015年 我. All rights reserved.
//

#import "MyController.h"
#import "EGOTableView.h"
#import "IndexCell.h"
#import "MyHeadCell.h"

@interface MyController () <EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyController{
    
    EGOTableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initView];
}

-(void)initView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight) style:UITableViewStylePlain];
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
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *headIdentifier = @"headIdentifier";
        MyHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
        if (!headCell) {
            headCell = [[MyHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headIdentifier];
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;
            headCell.backgroundColor = [UIColor greenColor];
        }
        return headCell;
    }else{
        
        static NSString *myIdentifier = @"myIdentifier";
        IndexCell *indexCell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (!indexCell) {
            indexCell = [[IndexCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
            indexCell.selectionStyle = UITableViewCellSelectionStyleNone;
            indexCell.backgroundColor = [UIColor greenColor];
        }
        return indexCell;
    }
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 180;
    }else{
        
        return 231;
    }
    
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    return [NSDate date];
}
- (NSDate*)pullingTableViewLoadingFinishedDate
{
    return [NSDate date];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    [_tableView tableViewDidScroll:scrollView];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [_tableView tableViewDidEndDragging:scrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
