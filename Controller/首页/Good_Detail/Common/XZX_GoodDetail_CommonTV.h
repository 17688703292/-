//
//  XZX_GoodDetail_CommonTV.h
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_activityModel.h"

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSInteger,GoodDetail_type) {
    
    GoodDetail_CommonTV,//普通商品
    GoodDetail_ZY,//自营活动
    GoodDetail_RM,//热卖活动
    GoodDetail_MS,//秒杀活动
    GoodDetail_TG,//团购活动
    GoodDetail_ZC,//众筹活动
    GoodDetail_JF,//积分活动
    GoodDetail_Agent//代理大礼包
};


@interface XZX_GoodDetail_CommonTV : XHBaseViewController<UITableViewDelegate,UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UITableView *CustomerTV;


/**
 普通、自营商品
 */
@property (weak, nonatomic) IBOutlet UIView *CommandBackView;
@property (weak, nonatomic) IBOutlet UIButton *CSBtn;
- (IBAction)CS_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *CollectionBtn;
- (IBAction)Collection_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *BuyCarBtn;
- (IBAction)BuyCar_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *AddToBuyCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *BytBtn;
- (IBAction)AddToBuyCar_Action:(id)sender;
- (IBAction)Buy_Action:(id)sender;

@property (nonatomic,assign)NSInteger VC_type;//Controller类型
@property (nonatomic,strong)NSString *goodsId;
@property (nonatomic,assign)NSInteger JF_type;//4积分购物 3积分兑换

/**
  秒杀、团购
 */

@property (weak, nonatomic) IBOutlet UIView *SpecialBackView;
@property (weak, nonatomic) IBOutlet UIButton *special_CSBtn;
- (IBAction)special_CS_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *special_CollectionBtn;
- (IBAction)special_Collection_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *carBtn;
- (IBAction)Car_Action:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *special_ByBtn;
- (IBAction)special_Buy_Action:(id)sender;



@end

NS_ASSUME_NONNULL_END
