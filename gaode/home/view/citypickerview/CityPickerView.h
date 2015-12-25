//
//  CityPickerView.h
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CityPickerProvince.h"

@protocol CityPickerViewDelegate <NSObject>

- (void)CityPickerViewReturnCity:(NSString *)resultCity;

@end
@interface CityPickerView : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,weak)id<CityPickerViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,assign)BOOL isCertain;
@property (nonatomic,strong)NSMutableArray *provinces;
@property (nonatomic,strong)NSString *resultCity;

+ (instancetype)sharedInstance;

- (void)showCityPickerView:(NSString *)city andDelegate:(id<CityPickerViewDelegate>)delegate;

@end
