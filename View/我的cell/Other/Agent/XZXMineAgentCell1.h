//
//  XZXMineAgentCell1.h
//  BigMarket
//
//  Created by RedSky on 2019/5/22.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface XZXMineAgentCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *ViewBtn;
- (IBAction)View_Action:(id)sender;

@property (nonatomic,copy)void (^ViewProduceBlock)(void);
@end

NS_ASSUME_NONNULL_END
