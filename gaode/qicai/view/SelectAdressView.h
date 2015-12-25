//
//  SelectAdressView.h
//  gaode
//
//  Created by 我 on 15/10/29.
//  Copyright © 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectAdressViewDelegate <NSObject>

-(void)SelectAdressViewDelegateWithTag:(NSString *)tag;
@end

@interface SelectAdressView : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic,weak) id <SelectAdressViewDelegate> delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UIButton *oldBtn;

-(void)showSelectAdressView:(id<SelectAdressViewDelegate>)delegate andTag:(NSInteger)tag;
@end
