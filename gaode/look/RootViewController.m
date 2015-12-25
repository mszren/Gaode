//
//  ViewController.m
//  gaode
//
//  Created by 我 on 15/9/29.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "RootViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "CustomAnnotationView.h"
#import <AMapSearchKit/AMapSearchServices.h>

@interface RootViewController ()<MAMapViewDelegate,AMapSearchDelegate>

@end

@implementation RootViewController{
    
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    NSMutableArray *_pins;
    AMapInputTipsSearchRequest * _tipsRequest;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _pins = [[NSMutableArray alloc]init];
    
    [[MAMapServices sharedServices]setApiKey:@"41362367de09e170db28094b117e3e1f"];
    [[AMapSearchServices sharedServices]setApiKey:@"41362367de09e170db28094b117e3e1f"];
    
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsCompass = YES;//指南针
    _mapView.showsScale = YES;//比例尺

    
    //地图的缩放级别的范围是[3-19],调用 MAMapView 的 setZoomLevel 方法设置地图的缩放级别, 用来缩放地图。示例代码如下:
    [_mapView setZoomLevel:10 animated:YES];
    
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
    
    //后台定位
//    _mapView.pausesLocationUpdatesAutomatically = NO;
    
    
//    //圆
//    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.989631, 116.481018) radius:2000];
//    [_mapView addOverlay:circle];
    
    //标注
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(31.818884, 117.221945);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街 6 号";
    [_mapView addAnnotation:pointAnnotation];
    
    //初始中心点
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.818884, 117.221945);
    MACoordinateSpan span = MACoordinateSpanMake(0.1, 0.1);
    MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region];
    
    
    //关键字搜索
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc]init];
    request.keywords = @"建科大厦";
    request.city = @"合肥";
    request.requireExtension = YES;
//    [_search AMapPOIKeywordsSearch:request];
    
    
    //反向地理编码
    //构造 AMapReGeocodeSearchRequest 对象,location 为必选项,radius 为可选项
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:31.818884 longitude:117.221945];
    regeoRequest.location = point;
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;
    //发起逆地理编码
//    [_search AMapReGoecodeSearch: regeoRequest];
    
    //构造 AMapInputTipsSearchRequest 对象,keywords 为必选项,city 为可选项
    _tipsRequest= [[AMapInputTipsSearchRequest alloc] init];
    _tipsRequest.keywords = @"望";
    _tipsRequest.city = @"合肥";
    
    //发起输入提示搜索
//    [_search AMapInputTipsSearch: _tipsRequest];
    
}


//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0) {
        return; }
    //处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
    NSString *strtips = @"";
    for (AMapTip *p in response.tips) {
        strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.formattedDescription.description];
    }

    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
    NSLog(@"InputTips: %@", result);
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil) {
        //处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@",response.regeocode.formattedAddress];
      
         NSLog(@"ReGeo: %@", result); }
}

//AMapSearchDelegate协议里定义的方法，搜索完成时调用
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    for (AMapPOI *poi in response.pois) {
        NSLog(@"response name:%@, address:%@, latitude:%f, longitude:%f", poi.name, poi.address, poi.location.latitude, poi.location.longitude);
        
        if (response.pois.count == 0) {
            return;
        }
        
        //创建大头针
        MAPointAnnotation *pin = [[MAPointAnnotation alloc]init];
        pin.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);//大头针坐标
        pin.title = poi.name;
        pin.subtitle = poi.address;
        [_pins addObject:pin];
    }
    [_mapView addAnnotations:_pins];
    
    [_mapView showAnnotations:_pins animated:NO];
    
}

//自定义定位图层
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证 userlocation 的 annotationView 已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {

        view.calloutOffset = CGPointMake(0, 0); }

}
        

//当位置更新时,会进定位回调,通过回调函数,能获取到定位点的经纬度坐标,示例代码如下:
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

//标注
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
            
            static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
            CustomAnnotationView *annotationView =  [[CustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            
            UIImage *bgImage = [UIImage imageNamed:@"annotationPin"];
            
            annotationView.frame = CGRectMake(0.0f, 0.0f, bgImage.size.width, bgImage.size.height);
            
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


//圆形区域
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        circleView.lineWidth = 2.6f;
        circleView.strokeColor = [UIColor redColor];
        circleView.fillColor = [UIColor redColor];
        return circleView; }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
