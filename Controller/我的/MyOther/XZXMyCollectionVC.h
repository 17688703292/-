//
//  XZXMyCollectionVC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/27.
//  Copyright © 2019 RedSky. All rights reserved.
//  

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface XZXMyCollectionModel : NSObject

@property (nonatomic,copy) NSString *favId;//？？
@property (nonatomic,copy) NSString *addTime;//添加时间
@property (nonatomic,copy) NSString *favType;//store商店 goods商品
@property (nonatomic,copy) NSString *goodsImage;//商品
@property (nonatomic,copy) NSString *goodsId;//商品
@property (nonatomic,copy) NSString *goodsName;//商品
@property (nonatomic,copy) NSString *goodsPrice;//商品
@property (nonatomic,copy) NSString *score;//商品

@property (nonatomic,copy) NSString *storeId;//商店
@property (nonatomic,copy) NSString *storeName;//商店
@property (nonatomic,copy) NSString *storeImage;//商店
@property (nonatomic,copy) NSString *goodsPromotionType;//商品类型普通、自营、活动
@property (nonatomic,copy) NSString *goodsPromotionPrice;
@property (nonatomic,assign) NSInteger isOwnShop;//1为商城自营店铺
@end


@interface XZXMyCollectionVC : XHBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *BabyBtn;
- (IBAction)Baby_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *StoreBtn;
- (IBAction)Store_Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;

@end

NS_ASSUME_NONNULL_END
