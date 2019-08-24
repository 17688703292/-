//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#ifndef XHColor_h
#define XHColor_h

//---------------------------- color ----------------------------
#define kRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/** 系统白 */
#define kWhite      [UIColor whiteColor]
/** 系统黑 */
#define kBlack      [UIColor blackColor]
/** 系统灰 */
#define kDarkGray  [UIColor darkGrayColor]
#define kGray      [UIColor grayColor]
#define kLightGray [UIColor lightGrayColor]

/** 系统透明 */
#define kClear      [UIColor clearColor]
/** 分割灰白 */
#define kGraywhite  [UIColor colorWithWhite:0.85 alpha:1]
/** 透明黑 */
#define kClearBlack kRGBAColor(0x00, 0x00, 0x00, 0.5)
/** tableView Group */
#define kGroupGray [UIColor groupTableViewBackgroundColor]
/** 主题色 */
#define kThemeColor [UIColor colorWithHexString:@"#F6383D"]

/** 主题按钮不可点颜色 */
#define kDisableColor kRGBAColor(57, 195, 120, 0.5)


/** 背景色灰 */
#define kBackgroundColor_yun [UIColor colorWithHexString:@"#e2e2e2"]
#define kBackgroundColor [UIColor colorWithHexString:@"#F2F2F2"]
#define kBackgroundTransparentColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5] //背景虚化

/** cell选中颜色 */
#define kCellGray     kRGBColor(0xd7,0xd7,0xd7)
//---------------------------- color -----------------------------------

#endif /* XHColor_h */
