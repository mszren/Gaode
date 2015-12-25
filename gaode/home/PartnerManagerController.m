//
//  PartnerManagerController.m
//  gaode
//
//  Created by 我 on 15/11/6.
//  Copyright © 2015年 我. All rights reserved.
//

#import "PartnerManagerController.h"
#import "Header.h"
#import <Masonry.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "EGOTableView.h"

@interface PartnerManagerController () <EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation PartnerManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
