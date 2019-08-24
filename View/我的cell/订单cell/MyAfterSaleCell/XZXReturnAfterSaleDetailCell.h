//
//  XZXReturnAfterSaleDetailCell.h
//  BigMarket
//
//  Created by RedSky on 2019/4/28.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XZXReturnAfterSaleDetailCell;
@protocol XZXReturnAfterSaleDetailCellDelegate <NSObject>

-(void)left_Action;
-(void)Right_Action:(XZXReturnAfterSaleDetailCell *)cell;

@end
@interface XZXReturnAfterSaleDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *EditApplication;
- (IBAction)EditApplication_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *CancelApplication;
- (IBAction)CancelApplication_Action:(id)sender;

@property (nonatomic,weak)id<XZXReturnAfterSaleDetailCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
