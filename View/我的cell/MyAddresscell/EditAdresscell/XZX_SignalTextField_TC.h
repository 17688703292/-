//
//  XZX_SignalTextField_CC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZX_SignalTextField_Delegate <NSObject>

-(void)Input_Message_SignalTextField_Delegate:(NSInteger )tag TextField:(NSString *)Str;

@end

@interface XZX_SignalTextField_TC : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Input_Message;

@property (nonatomic,weak)id<XZX_SignalTextField_Delegate>delegate;


@end

NS_ASSUME_NONNULL_END
