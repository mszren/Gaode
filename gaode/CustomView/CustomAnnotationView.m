//
//  CustomAnnotationView.m
//  gaode
//
//  Created by 我 on 15/10/9.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "CustomAnnotationView.h"


#define kCalloutWidth 200.0 
#define kCalloutHeight 70.0
@implementation CustomAnnotationView


#pragma mark - Lifecycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.draggable = NO;
        self.canShowCallout = NO;
    }
    
    return self;
}


@end
