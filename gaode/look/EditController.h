//
//  FamilyManagerController.h
//  
//
//  Created by 我 on 15/10/19.
//
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
typedef void (^BlockEditContent) (NSString *);
@interface EditController : BaseViewController

@property (nonatomic,copy)BlockEditContent editBlock;
@property (nonatomic,strong)NSString * editContent;

@end
