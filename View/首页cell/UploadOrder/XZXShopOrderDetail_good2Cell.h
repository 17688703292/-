//
//  XZXShopOrderDetail_good2Cell.h
//  DoorLock
//
//  Created by RedSky on 2019/3/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXShopOrderDetail_good2Cell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Input_content;

@property (nonatomic,copy)void (^InputcontentBlock)(NSString *content);
@end

NS_ASSUME_NONNULL_END
