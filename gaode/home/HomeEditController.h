//
//  EditController.h
//  gaode
//
//  Created by 我 on 15/11/4.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^editBlock) (NSString *);

@interface HomeEditController : BaseViewController
@property (nonatomic,strong)NSString *text;
@property (nonatomic,copy)editBlock editBlock;

@end
