//
//  RootBar.m
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "RootBar.h"
#import "Header.h"
#import "publishVIew.h"

@implementation RootBar{
    BaseNavController *navc1;
    BaseNavController *navc2;
    BaseNavController *navc3;
    BaseNavController *navc4;
    BaseNavController *navc5;
    UIButton *_oldBtn;
    UILabel *_oldLabel;
    UIImageView *_tabBarView;
    UIButton * _fabuBtn;
    UIButton * _lookBtn;
    UILabel * _lookLabel;
     
}

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    LookViewController *lookVc = [[LookViewController alloc]init];
    BangbangController *bangVc = [[BangbangController alloc]init];
    QicaiViewController *qiVc = [[QicaiViewController alloc]init];
    ShaishaiViewController *shaiVc = [[ShaishaiViewController alloc]init];
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    
    
    navc1 = [[BaseNavController alloc]initWithRootViewController:lookVc];
    navc2 = [[BaseNavController alloc]initWithRootViewController:bangVc];
    navc3 = [[BaseNavController alloc]initWithRootViewController:qiVc];
    navc4 = [[BaseNavController alloc]initWithRootViewController:shaiVc];
    navc5 = [[BaseNavController alloc]initWithRootViewController:homeVc];

    
    
    self.delegate = self;
    self.selectedIndex = 0;
    self.tabBar.tintColor = [UIColor greenColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"bar_img"];
    
    navc1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"看着" image:[UIImage imageNamed:@"tabbar_btn_kanzhe_normal"] selectedImage:[UIImage imageNamed:@"tabbar_btn_kanzhe_selected"]];
    navc2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"帮帮" image:[UIImage imageNamed:@"tabbar_btn_bang_normal"] selectedImage:[UIImage imageNamed:@"tabbar_btn_bang_selected"]];
    navc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    navc4.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"晒晒" image:[UIImage imageNamed:@"tabbar_btn_shai_normal"] selectedImage:[UIImage imageNamed:@"tabbar_btn_shai_selected"]];
    navc5.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_btn_wojia_normal"] selectedImage:[UIImage imageNamed:@"tabbar_btn_wojia_selected"]];
    
    self.viewControllers = @[navc1,navc2,navc3,navc4,navc5];
//    
//     _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _lookBtn.frame = CGRectMake((SCREEN_WIDTH - 150)/8 , 10, 25, 22);
//    _lookBtn.tag = 100;
//    _lookBtn.adjustsImageWhenHighlighted = NO;
//    [_lookBtn setImage:[UIImage imageNamed:@"tabbar_btn_kanzhe_normal"] forState:UIControlStateNormal];;
//    [self.tabBar addSubview:_lookBtn];
//    _lookBtn.titleLabel.font = [UIFont systemFontOfSize:9];
//    _lookBtn.userInteractionEnabled = NO;
//    _lookBtn.hidden = YES;
//    
//     _lookLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/8 , 30, 25, 22)];
//    _lookLabel.tag = 200;
//    _lookLabel.font = [UIFont systemFontOfSize:9];
//    _lookLabel.text = @"看着";
//    _lookLabel.textColor = [UIColor grayColor];
//    _lookLabel.textAlignment = NSTextAlignmentCenter;
//    _lookLabel.hidden = YES;
//    _lookLabel.userInteractionEnabled = NO;
//    [self.tabBar addSubview:_lookLabel];
//    
//    
    _fabuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _fabuBtn.frame =CGRectMake((SCREEN_WIDTH - 150)/8 - 9.5 , 2 , 45, 45);
    _fabuBtn.tag = 300;
    _fabuBtn.adjustsImageWhenDisabled = NO;
    [_fabuBtn setImage:[UIImage imageNamed:@"btn_kanzhe_fabu"] forState:UIControlStateNormal];
    [_fabuBtn addTarget:self action:@selector(onfabuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:_fabuBtn];
//
//    UIButton *bangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    bangBtn.frame = CGRectMake((SCREEN_WIDTH - 150)/8*3 +25 , 10, 25, 22);
//    bangBtn.adjustsImageWhenHighlighted = NO;
//    [bangBtn setImage:[UIImage imageNamed:@"tabbar_btn_bang_normal"] forState:UIControlStateNormal];
//    [bangBtn setImage:[UIImage imageNamed:@"tabbar_btn_bang_selected"] forState:UIControlStateSelected];
//    [self.tabBar addSubview:bangBtn];
//    bangBtn.tag = 101;
//    bangBtn.userInteractionEnabled = NO;
//    
//    UILabel *bangLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/8*3 +  25 , 30, 25, 22)];
//    bangLabel.tag = 201;
//    bangLabel.text = @"帮帮";
//    bangLabel.textColor = [UIColor grayColor];
//    bangLabel.font = [UIFont systemFontOfSize:9];
//    bangLabel.textAlignment = NSTextAlignmentCenter;
//    bangLabel.userInteractionEnabled = NO;
//    [self.tabBar addSubview:bangLabel];
//    
    UIButton *qicaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qicaiBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 25, -20, 50, 58);
    [qicaiBtn setImage:[UIImage imageNamed:@"tabbar_btn_qcsj"] forState:UIControlStateNormal];
    [qicaiBtn setImage:[UIImage imageNamed:@"tabbar_btn_qcsj"] forState:UIControlStateSelected];
    [self.tabBar addSubview:qicaiBtn];
    qicaiBtn.adjustsImageWhenHighlighted = NO;
    qicaiBtn.userInteractionEnabled = NO;
    qicaiBtn.tag = 102;
//
//    UILabel *qicaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25 , 30, 25, 22)];
//    qicaiLabel.font = [UIFont systemFontOfSize:9];
//    qicaiLabel.tag = 202;
//    qicaiLabel.alpha = 0;
//    qicaiLabel.textColor = [UIColor grayColor];
//    qicaiLabel.userInteractionEnabled = NO;
//    qicaiLabel.textAlignment = NSTextAlignmentCenter;
//    [self.tabBar addSubview:qicaiLabel];
//
//
//    UIButton *shaishaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    shaishaiBtn.frame = CGRectMake((SCREEN_WIDTH - 150)/8*5 + 100, 10, 25, 22);
//    shaishaiBtn.adjustsImageWhenHighlighted = NO;
//    [shaishaiBtn setImage:[UIImage imageNamed:@"tabbar_btn_shai_normal"] forState:UIControlStateNormal];
//    [shaishaiBtn setImage:[UIImage imageNamed:@"tabbar_btn_shai_selected"] forState:UIControlStateSelected];
//    [self.tabBar addSubview:shaishaiBtn];
//    shaishaiBtn.tag = 103;
//    shaishaiBtn.userInteractionEnabled = NO;
//    
//    UILabel *shaishaiLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/8*5 + 100 , 30, 25, 22)];
//    shaishaiLabel.font = [UIFont systemFontOfSize:9];
//    shaishaiLabel.tag = 203;
//    shaishaiLabel.textColor = [UIColor grayColor];
//    shaishaiLabel.text = @"晒晒";
//    shaishaiLabel.userInteractionEnabled = NO;
//    shaishaiLabel.textAlignment = NSTextAlignmentCenter;
//    [self.tabBar addSubview:shaishaiLabel];
//    
//    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    homeBtn.frame = CGRectMake(SCREEN_WIDTH - 25 - (SCREEN_WIDTH - 170)/8, 10, 25, 22);
//    homeBtn.adjustsImageWhenHighlighted = NO;
//    [homeBtn setImage:[UIImage imageNamed:@"tabbar_btn_wojia_normal"] forState:UIControlStateNormal];
//    [homeBtn setImage:[UIImage imageNamed:@"tabbar_btn_wojia_selected"] forState:UIControlStateSelected];
//    [self.tabBar addSubview:homeBtn];
//    homeBtn.tag = 104;
//    homeBtn.userInteractionEnabled = NO;
//    
//    UILabel *homeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25 - (SCREEN_WIDTH - 170)/8 , 30, 25, 22)];
//    homeLabel.font = [UIFont systemFontOfSize:9];
//    homeLabel.textColor = [UIColor grayColor];
//    homeLabel.tag = 204;
//    homeLabel.text = @"我的";
//    homeLabel.userInteractionEnabled = NO;
//    homeLabel.textAlignment = NSTextAlignmentCenter;
//    [self.tabBar addSubview:homeLabel];
//    
   
//
//    _oldBtn = (UIButton *)[self.view viewWithTag:100];
//    _oldBtn.selected = YES;
//    
//    _oldLabel = (UILabel *)[self.view viewWithTag:200];
//    _oldLabel.textColor = [UIColor greenColor];
    
    
}

#pragma mark
#pragma mark -- UITabBarControllerDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
 
    [self changeStatu:index + 100];
}


#pragma mark
#pragma mark -- UIButton Action
-(void)changeStatu:(NSInteger )index{
    
    if ( index == 300 ) {
        
        [[publishVIew sharedInstance] showPublishView:navc1];
        
    }else{
        
//        if (index != _oldBtn.tag) {
//            
//            
//            if (index == 100 ) {
//                
//                _fabuBtn.hidden = NO;
//                _fabuBtn.userInteractionEnabled = YES;
//                _lookBtn.hidden = YES;
//                _lookLabel.hidden = YES;
//
//            }else{
//                
//                _fabuBtn.hidden = YES;
//                _lookLabel.hidden = NO;
//                _lookBtn.hidden = NO;
//                _fabuBtn.userInteractionEnabled = NO;
//                [self.view setNeedsUpdateConstraints];
//                
//            }
//            
//            UIButton * button = (UIButton *)[self.view viewWithTag:index];
//            button.selected = !button.selected;
//            _oldBtn.selected = !_oldBtn.selected;
//            _oldBtn = button;
//            
//            UILabel *label = (UILabel *)[self.view viewWithTag:index + 100];
//            label.textColor = [UIColor greenColor];
//            _oldLabel.textColor = [UIColor grayColor];
//            _oldLabel = label;
//        }
        
        if (index == 100) {
            
            _fabuBtn.hidden = NO;
            _fabuBtn.userInteractionEnabled = YES;
            
            
            
        }else{
            _fabuBtn.hidden = YES;
            _fabuBtn.userInteractionEnabled = NO;
        }
        
        }
}



-(void)onfabuBtn:(UIButton *)sender{
    
    [self changeStatu:sender.tag];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITabBarController Delegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController
shouldSelectViewController:(UIViewController*)viewController
{
    
    return YES;
}

- (void)tabBarController:(UITabBarController*)tabBarController
 didSelectViewController:(UIViewController*)viewController
{
}

#pragma mark -
#pragma mark UIDevice InterfaceOrientations
-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
