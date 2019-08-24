//
//  XZXShopGoodSelectNum.h
//  Slumbers
//
//  Created by RedSky on 2018/12/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZXShopGoodSelectNum : UITableViewCell


@property (nonatomic,assign) NSInteger GoodCapaticMax;
@property (nonatomic,assign) NSInteger selectGoodNum;


@property (weak, nonatomic) IBOutlet UIButton *ReduceBtn;
- (IBAction)Reduce_Action:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *AddBtn;
- (IBAction)Add_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *GoodNum;

@property (nonatomic,copy) void(^ChangeGoodNum)(NSInteger selectGoodNum);
@property (nonatomic,assign) NSInteger goodsPromotionType;

@end
