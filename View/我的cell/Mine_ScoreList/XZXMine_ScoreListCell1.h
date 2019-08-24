//
//  XZXMine_ScoreListCell1.h
//  BigMarket
//
//  Created by RedSky on 2019/6/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_ScoreListCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalScore;
@property (weak, nonatomic) IBOutlet UIButton *ScoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *ExtensionLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
- (IBAction)ViewProduce_Action:(id)sender;
- (IBAction)BuyProduct_Action:(id)sender;

@property(nonatomic,copy)void(^ViewProduceBlock)(void);
@property(nonatomic,copy)void(^BuyProductBlock)(void);
@end

NS_ASSUME_NONNULL_END
