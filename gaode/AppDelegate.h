//
//  AppDelegate.h
//  gaode
//
//  Created by 我 on 15/9/29.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootBar.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootBar* tabController;


+ (AppDelegate*)shareDelegate;

@end

