//
//  CustomAnnotationView.h
//  gaode
//
//  Created by 我 on 15/10/9.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *faceImg;


@end
