//
//  SexEditView.h
//  gaode
//
//  Created by 我 on 15/11/4.
//  Copyright © 2015年 我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SexEditViewDelegate <NSObject>

- (void)SexEditViewSelectSex:(NSString *)sex;

@end

@interface SexEditView : NSObject
@property (nonatomic,weak)id<SexEditViewDelegate>deldegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *boyLabel;
@property (nonatomic,strong)UILabel *girlLabel;
@property (nonatomic,strong)NSString *selectSex;

+ (instancetype)sharedInstance;

- (void)showEditView:(NSString *)sex andDelegate:(id<SexEditViewDelegate>)delegate;
@end
