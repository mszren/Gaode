//
//  CityPickerView.m
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import "CityPickerView.h"
#import "Header.h"

@implementation CityPickerView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showCityPickerView:(NSString *)city andDelegate:(id<CityPickerViewDelegate>)delegate{
    self.delegate = delegate;
    _resultCity = city;
    self.isCertain = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    self.window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_viewController.view addGestureRecognizer:tap];
    _viewController.view.tag = 200;
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT/2 - 120, SCREEN_WIDTH - 80, 240)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.cornerRadius = 6;
    _backGroundView.clipsToBounds = YES;
    _backGroundView.layer.shouldRasterize = YES;
    [_viewController.view addSubview:_backGroundView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 90, 40)];
    _titleLabel.text = @"选择地点";
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.tag = 300;
    [_backGroundView addSubview:_titleLabel];
    UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)   ];
    [_titleLabel addGestureRecognizer:titleTap];
    
    UILabel *greenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH - 80, 1)];
    greenLabel.backgroundColor = [UIColor blueColor];
    [_backGroundView addSubview:greenLabel];
    UITapGestureRecognizer *greenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [greenLabel addGestureRecognizer:greenTap];
    
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, 10, 30)];
    coverView.backgroundColor = [UIColor whiteColor];
    [_backGroundView addSubview:coverView];
    UITapGestureRecognizer *coverTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [coverView addGestureRecognizer:coverTap];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 41, SCREEN_WIDTH - 90, 30)];
    _contentLabel.text = city;
    _contentLabel.userInteractionEnabled = YES;
    _contentLabel.tag = 400;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    [_backGroundView addSubview:_contentLabel];
    UITapGestureRecognizer *contentTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_contentLabel addGestureRecognizer:contentTap];
    
    //创建二级联动选择器
    // 初始化模型数据
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
    _provinces = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CityPickerProvince *province = [CityPickerProvince provinceWithDict:dict];
        [_provinces addObject:province];
    }
    
    // 代码创建pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 314)/2, 61, 234, 128)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    // 显示pickerView的选择指示器
    pickerView.showsSelectionIndicator = YES;
    [_backGroundView addSubview:pickerView];
    
    // 默认选中第0个省份的第0个城市
//    [pickerView selectRow:0 inComponent:0 animated:YES];
    
    
    UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 199.5, SCREEN_WIDTH - 80, 0.5)];
    grayLabel.backgroundColor = [UIColor grayColor];
    [_backGroundView addSubview:grayLabel];
    
    NSArray *arry = @[@"取消",@"确定"];
    for (NSInteger i = 0; i < arry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + (SCREEN_WIDTH - 80)/2*i, 200, (SCREEN_WIDTH - 80)/2, 40);
        [button setTitle:arry[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100 + i;
        button.adjustsImageWhenHighlighted = NO;
        [_backGroundView addSubview:button];
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *hGrayLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 200, 0.5, 40)];
    hGrayLabel.backgroundColor = [UIColor grayColor];
    [_backGroundView addSubview:hGrayLabel];
    
    // The window has to be un-hidden on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.window makeKeyAndVisible];
        
        _backGroundView.alpha = 0;
        _backGroundView.layer.shouldRasterize = YES;
        _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.alpha = 1;
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            _backGroundView.alpha = 1;

        }];
        
    });
}

#pragma mark - 数据源方法
#pragma mark 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

#pragma mark 列中行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) { // 多少个省
        return _provinces.count;
    } else { // 城市个数
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        CityPickerProvince *provinces = _provinces[selectedRow];
        return provinces.cities.count;
    }
    
}

#pragma mark - 代理方法
#pragma mark 行中内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) { // 显示省份
        // 取出省份模型
        CityPickerProvince *provinces = _provinces[row];
        // 取出省份名称
        return provinces.name;
    } else { // 显示城市
        // 获得选中的省份
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        // 取出省份模型
        CityPickerProvince *provinces = _provinces[selectedRow];
        // 返回对应行的城市名称
        return provinces.cities[row];
    }
    
}

#pragma mark 监听选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    if (component == 0) { // 省份已变
        // 刷新第1列的数据（重新刷新数据，重新调用数据源和代理的相应方法获得数据）
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
//    }
    // 获得选中的省份
    NSInteger pIndex = [pickerView selectedRowInComponent:0];
    CityPickerProvince *province = _provinces[pIndex];
    // 获得选中的城市的位置
    NSInteger cIndex = [pickerView selectedRowInComponent:1];
    self.resultCity = [NSString stringWithFormat:@"%@.%@", province.name, province.cities[cIndex]];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 117;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 42;
}

#pragma  mark  -- UITapGestureRecognizer
-(void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 200:
            [self clean];
            break;
            
        default:
            break;
    }
    
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            self.isCertain = NO;
            break;
            
        default:
            self.isCertain = YES;
            [self.delegate CityPickerViewReturnCity:self.resultCity];
            break;
    }
    
    [self clean];
}

-(void)clean{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _backGroundView.alpha = 0;
                self.window.alpha = 0;
                _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            } completion:^(BOOL finished2) {
                
                [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
                [self.window removeFromSuperview];
                [self.backGroundView removeFromSuperview];
                self.viewController = nil;
                self.window = nil;
                
                
            }];
            
        }];
        
    });
}

@end
