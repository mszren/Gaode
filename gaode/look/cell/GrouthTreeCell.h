//
//  GrouthTreeCell.h
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView.h"
#import "BaseViewController.h"
#import "CMPopTipView.h"
#import "HYActivityView.h"
#import "GrowTreeCommentView.h"

@interface GrouthTreeCell : UITableViewCell <AlertViewDelegate,CMPopTipViewDelegate,GrowTreeCommentViewDelegate>
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;
@property (nonatomic, strong)	id				currentPopTipViewTarget;
@property (nonatomic,strong)HYActivityView *activityView;

@end
