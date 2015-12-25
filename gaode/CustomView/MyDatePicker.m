
#import "MyDatePicker.h"

#define HEGIHT 150
@implementation MyDatePicker


+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedInstance = [[[self class]alloc]init];
    });
    return sharedInstance;
    
}

-(void)initWithSelectTitle:(NSString *)title  delegate:(id<MyDatePickerDelegate>)delegate{
    
    self.delegate = delegate;

    self.monthArry = [[NSArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    
    self.daysArry = [[NSArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",nil];
    
    self.hoursArry = [[NSArray alloc]initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",nil];
    
    self.minuteArry = [[NSArray alloc]initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59", nil];
    
    
        //获得系统当前时间
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
         NSString *destDateString;
        if (title == nil || [title isEqualToString:@""] || (title == NULL) || (title.length == 0) ) {
        
           destDateString = [dateFormatter stringFromDate:date];
       }else{
           
           destDateString = title;
       }
    
        
        NSMutableString *string1 = [NSMutableString stringWithString:destDateString];
        [string1 deleteCharactersInRange:NSMakeRange(4, string1.length-4)];
        self.years = [NSString stringWithFormat:@"%@",string1];
        
        NSMutableString *string2 = [NSMutableString stringWithString:destDateString];
        [string2 deleteCharactersInRange:NSMakeRange(0, 5)];
        [string2 deleteCharactersInRange:NSMakeRange(2, string2.length - 2)];
        NSString *months = [NSString stringWithFormat:@"%@",string2];
        
        NSMutableString *string3 = [NSMutableString stringWithString:destDateString];
        [string3 deleteCharactersInRange:NSMakeRange(0, 8)];
        [string3 deleteCharactersInRange:NSMakeRange(2, string3.length - 2)];
        NSString *days = [NSString stringWithFormat:@"%@",string3];
        
        NSMutableString *string4 = [NSMutableString stringWithString:destDateString];
        [string4 deleteCharactersInRange:NSMakeRange(0, 11)];
        [string4 deleteCharactersInRange:NSMakeRange(2, string4.length - 2)];
        NSString *hours = [NSString stringWithFormat:@"%@",string4];
        
        NSMutableString *string5 = [NSMutableString stringWithString:destDateString];
        [string5 deleteCharactersInRange:NSMakeRange(0, 14)];
        NSString *minutes = [NSString stringWithFormat:@"%@",string5];
        
//        NSLog(@"%@年 %@月 %@日 %@时 %@分",years,months,days,hours,minutes);
 

        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.window.opaque = NO;
        
        _viewController = [[UIViewController alloc]init];
        self.window.rootViewController = _viewController;
    
    
        UIButton *styleView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
        styleView.tag = 100;
        [_viewController.view addSubview:styleView];
        [styleView addTarget:self action:@selector(dateConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        _backGroundView.alpha = 1;
        _backGroundView.backgroundColor = [UIColor whiteColor];
        [_viewController.view addSubview:_backGroundView];
        
        UILabel *greenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        greenLabel.backgroundColor = [UIColor greenColor];
        [_backGroundView addSubview:greenLabel];
        
        
        //年
        self.yearPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 10,SCREEN_WIDTH/5, HEGIHT)];
        self.yearPicker.delegate = self;
        self.yearPicker.dataSource = self;
        self.yearPicker.showsSelectionIndicator = YES;
        [_backGroundView addSubview:self.yearPicker];
        
        //月
        self.monthPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, 10,SCREEN_WIDTH/5, HEGIHT)];
        self.monthPicker.delegate = self;
        self.monthPicker.dataSource = self;
        self.monthPicker.showsSelectionIndicator = YES;
        [_backGroundView addSubview:self.monthPicker];
        
        //日
        self.dayPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*2, 10,SCREEN_WIDTH/5, HEGIHT)];
        self.dayPicker.delegate = self;
        self.dayPicker.dataSource = self;
        self.dayPicker.showsSelectionIndicator = YES;
        [_backGroundView addSubview:self.dayPicker];
        
        //时
        self.hourPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*3, 10,SCREEN_WIDTH/5, HEGIHT)];
        self.hourPicker.delegate = self;
        self.hourPicker.dataSource = self;
        self.hourPicker.showsSelectionIndicator = YES;
        [_backGroundView addSubview:self.hourPicker];
        
        //分
        self.munitePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*4, 10,SCREEN_WIDTH/5, HEGIHT)];
        self.munitePicker.delegate = self;
        self.munitePicker.dataSource = self;
        self.munitePicker.showsSelectionIndicator = YES;
        [_backGroundView addSubview:self.munitePicker];
        
        //初始化时间
        NSInteger year = self.years.integerValue;
        self.yearCount = year - 1949;
        [self.yearPicker selectRow:self.yearCount-1 inComponent:0 animated:YES];
        self.selectYear = [NSString stringWithFormat:@"%ld",(long)year];
        
        NSInteger month = months.integerValue;
        [self.monthPicker selectRow:month-1 inComponent:0 animated:YES];
        self.selectMonth = [NSString stringWithFormat:@"%02ld",(long)month];
    
        NSInteger day = days.integerValue;
        [self.dayPicker selectRow:day-1 inComponent:0 animated:YES];
        self.selectDay = [NSString stringWithFormat:@"%02ld",(long)day];

        NSInteger hour = hours.integerValue;
        [self.hourPicker selectRow:hour inComponent:0 animated:YES];
        self.selectHour = [self.hoursArry objectAtIndex:hour];
        
        NSInteger minute = minutes.integerValue;
        [self.munitePicker selectRow:minute inComponent:0 animated:YES];
        self.selectMinute = [self.minuteArry objectAtIndex:minute];
        
        NSArray *buttonsName = @[@"确定",@"取消"];
        for (NSInteger i =0; i < buttonsName.count ; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame  = CGRectMake(0 +  SCREEN_WIDTH/2*i,160,SCREEN_WIDTH/2,40);
            button.tag = 200 +i;
            button.userInteractionEnabled = YES;
            button.adjustsImageWhenHighlighted = NO;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:buttonsName[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(dateConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_backGroundView addSubview:button];
        }
                                                                        
        // The window has to be un-hidden on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.window makeKeyAndVisible];
            
            _backGroundView.alpha = 0;
            _backGroundView.layer.shouldRasterize = YES;
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            [UIView animateWithDuration:0.2 animations:^{
                
                _backGroundView.alpha = 1;
                _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    _backGroundView.alpha = 1;
                    _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                } completion:^(BOOL finished2) {
                    _backGroundView.layer.shouldRasterize = NO;
                    
                }];
                
                
                
            }];
            
        });
        
}

#pragma mark
#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
-(NSArray *)pickerViewAnimalAtIndexes:(NSIndexSet *)indexes
{
    return nil;
}

//返回滚轮的数量
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//当row被选中的时候
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.yearPicker) {
        
        NSInteger year = 1950 + row;
        _selectYear = [NSString stringWithFormat:@"%ld",(long)year];
        [self.dayPicker reloadAllComponents];
        
    }else if (pickerView == self.monthPicker){
        
        _selectMonth = [self.monthArry objectAtIndex:row];
        [self.dayPicker reloadAllComponents];
       
    }else if (pickerView == self.dayPicker){
        
        if (row >=0 && row < 9) {
            
            _selectDay = [self.daysArry objectAtIndex:row];
        }else{
            
            NSInteger day = row + 1;
            _selectDay = [NSString stringWithFormat:@"%ld",(long)day];
        }
        
    }else if (pickerView == self.hourPicker){
        
        _selectHour = [self.hoursArry objectAtIndex:row];
        
    }else{
        
        _selectMinute = [self.minuteArry objectAtIndex:row];
    }
    
}

//返回滚轮的row数量
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.yearPicker) {
        NSInteger year = self.years.integerValue;
        return year - 1949;
        
    }else if (pickerView == self.monthPicker){
        
        return 12;
    }else if (pickerView == self.dayPicker){
 
 
        NSInteger month = self.selectMonth.integerValue;
        NSInteger year = self.selectYear.integerValue;
        if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
            
            return 31;
        }else if (month == 4 || month == 6 || month == 9 || month == 11){
            
            return 30;
        }else{
            
            //判断是否是闰年
            if (((year%4==0)&&(year%100!=0))||(year%400==0)) {
                
                return 29;
            }else{
                
                return 28;
            }

        }
        
    }else if (pickerView == self.hourPicker){
        
        return 24;
    }else
        
        return 60;
    
}

//返回滚轮的row的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

//返回row显示的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == self.yearPicker) {
        
        NSInteger year = 1950 + row;
        NSString *years = [NSString stringWithFormat:@"%ld年",(long)year];
        return years;
    }else if (pickerView == self.monthPicker){
        
 
        return [self.monthArry objectAtIndex:row];
        
    }else if (pickerView == self.dayPicker){
        
        if (row >= 0 && row <9) {
            
            NSString *days = [NSString stringWithFormat:@"%@日",[self.daysArry objectAtIndex:row]];
            return  days;
        }else{
            
            NSInteger day = row + 1;
            NSString *days = [NSString stringWithFormat:@"%ld日",(long)day];
            return days;
        }
        
    }else if (pickerView == self.hourPicker){
        
        NSString *hours = [NSString stringWithFormat:@"%@时",[self.hoursArry objectAtIndex:row]];
        return hours;
    }else{
        
        NSString *minutes = [NSString stringWithFormat:@"%@分",[self.minuteArry objectAtIndex:row]];
        return minutes;
    }


}

#pragma mark
#pragma mark -- UIpickerViewDelegate
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = nil;
    
    if (component == 0) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH/5, 50)] ;
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        if (pickerView == self.yearPicker) {
            
            NSInteger year = 1950 + row;
            myView.text =  [NSString stringWithFormat:@"%ld年",(long)year];
            
        }else if (pickerView == self.monthPicker){
            
            
            myView.text  = [NSString stringWithFormat:@"%@月",[self.monthArry objectAtIndex:row]];
            
        }else if (pickerView == self.dayPicker){
            
            if (row >= 0 && row <9) {
                
                 myView.text = [NSString stringWithFormat:@"%@日",[self.daysArry objectAtIndex:row]];
            }else{
                
                NSInteger day = row + 1;
                myView.text = [NSString stringWithFormat:@"%ld日",(long)day];
            }
            
            
        }else if (pickerView == self.hourPicker){
            
           myView.text = [NSString stringWithFormat:@"%@时",[self.hoursArry objectAtIndex:row]];
            
            
        }else{
            
            myView.text = [NSString stringWithFormat:@"%@分",[self.minuteArry objectAtIndex:row]];
            
        }
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }else {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH/5, 50)] ;
        
        if (pickerView == self.yearPicker) {
            
            NSInteger year = 1950 + row;
            myView.text =  [NSString stringWithFormat:@"%ld年",(long)year];
            
        }else if (pickerView == self.monthPicker){
            
            myView.text  = [NSString stringWithFormat:@"%@月",[self.monthArry objectAtIndex:row]];
            
        }else if (pickerView == self.dayPicker){
            
            if (row >= 0 && row <9) {
                
                myView.text = [NSString stringWithFormat:@"%@日",[self.daysArry objectAtIndex:row]];
            }else{
                
                NSInteger day = row + 1;
                myView.text = [NSString stringWithFormat:@"%ld日",(long)day];
            }
            
        }else if (pickerView == self.hourPicker){
            
            myView.text = [NSString stringWithFormat:@"%@时",[self.hoursArry objectAtIndex:row]];
            
            
        }else{
            
            myView.text = [NSString stringWithFormat:@"%@分",[self.minuteArry objectAtIndex:row]];
            
        }
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:14];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    
    return myView;
}

//返回滚轮的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH/5;
}


#pragma mark
#pragma mark --UIButton Action
//确定选择
-(void)dateConfirmClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:{
            NSString * results = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.selectYear,self.selectMonth,self.selectDay,self.selectHour,self.selectMinute];
            [self.delegate MyDatePickerDidConfirm:results];
            
        }
            
            break;
            
        default:
            break;
    }
    
    [self clean];
    
}

//animation missView
-(void)clean
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _backGroundView.alpha = 0;
                _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            } completion:^(BOOL finished2) {
                
                [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
                [self.window removeFromSuperview];
                [self.backGroundView removeFromSuperview];
                self.viewController = nil;
                self.window = nil;
                
                
            }];
            
        }];
        
    });
    
}

                                                                        
@end
