//
//  LookViewController.m
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "LookViewController.h"
#import "UMSocial.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchServices.h>
#import "CustomAnnotationView.h"
#import "Header.h"
#import "CMPopTipView.h"
#import "FamilyManagerController.h"
#import "MessageController.h"
#import "GrouthTreeController.h"
#import "ScanViewController.h"

@interface LookViewController ()<UMSocialUIDelegate,MAMapViewDelegate,AMapSearchDelegate,CMPopTipViewDelegate>{
    
    MAMapView *_mapView;
    UIButton * _oldTypeBtn;
    CMPopTipView * _cmPopView;
    NSInteger _level;
    MACoordinateRegion _region;//中心点坐标
    UIButton * _lookBtn;
}

@end

@implementation LookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"看着"];
    [self initView];
    
}

-(void)initView{
    
    
    self.visiblePopTipViews = [NSMutableArray array];
    self.navigationItem.titleView.userInteractionEnabled = YES;
    _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lookBtn.frame = CGRectMake(SCREEN_WIDTH/3, 12, 20, 20);
    [_lookBtn setImage:[UIImage imageNamed:@"ic_kanzhe_dhz_normal"] forState:UIControlStateNormal];
    _lookBtn.tag = 200;
    _lookBtn.userInteractionEnabled = YES;
    [_lookBtn addTarget:self action:@selector(onTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem.titleView addSubview:_lookBtn];
 
    
    //创建右边的扫描按钮
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"actionbar_btn_scan"]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(onRightBtn:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [[MAMapServices sharedServices]setApiKey:@"41362367de09e170db28094b117e3e1f"];
    [[AMapSearchServices sharedServices]setApiKey:@"41362367de09e170db28094b117e3e1f"];
    
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsCompass = NO;//指南针
    _mapView.showsScale = NO;//比例尺
    _mapView.layer.shouldRasterize = YES;
 
    
    
    //地图的缩放级别的范围是[3-19],调用 MAMapView 的 setZoomLevel 方法设置地图的缩放级别, 用来缩放地图。示例代码如下:
    _level = 13;
    [_mapView setZoomLevel:_level animated:YES];
    
    
    
    /**
     *  GPS  只要开启定位开关(MAMapView 的 showsUserLocation 属性)就可以开始定位。代码如下所示:GPS
     */
    _mapView.showsUserLocation = YES;//是否显示用户位置
    _mapView.userTrackingMode = 1;
    
    /**
     *  定位图层有 3 种显示模式,分别为
     */
    //MAUserTrackingModeNone:不跟随用户位置,仅在地图上显示。
    // MAUserTrackingModeFollow:跟随用户位置移动,并将定位点设置成地图中心点。
    // MAUserTrackingModeFollowWithHeading:跟随用户的位置和角度移动。
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow];
    
    //标注
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(31.818884, 117.221945);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街 6 号";
    [_mapView addAnnotation:pointAnnotation];
    
    //初始中心点
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.818884, 117.221945);
    MACoordinateSpan span = MACoordinateSpanMake(0.1, 0.1);
    _region = MACoordinateRegionMake(coordinate, span);
    [_mapView setRegion:_region];
    
    NSArray * types = @[@"ic_kanzhe_kz_normal",@"ic_kanzhe_dhz_normal",@"ic_kanzhe_czs_normal",@"ic_kanzhe_lyb_normal"];
    NSArray * names = @[@"看着",@"带孩子",@"找伙伴",@"留言板"];
    for (NSInteger i = 0; i < types.count; i++) {
        UIButton * typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.frame = CGRectMake(SCREEN_WIDTH - 62, 20 + 65*i, 50, 50);
        typeBtn.layer.cornerRadius = 25;
        typeBtn.clipsToBounds = YES;
        typeBtn.adjustsImageWhenHighlighted = NO;
        typeBtn.tag = 100 + i;
        [typeBtn setImage:[UIImage imageNamed:types[i]] forState:UIControlStateNormal];
        [typeBtn setTitle:names[i] forState:UIControlStateNormal];
        typeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        typeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (typeBtn.selected == YES) {
            typeBtn.backgroundColor = [UIColor greenColor];
        }else{
            typeBtn.backgroundColor = [UIColor whiteColor];
        }
 
       
        typeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 20, 10);
        typeBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 60);
        
        [self.view addSubview:typeBtn];
        [typeBtn addTarget:self action:@selector(onTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    _oldTypeBtn = (UIButton *)[self.view viewWithTag:100];
    _oldTypeBtn.selected = YES;
    
    
    NSArray * zoomLevels = @[@"btn_kanzhe_jhpic",@"btn_kanzhe_jhpic"];
    for (NSInteger i = 0; i < zoomLevels.count; i++) {
        UIButton * zoomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zoomBtn.frame = CGRectMake(SCREEN_WIDTH - 35, SCREEN_HEIGHT - 180 + 31*i, 30, 30);
        zoomBtn.tag = 300 + i;
        zoomBtn.backgroundColor = [UIColor whiteColor];
        zoomBtn.adjustsImageWhenHighlighted = NO;
        [zoomBtn setImage:[UIImage imageNamed:zoomLevels[i]] forState:UIControlStateNormal];
        [zoomBtn addTarget:self action:@selector(onTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:zoomBtn];
    }
    
    
}

#pragma mark
#pragma mark -- UIButton Action
-(void)onTypeBtn:(UIButton *)sender{
    
    if (sender.tag == 200) {
        
        if (self.currentPopTipViewTarget == sender) {
            [self.visiblePopTipViews removeObject:_cmPopView];
            self.currentPopTipViewTarget = nil;
            
            return;
        }
        
        UIView * customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
       
        UIButton * faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        faceBtn.frame = CGRectMake(25, -4, 20, 20);
        [faceBtn setImage:[UIImage imageNamed:@"btn_kanzhe_fabu"] forState:UIControlStateNormal];
        [customView addSubview:faceBtn];
        faceBtn.userInteractionEnabled = NO;
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 40, 15)];
        nameLabel.text = @"狮子";
        nameLabel.textColor = [UIColor greenColor];
        nameLabel.font = [UIFont systemFontOfSize:11];
        [customView addSubview:nameLabel];
        
        _cmPopView = [[CMPopTipView alloc]initWithCustomView:customView];
        _cmPopView.delegate = self;
        _cmPopView.backgroundColor = [UIColor blackColor];
        _cmPopView.alpha = 0.3;
        _cmPopView.dismissTapAnywhere = YES;
        _cmPopView.animation = arc4random() % 2;
        _cmPopView.has3DStyle = (BOOL)(arc4random() % 2);
        [_cmPopView presentPointingAtView:self.navigationController.navigationBar inView:self.view animated:YES];
        [self.visiblePopTipViews addObject:_cmPopView];
        self.currentPopTipViewTarget = sender;
        
    }else if (sender.tag == 300 || sender.tag == 301){
        
        //获取缩放比例
        _level = _mapView.zoomLevel;
        
        switch (sender.tag) {
            case 300:
                _level ++;
                break;
                
            default:
                _level --;
                break;
        }
        
        if (_level<=19 && _level >=3) {
            
            [_mapView setZoomLevel:_level animated:YES];
        }
        
        
    }else{
        
        UIButton * button = (UIButton *)[self.view viewWithTag:sender.tag];
        button.selected = !button.selected;
        _oldTypeBtn.selected = !_oldTypeBtn.selected;
        _oldTypeBtn = button;
        
        switch (sender.tag) {
            case 100:
                
                break;
            case 101:{
                
                FamilyManagerController *faVc = [[FamilyManagerController alloc]init];
                faVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:faVc animated:YES];
            }
                
                break;
            case 102:{
                
                
            }
                
                break;
            case 103:{
                MessageController *meVc = [MessageController new];
                meVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:meVc animated:YES];
            }
                
                break;
                
            default:
                break;
        }
    }
    
}


#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}

- (void)CMPopTipViewIsUserTap:(CMPopTipView *)popTipView{
    
    //重新初始化中心点
    [_mapView setRegion:_region];
}

//当位置更新时,会进定位回调,通过回调函数,能获取到定位点的经纬度坐标,示例代码如下:
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

#pragma mark
#pragma mark -- MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
    
        static NSString *pointReuseIndetifier = @"annotationPin";
        CustomAnnotationView *annotationView =  [[CustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        
        UIImage *bgImage = [UIImage imageNamed:@"annotationPin"];
        
        annotationView.frame = CGRectMake(0.0f, 0.0f, bgImage.size.width, bgImage.size.height);
        annotationView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ontapGroutnTree:)];
        [annotationView addGestureRecognizer:tap];
        
        if(!annotationView.imageView) {
            annotationView.imageView = [UIImageView new];
            [annotationView addSubview:annotationView.imageView];
        }
        
        annotationView.imageView.backgroundColor = [UIColor clearColor];
        annotationView.imageView.frame=  CGRectMake(0.0f, 0.0f, annotationView.frame.size.width, annotationView.frame.size.height);
        [annotationView.imageView setImage:bgImage];
        
        //            annotationView.centerOffset = CGPointMake(0.0f, -(bgImage.size.height/2.0f));
        annotationView.backgroundColor=[UIColor clearColor];
        
        if (!annotationView.faceImg) {
            annotationView.faceImg = [UIImageView new];
            [annotationView addSubview:annotationView.faceImg];
        }
        
        annotationView.faceImg.frame=  CGRectMake(0.0f, 0.0f, annotationView.frame.size.width /2, annotationView.frame.size.height/2);
        
        CGPoint point = annotationView.center;
        annotationView.faceImg.center = CGPointMake(point.x, point.y);
        [annotationView.faceImg setImage:[UIImage imageNamed:@"btn_xt_sina"]];
        
        return annotationView;
        
    }
    return nil;
}

- (void)ontapGroutnTree:(UITapGestureRecognizer *)sender{
    
    GrouthTreeController *grouthVc = [GrouthTreeController new];
    grouthVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:grouthVc animated:YES];
}

//二维码扫描事件
- (void)onRightBtn:(UIBarButtonItem*)sender
{
 
    ScanViewController *scanVc = [ScanViewController new];
    scanVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
