//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XHEmoji)
// http://www.emoji-cheat-sheet.com

/**
 表情编码
 @return 编码后String
 */
- (NSString *)xh_emojiEncode;
/**
 表情解码
 @return 解码后String
 */
- (NSString *)xh_emojiDecode;
/**
 表情转换Unicode
 @return 转换后String
 */
- (NSString *)xh_stringByReplacingEmojiCheatCodesWithUnicode;
/**
 Unicode转换表情
 @return 转换后String
 */
- (NSString *)xh_stringByReplacingEmojiUnicodeWithCheatCodes;

@end
