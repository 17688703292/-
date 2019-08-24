//
//  XZXSignalInputTextFieldTC.h
//  BigMarket
//
//  Created by RedSky on 2019/6/18.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXSignalInputTextFieldTC : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet XZXTextField *signalInputText;

@property (nonatomic,copy)void(^InputTextField)(NSString *contentStr,XZXSignalInputTextFieldTC *cellBlock);
@end

NS_ASSUME_NONNULL_END
