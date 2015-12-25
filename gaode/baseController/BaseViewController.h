//
//  BaseViewController.h
//  gaode
//
//  Created by 我 on 15/10/13.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController{
    UIButton* _inviteBtn;
}
- (void)initializeNavTitleView:(NSString*)titileStr;
- (void)initializeNavBackView;

- (void)initializeWhiteBackgroudView:(NSString*)titileStr;

- (void)setRedNavBg;
- (void)setWhiteNavBg;
- (void)setCleanNavBg;

- (void)setBackToRoot:(BOOL)iToRoot;
@end
