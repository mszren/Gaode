//
//  publishVIew.h
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeelingViewDelegate <NSObject>

-(void)FeelingViewDelegateWithTag:(NSString *)tag;

@end

@interface FeelingView : NSObject
@property (nonatomic,weak) id <FeelingViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UIButton *oldBtn;
@property (nonatomic,strong)NSString *tag;

+ (instancetype)sharedInstance;

-(void)showFeelingView:(id<FeelingViewDelegate>)delegate;

@end
