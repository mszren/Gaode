//
//  QicaiViewController.m
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "QicaiViewController.h"
# import "Masonry.h"
#import "SelectAdressView.h"
#import "Header.h"
#import "IndexController.h"
#import "ProjectController.h"
#import "MyController.h"

@interface QicaiViewController ()<SelectAdressViewDelegate,UIScrollViewDelegate>
@end

@implementation QicaiViewController {
    
    UIButton  *_leftButton;
    NSInteger _tag;
    UISegmentedControl* _seg;
    UIButton *_oldBtn;
    UIView *_toolbar;
    BOOL _isBtnChange;//判断是否是按钮引起的视图变化
}


-(void)viewDidLoad{
    
    [self initializeNavTitleView];
    [self initView];
}

- (void)initView{
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(10, 0, 60, 64);
    [_leftButton setTitle:@"利辛乐园" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _leftButton.adjustsImageWhenDisabled = NO;
    [_leftButton addTarget:self action:@selector(onLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    self.navigationItem.leftBarButtonItem =barButton;
    
}

/**
 *  页面初始化
 *
 *  @return 
 */
- (id)init
{
    NSMutableArray* controllerArray = [[NSMutableArray alloc] init];
    IndexController * index = [[IndexController alloc] init];
    [controllerArray addObject:index];
    
    ProjectController * project = [[ProjectController alloc] init];
    [controllerArray addObject:project];
    
    MyController  *myVc = [[MyController alloc]init];
    [controllerArray addObject:myVc];
    
    self =
    [self initWithItems:nil
         andControllers:controllerArray
            withHideBar:YES];
    
    if (self) {
    }
    return self;
}

-(void)initializeNavTitleView{
//    _seg = [[UISegmentedControl alloc]
//            initWithItems:@[ @"首页", @"项目",@"我的" ]];
//    _seg.tintColor = [UIColor redColor];
//    _seg.frame = CGRectMake((SCREEN_WIDTH - SegWidth) / 2, 6, SegWidth, seghight);
//    
//    [_seg addTarget:self
//             action:@selector(onSegmentedControlClick:)
//   forControlEvents:UIControlEventValueChanged];
//    _seg.selectedSegmentIndex = 0; //选中的分段的索引
//    self.navigationItem.titleView = _seg;
    
    _toolbar = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - SegWidth) / 2, 6, SegWidth, seghight)];
    _toolbar.alpha = 1;
    _toolbar.userInteractionEnabled = YES;
    
    NSArray * titles = @[@"首页",@"项目",@"我的"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + SegWidth/3*i, 0, SegWidth/3, seghight);
        button.tag = 100 + i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.layer.cornerRadius = 15;
        button.clipsToBounds = YES;
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_toolbar addSubview:button];
    }
    self.navigationItem.titleView = _toolbar;
    
    _oldBtn = (UIButton *)[_toolbar viewWithTag:100];
    _oldBtn.selected = YES;
    _oldBtn.adjustsImageWhenHighlighted = NO;
    _oldBtn.backgroundColor = [UIColor greenColor];
}

- (void)onSelectBtn:(UIButton *)sender{
    
    if (sender.tag != _oldBtn.tag) {
        UIButton *button = (UIButton *)[_toolbar viewWithTag:sender.tag];
        button.selected = !button.selected;
        button.backgroundColor = [UIColor greenColor];
        button.adjustsImageWhenHighlighted = NO;
        _oldBtn.selected = !_oldBtn.selected;
        _oldBtn.backgroundColor = [UIColor whiteColor];
        _oldBtn.adjustsImageWhenHighlighted = NO;
        _oldBtn = button;
    }
    [self changePageAction:sender.tag - 100];
    _isBtnChange = YES;
}

- (void)onSegmentedControlClick:(UISegmentedControl*)sender
{
    [self changePageAction:sender.selectedSegmentIndex];
}

#pragma mark-- scroll delegate
- (void)scrollOffsetChanged:(CGPoint)offset
{
    
    [super scrollOffsetChanged:offset];
    int lpage = (int)offset.y / SCREEN_WIDTH;
        
        [self changeState:lpage];
    
}

/**
 *  更改右上角按钮状态
 *
 *  @param index 
 */
- (void)changeState:(NSInteger)index
{
//    _seg.selectedSegmentIndex = index;
    
    if ((index + 100) != _oldBtn.tag ) {
        UIButton *button = (UIButton *)[_toolbar viewWithTag:index + 100];
        
        if (button.selected == NO) {
            
            button.selected = !button.selected;
            button.backgroundColor = [UIColor greenColor];
            button.adjustsImageWhenHighlighted = NO;
            _oldBtn.selected = !_oldBtn.selected;
            _oldBtn.backgroundColor = [UIColor whiteColor];
            _oldBtn.adjustsImageWhenHighlighted = NO;
            _oldBtn = button;
        }
    }

}

#pragma mark TitleViewDelegate
- (void)changePageAction:(NSUInteger)aPage
{
    int page = (int)aPage;
    [self selectedChangedIndex:page];
}


#pragma mark -- UIButton Action
- (void)onLeftBtn:(UIButton *)sender{
    
    NSString *title = _leftButton.titleLabel.text;
    if ([title isEqualToString:@"利辛乐园"]) {
        
        _tag = 100;
    }else if ([title isEqualToString:@"阜阳乐园"]){
        
        _tag = 101;
    }
    
    [[SelectAdressView sharedInstance] showSelectAdressView:self andTag:_tag];
}

#pragma mark -- SelectAdressViewDelegate
- (void)SelectAdressViewDelegateWithTag:(NSString *)tag{
    
    if (tag != nil && tag != NULL && tag.length > 0) {
        [_leftButton setTitle:tag forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
