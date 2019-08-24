//
//  XZXMine_ScoreListCell2.h
//  BigMarket
//
//  Created by RedSky on 2019/6/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXMine_ScoreListCell2Delegate <NSObject>
//index 1省代理 2、市代理 3、县代理
-(void)DidSelectAgent:(NSInteger )index;

@end

@interface XZXMine_ScoreListCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalScore;
@property (weak, nonatomic) IBOutlet UIButton *RechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *CrashBtn;
@property (weak, nonatomic) IBOutlet UILabel *ShareScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *AgentLabel;
@property (weak, nonatomic) IBOutlet UILabel *ExtensionLabel;
- (IBAction)Recharge_Action:(id)sender;
- (IBAction)Crash_Action:(id)sender;
- (IBAction)Explain_Action:(id)sender;


@property (nonatomic,weak)id<XZXMine_ScoreListCell2Delegate>delegate;
@property (nonatomic,copy)void(^RechargeBlock)(void);
@property (nonatomic,copy)void(^CrashBlock)(void);
@property (nonatomic,copy)void(^ExplainBlock)(void);
@end

NS_ASSUME_NONNULL_END
