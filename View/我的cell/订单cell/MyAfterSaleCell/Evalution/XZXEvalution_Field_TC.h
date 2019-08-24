//
//  XZXEvalution_Field_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXEvalution_Field_TC : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *TextField;
@property (nonatomic,copy)void (^GetContent)(NSString *content);
@end

NS_ASSUME_NONNULL_END
