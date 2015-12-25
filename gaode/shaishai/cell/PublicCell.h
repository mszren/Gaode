//
//  PublicCell.h
//  gaode
//
//  Created by 我 on 15/11/3.
//  Copyright © 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPopTipView.h"
#import "AlertView.h"
#import "HYActivityView.h"
#import "GrowTreeCommentView.h"

@interface PublicCell : UITableViewCell <CMPopTipViewDelegate,AlertViewDelegate,GrowTreeCommentViewDelegate>
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;
@property (nonatomic, strong)	id				currentPopTipViewTarget;
@property (nonatomic,strong)HYActivityView *activityView;

@end