//
//  XZXHome_ActivityHeadTC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_ActivityHeadTC.h"

@implementation XZXHome_ActivityHeadTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ViewMoreBtn.cornerRadius = 12.5;
    self.ViewMoreBtn.layer.borderWidth = 2.0;
    self.ViewMoreBtn.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2].CGColor;
    
    self.backImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)ReloadUI:(XZXHomeModel *)MyModel section:(NSInteger )section{
   
    XZXHome_goodListModel *model = [XZXHome_goodListModel new];

   // self.content.text = @"最大的聚惠 品牌轰炸";
    if (section == 5){
        //众筹
        
        self.ViewMoreBtn.backgroundColor = [UIColor hexStringToColor:@"67c7c3"];
        [self.backImage sd_setImageWithURL:kImageUrl(@"",MyModel.zhongchou.image) placeholderImage:[UIImage imageNamed:LoadPic]];
    }else if (section == 6){
        //热卖
        self.ViewMoreBtn.backgroundColor = [UIColor hexStringToColor:@"67c7c3"];
        [self.backImage sd_setImageWithURL:kImageUrl(@"",MyModel.remai.image) placeholderImage:[UIImage imageNamed:LoadPic]];
    }else if (section == 3){
        //秒杀
        model = MyModel.spike;
//        self.Title.text = model.activityName;
//        self.content.text = model.activityIntroduce;
        self.ViewMoreBtn.backgroundColor = [UIColor hexStringToColor:@"67c7c3"];
        [self.backImage sd_setImageWithURL:kImageUrl(@"",MyModel.spike.image) placeholderImage:[UIImage imageNamed:LoadPic]];
    }else if (section == 4){
        //团购
        model = MyModel.groupBuy;
//        self.Title.text = model.activityName;
//        self.content.text = model.activityIntroduce;
        self.ViewMoreBtn.backgroundColor = [UIColor hexStringToColor:@"f96e93"];
         [self.backImage sd_setImageWithURL:kImageUrl(@"",MyModel.groupBuy.image) placeholderImage:[UIImage imageNamed:LoadPic]];
    }else if (section == 2){
        //自营
        model = MyModel.selfSupport;
//        self.Title.text = model.activityName;
//        self.content.text = model.activityIntroduce;
        self.ViewMoreBtn.backgroundColor = [UIColor hexStringToColor:@"f96e93"];
        [self.backImage sd_setImageWithURL:kImageUrl(@"",MyModel.selfSupport.image) placeholderImage:[UIImage imageNamed:LoadPic]];
    }else if (section == 7){
        //积分
//        self.Title.text = @"积分专区";
//        self.content.text = @"好礼换不停";
        // [self.backImage sd_setImageWithURL:kImageUrl(model.image) placeholderImage:[UIImage imageNamed:LoadPic]];
    }else if (section == 8){
        //拍卖
//        self.Title.text = @"拍卖专区";
//        self.content.text = @"最大的聚惠 品牌轰炸";
       // [self.backImage sd_setImageWithURL:kImageUrl(model.image) placeholderImage:[UIImage imageNamed:LoadPic]];
    }

}

- (IBAction)View_Action:(id)sender {

    XZXHome_ActivityHeadTC *cell = (XZXHome_ActivityHeadTC *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(DidSelectViewMoreActivity:)]) {
        [self.delegate DidSelectViewMoreActivity:cell];
    }

}
@end
