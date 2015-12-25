 
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
@protocol MyDatePickerDelegate <NSObject>

-(void) MyDatePickerDidConfirm:(NSString *)confirmString;

@end
@interface MyDatePicker : NSObject<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,weak) id <MyDatePickerDelegate> delegate;
@property (nonatomic,strong)NSArray *monthArry;
@property (nonatomic,strong)NSArray *daysArry;
@property (nonatomic,strong)NSArray *hoursArry;
@property (nonatomic,strong)NSArray *minuteArry;

@property (nonatomic,strong)UIPickerView *yearPicker;
@property (nonatomic,strong)UIPickerView *monthPicker;
@property (nonatomic,strong)UIPickerView *dayPicker;
@property (nonatomic,strong)UIPickerView *hourPicker;
@property (nonatomic,strong)UIPickerView *munitePicker;
@property (nonatomic,assign)NSInteger yearCount;
@property (nonatomic,strong)NSString * years;
@property (nonatomic,strong)NSString *selectYear;
@property (nonatomic,strong)NSString *selectMonth;
@property (nonatomic,strong)NSString *selectDay;
@property (nonatomic,strong)NSString *selectHour;
@property (nonatomic,strong)NSString *selectMinute;

@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;

+ (instancetype)sharedInstance;

-(void)initWithSelectTitle:(NSString *)title  delegate:(id<MyDatePickerDelegate>)delegate;

@end
