//
//  publishVIew.h
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavController.h"

@protocol FirstTagViewDelegate <NSObject>

-(void)FirstTagViewDelegateWithTag:(NSString *)tag;

@end

@interface FirstTagView : NSObject
@property (nonatomic,weak) id <FirstTagViewDelegate> delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)BaseNavController * naVc;
@property (nonatomic,strong)UIButton *oldBtn;
@property (nonatomic,strong)NSString *tag;

+ (instancetype)sharedInstance;

-(void)showFirstTagView:(id<FirstTagViewDelegate>)delegate;

@end
