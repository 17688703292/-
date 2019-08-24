//
//  XZXMinePersonMessage_TC.m
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMinePersonMessage_TC.h"
#import "CSTools.h"

@implementation XZXMinePersonMessage_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.signBtn.cornerRadius = 15.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Score_Action)];
    [self.jifenLabel addGestureRecognizer:tap];
    self.jifenLabel.userInteractionEnabled = YES;
    self.jifenLabel.adjustsFontSizeToFitWidth = YES;
    
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(View_Infomation)];
    [self.headImage addGestureRecognizer:tapImage];
    self.headImage.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tapCodeImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(View_Code)];
    [self.codeImage addGestureRecognizer:tapCodeImage];
    self.codeImage.userInteractionEnabled = YES;
    
    self.headImage.cornerRadius = kScreenWidth*0.373/4.0;
    
    self.MessageFlag_img.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMyModel:(XZXMinePersonMessageModel *)MyModel{

    [self.headImage sd_setImageWithURL:kImageUrl(@"",MyModel.memberImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.name.text = [MyModel.memberName length] != 0 ?MyModel.memberName:@"大云";
    self.jifenLabel.attributedText = [NSString changestringArray:@[[MyModel.memberScore isKindOfClass:[NSString class]] ? MyModel.memberScore:@"0",@"\n积分"] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"19.0",@"15.0"]];
    self.codeImage.backgroundColor = kBackgroundColor;
    self.codeImage.image = [CSTools creatQRcodeWithInfo:[NSString stringWithFormat:@"%ld",kUser.member_id] withSize:CGSizeMake(self.codeImage.size.width, self.codeImage.size.height)];
    self.signBtn.selected = MyModel.isSignToDay == 0 ? false : true;
      self.signBtn.backgroundColor = kBackgroundColor;
     [self.signBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
   
    //用户今日签到状态
    if (self.signBtn.isSelected == YES) {
        
    
        [self.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
    }else{
    
       
        [self.signBtn setTitle:@"去签到" forState:UIControlStateNormal];
    }
   
    //是否有新消息
    self.MessageFlag_img.hidden = true;
    if ([MyModel.messageFlag integerValue] == 1) {
        
        self.MessageFlag_img.hidden = false;
        
    }
}

-(void)View_Infomation{
    
    if([self.delegate respondsToSelector:@selector(ViewInformation_Action)]){
        [self.delegate ViewInformation_Action];
    }
    
}

-(void)View_Code{
    if ([self.delegate respondsToSelector:@selector(ViewCode_Action)]) {
        [self.delegate ViewCode_Action];
    }
    
}
- (IBAction)Sign_Action:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ViewSign_Action)]) {
        [self.delegate ViewSign_Action];
    }
}
- (IBAction)Message_Action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ViewMessage_Action)]) {
        [self.delegate ViewMessage_Action];
    }
}
-(void)Score_Action{
    
    if ([self.delegate respondsToSelector:@selector(ViewScore_Action)]) {
        [self.delegate ViewScore_Action];
    }
}
@end
