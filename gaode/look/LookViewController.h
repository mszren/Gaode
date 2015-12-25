//
//  LookViewController.h
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface LookViewController : BaseViewController
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;
@property (nonatomic, strong)	id				currentPopTipViewTarget;

@end
