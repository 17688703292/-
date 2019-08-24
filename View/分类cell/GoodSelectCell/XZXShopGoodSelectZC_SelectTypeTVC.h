//
//  XZXShopGoodSelectZC_SelectTypeTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XZXShopGoodSelectZC_SelectTypeDelegate <NSObject>

-(void)DidselectAllPayMoney:(BOOL )IsAllPay;

@end

@interface XZXShopGoodSelectZC_SelectTypeTVC : UITableViewCell
@property (nonatomic,weak)id<XZXShopGoodSelectZC_SelectTypeDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *AllPayBtn;
- (IBAction)AllPay_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *OnePayBtn;
- (IBAction)OnePay_Action:(id)sender;
@end

NS_ASSUME_NONNULL_END
