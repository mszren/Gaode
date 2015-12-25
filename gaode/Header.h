//
//  Header.h
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#ifndef gaode_Header_h
#define gaode_Header_h

#define KCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define KGreaterThanSevenSystemVersion (KCurrentSystemVersion >= 7.0)
#define KLessThanSevenSystemVersion (KCurrentSystemVersion < 7.0)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



// COLOR
#define RGBCOLOR(r, g, b) \
[UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define RGBACOLOR(r, g, b, a)         \
[UIColor colorWithRed:(r) / 255.0 \
green:(g) / 255.0 \
blue:(b) / 255.0 \
alpha:(a)]

#define HEXColor_Method                                                                                          \
-(UIColor*)getColor : (NSString*)hexColor                                                                    \
{                                                                                                            \
hexColor = [hexColor stringByReplacingCharactersInRange:[hexColor rangeOfString:@"#"] withString:@"0x"]; \
long colorLong = strtoul([hexColor cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);                   \
int R = (colorLong & 0xFF0000) >> 16;                                                                    \
int G = (colorLong & 0x00FF00) >> 8;                                                                     \
int B = colorLong & 0x0000FF;                                                                            \
return [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.0];                        \
}

#define HomeNavBarBgColor RGBCOLOR(243, 102, 54)

// tab bar
#define TabBarColor RGBCOLOR(239, 239, 239)
#define TabBarHeight 64
#define SearchBarHeight 44
#define InviteBarHeight 55
#define InviteBarBgColor RGBCOLOR(219, 77, 73)

// VIEW TAG
#define STATUS_BACKGROUND_TAG 201409

// top bar
#define TopBarHeight 44
#define TopViewTitleColor RGBCOLOR(92, 92, 92)
#define HomeNavBarBgColor RGBCOLOR(243, 102, 54)
#define HomeNavBarTitleColor RGBCOLOR(255, 255, 255)
#define HomeNavBarTitleFont FONT_SIZE_19
#define HomeNavBarNavItemFont FONT_SIZE_16

// table
#define TableViewColor RGBCOLOR(92, 92, 92)
#define AllTableViewColor RGBCOLOR(238, 238, 238)
#define TableChatHomeCellHeight 60
#define TableLeftSpaceWidth 15
#define TableRightSpaceWidth 15
#define TableLeftImageSpaceWidth 5
#define TableTopSpaceWidth 10
#define TableCellLeftImgWidth 45
#define TableCellHeaderImageWidth 45
#define TableCellRightTimeLabelWidth 80

#define TableCellTitleFont FONT_SIZE_15
#define TableCellTitleColor RGBCOLOR(31, 31, 31)
#define TableCellDescFont FONT_SIZE_13
#define TableCellTimeFont FONT_SIZE_12
#define TableCellDescColor RGBCOLOR(120, 120, 120)
#define TableCellNewsColor RGBCOLOR(247, 116, 64)
#define TableSectionColor RGBCOLOR(247, 116, 64)
#define TableSeparatorColor RGBCOLOR(224, 224, 224)

#define BGViewColor RGBCOLOR(255, 255, 255)
#define BGViewColor1 RGBCOLOR(237, 238, 241)
#define BGViewGray RGBCOLOR(242, 242, 242)


//TEXT COLOR
#define GREEN_COLOR [UIColor greenColor]
#define WHITE_COLOR [UIColor whiteColor]

// FONT
#define FONT_SIZE_DEFAULT 10
#define FONT_SIZE_MEDIUM 16
#define FONT_SIZE_LARGE 22
#define FONT_SIZE_SONAR 18
#define FONT_NAME_BOLD @"Helvetica-Bold"
#define FONT_NAME @"Helvetica"
#define FONT_SIZE(s) [UIFont fontWithName:FONT_NAME size:s]
#define FONT_SIZE_BOLD(s) [UIFont fontWithName:FONT_NAME_BOLD size:s]
#define FONT_NAME_SIZE(n, s) [UIFont fontWithName:n size:s]

#define FONT_TITLE_DEFAULT FONT_NAME_SIZE(FONT_NAME_BOLD, FONT_SIZE_DEFAULT)
#define FONT_TITLE_MEDIUM FONT_NAME_SIZE(FONT_NAME_BOLD, FONT_SIZE_MEDIUM)
#define FONT_TITLE_LARGE FONT_NAME_SIZE(FONT_NAME_BOLD, FONT_SIZE_LARGE)
#define FONT_BODY_DEFAULT FONT_NAME_SIZE(FONT_NAME, FONT_SIZE_DEFAULT)
#define FONT_BODY_MEDIUM FONT_NAME_SIZE(FONT_NAME, FONT_SIZE_MEDIUM)
#define FONT_BODY_LARGE FONT_NAME_SIZE(FONT_NAME, FONT_SIZE_LARGE)
#define FONT_SONAR_TITLE FONT_NAME_SIZE(FONT_NAME_BOLD, FONT_SIZE_SONAR)

#define FONT_SIZE_11 FONT_SIZE(11)
#define FONT_SIZE_12 FONT_SIZE(12)
#define FONT_SIZE_13 FONT_SIZE(13)
#define FONT_SIZE_14 FONT_SIZE(14)
#define FONT_SIZE_15 FONT_SIZE(15)
#define FONT_SIZE_16 FONT_SIZE(16)
#define FONT_SIZE_17 FONT_SIZE(17)
#define FONT_SIZE_18 FONT_SIZE(18)
#define FONT_SIZE_19 FONT_SIZE(19)
#define FONT_SIZE_20 FONT_SIZE(20)

#define FONT_SIZE_ITALIC_15 FONT_SIZE(15)
#define FONT_SIZE_BOLD_10 FONT_NAME_SIZE(FONT_NAME_BOLD, 10)
#define FONT_SIZE_BOLD_11 FONT_NAME_SIZE(FONT_NAME_BOLD, 11)
#define FONT_SIZE_BOLD_12 FONT_NAME_SIZE(FONT_NAME_BOLD, 12)
#define FONT_SIZE_BOLD_13 FONT_NAME_SIZE(FONT_NAME_BOLD, 13)
#define FONT_SIZE_BOLD_14 FONT_NAME_SIZE(FONT_NAME_BOLD, 14)
#define FONT_SIZE_BOLD_15 FONT_NAME_SIZE(FONT_NAME_BOLD, 15)
#define FONT_SIZE_BOLD_16 FONT_NAME_SIZE(FONT_NAME_BOLD, 16)
#define FONT_SIZE_BOLD_17 FONT_NAME_SIZE(FONT_NAME_BOLD, 17)
#define FONT_SIZE_BOLD_18 FONT_NAME_SIZE(FONT_NAME_BOLD, 18)
#define FONT_SIZE_BOLD_19 FONT_NAME_SIZE(FONT_NAME_BOLD, 19)
#define FONT_SIZE_BOLD_20 FONT_NAME_SIZE(FONT_NAME_BOLD, 20)

#define ChatContentFont [UIFont systemFontOfSize:20] //内容字体

#define CommonFontColor RGBCOLOR(239, 239, 239)

typedef enum {
    kPRStateNormal = 0,
    kPRStatePulling = 1,
    kPRStateLoading = 2,
    kPRStateHitTheEnd = 3
} PRState;

// language
#define Refresh_More @"加载更多"
#define Refresh_NOData @"没有数据"
#define Refresh_Therefresh @"下拉刷新"
#define Refresh_Refreshing @"正在刷新"
#define Refresh_Loading @"正在拼命加载"
#define Refresh_Release_refresh @"释放刷新"
#define Refresh_Release_load_more @"释放加载更多"
#define Refresh_Pull_up_loading_more @"上拉加载更多"
#define Refresh_No_oh @"没有了哦"
#define Refresh_Today @"今天"
#define Refresh_Yesterday @"昨天"
#define Refresh_The_day_before_yesterday @"前天"
#define Refresh_Last_update @"最后更新"
#define Refresh_Drag_can_refresh @"下拉可以刷新..."
#define Refresh_Undo_can_refresh @"松开即可刷新..."

#define ChatCachePerCount 10

// SegmentedControl
#define SegWidth 180
#define seghight 29

//文件操作
#define FILEHOMENAME [@"File_cache" stringByAppendingFormat:@"/User_%ld", [CurrentAccount currentAccount].uid]
#define FILEPDFNAME @"PDFFileCache"
#define FILEMP4NAME @"MP4FileCache"
#define FILEMP3NAME @"MP3FileCache"
#define WEBVIEW @"URLCACHE"

#define FileZipUrl @"PDFZipUrl"
#define FileVerionHistory @"FileVerionHistory"
#define FileVerionCurrent @"FileVerionCurrent"

//发布
#define PublishImageTileWidth ([UIScreen mainScreen].bounds.size.width - 100)/4
#define PublishImageTileHeight ([UIScreen mainScreen].bounds.size.width - 100)/4

// SegmentedControl
#define SegWidth 180
#define seghight 29

#endif
