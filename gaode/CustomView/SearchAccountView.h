//
//  publishVIew.h
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavController.h"

@interface SearchAccountView : NSObject <UITextFieldDelegate>

@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UITextField *searText;
@property (nonatomic,strong)UIView *view;

+ (instancetype)sharedInstance;

-(void)showSearchAccountView:(UIView *)view;

@end
