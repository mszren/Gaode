//
//  SelectPublicView.h
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DRUATIONTIME 0.2
#define DRUATIONTIME2 0.1
@interface SelectPublicView : NSObject

@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController *viewController;
@property (nonatomic,strong)UINavigationController *naVc;

+(instancetype)sharedInstance;

- (void)showSelectPublicView:(UINavigationController *)viewController;
@end
