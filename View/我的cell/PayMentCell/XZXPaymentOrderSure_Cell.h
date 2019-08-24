//
//  XZXPaymentOrderSure_Cell.h
//  Slumbers
//
//  Created by RedSky on 2019/2/22.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XZXPaymentOrderSure_Cell;
@protocol XZXPaymentOrderSure_CellDelegate <NSObject>


-(void)PayMoney;

@end

@interface XZXPaymentOrderSure_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
@property (nonatomic,weak)id <XZXPaymentOrderSure_CellDelegate> delegate;

- (IBAction)Sure_Action:(id)sender;

@end

NS_ASSUME_NONNULL_END
