//
//  GrowTreeCommentView.h
//  gaode
//
//  Created by 我 on 15/11/3.
//  Copyright © 2015年 我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GrowTreeCommentViewDelegate <NSObject>

- (void)growTreeCommentViewDelegateWithComment:(NSString *)content;

@end

@interface GrowTreeCommentView : NSObject <UITextFieldDelegate>
@property (nonatomic,weak)id<GrowTreeCommentViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UITextField *commentText;
@property (nonatomic,strong)UIButton *publishBtn;

+ (instancetype)sharedInstance;
- (void)showGrowTreeCommentView:(NSString *)placehodel andBtnTitle:(NSString *)title withDelegate:(id<GrowTreeCommentViewDelegate>)delegate;

@end
