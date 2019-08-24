//
//  XZXMine_ScoreListCell2.m
//  BigMarket
//
//  Created by RedSky on 2019/6/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_ScoreListCell2.h"

@implementation XZXMine_ScoreListCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.RechargeBtn.cornerRadius = 15.0;
    self.CrashBtn.cornerRadius = 15.0;
    self.CrashBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.CrashBtn.layer.borderWidth = 1.0;
    
    UITapGestureRecognizer *ShareScore_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareScore_Action)];
    [self.ShareScoreLabel addGestureRecognizer:ShareScore_tap];
    self.ShareScoreLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *Agent_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Agent_Action)];
    [self.AgentLabel addGestureRecognizer:Agent_tap];
    self.AgentLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *Extension_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Extension_Action)];
    [self.ExtensionLabel addGestureRecognizer:Extension_tap];
    self.ExtensionLabel.userInteractionEnabled = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Recharge_Action:(id)sender {
    if (self.RechargeBlock) {
        self.RechargeBlock();
    }
}

- (IBAction)Crash_Action:(id)sender {
    if (self.CrashBlock) {
        self.CrashBlock();
    }
}

- (IBAction)Explain_Action:(id)sender {
    
    if (self.ExplainBlock) {
        
        self.ExplainBlock();
    }
}


-(void)ShareScore_Action{
    
    if ([self.delegate respondsToSelector:@selector(DidSelectAgent:)]) {
        [self.delegate DidSelectAgent:1];
    }
    

}


-(void)Agent_Action{
    
    
    if ([self.delegate respondsToSelector:@selector(DidSelectAgent:)]) {
        [self.delegate DidSelectAgent:2];
    }
    
}


-(void)Extension_Action{
    
    
    if ([self.delegate respondsToSelector:@selector(DidSelectAgent:)]) {
        [self.delegate DidSelectAgent:3];
    }
    
}

@end
