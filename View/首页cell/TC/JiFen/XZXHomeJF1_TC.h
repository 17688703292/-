//
//  XZXHomeJF1_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XZXHomeJF1Delegate <NSObject>

-(void)HomeJF1_DidselectLeft:(BOOL )IsSelect;

@end

@interface XZXHomeJF1_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
- (IBAction)left_action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)right_action:(id)sender;

@property (nonatomic,weak)id<XZXHomeJF1Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
