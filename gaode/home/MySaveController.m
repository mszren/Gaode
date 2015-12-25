//
//  MySaveController.m
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import "MySaveController.h"
#import "Header.h"
#import "MyBangController.h"
#import "MygrowTreeController.h"
#import "MyShaiShaiController.h"
#import "SegmentBarView.h"

@interface MySaveController () <YSLContainerViewControllerDelegate>

@end

@implementation MySaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"我的收藏"];
    self.view.backgroundColor = [UIColor orangeColor];
    [self initView];
}

- (void)initView{
    
    MygrowTreeController *myGrowVc = [MygrowTreeController new];
    myGrowVc.title = @"成长树";
    
    MyBangController *myBangVc = [MyBangController new];
    myBangVc.title = @"帮帮";
    
    MyShaiShaiController *myShaiVc = [MyShaiShaiController new];
    myShaiVc.title = @"晒晒";
    
    YSLContainerViewController *containerVc = [[YSLContainerViewController alloc]initWithControllers:@[myGrowVc,myBangVc,myShaiVc] topBarHeight:TabBarHeight + 1 parentViewController:self];
    containerVc.delegate = self;
    [self.view addSubview:containerVc.view];

}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    [controller viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
