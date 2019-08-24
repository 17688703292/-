//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#ifndef XHFont_h
#define XHFont_h

//---------------------------- font -----------------------------------
#pragma mark - UIFont
/**    字体 */
#define kFont(s)      [UIFont systemFontOfSize:s]
/**    粗体 */
#define kBoldFont(s)  [UIFont boldSystemFontOfSize:s]
//如果用其它字体直接用 kFont(s) 和 粗体 kBoldFont(s)

/** 特大号字 */
#define kFont_ExtraLarge       kFont(21)
/** 大号字，用于价格等稍大字体 */
#define kFont_Large             kFont(17)
/** 中号字，用于店铺名，商品名，分类名等普遍字体 */
#define kFont_Medium          kFont(15)
/** 小号字，用于店铺介绍，商品介绍等稍小号字体 */
#define kFont_Small             kFont(12)
/** 特小号字，用于时间等字体 */
#define kFont_ExtraSmall      kFont(10)
//---------------------------- font -----------------------------------

#endif /* XHFont_h */
