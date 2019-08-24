//
//  XZXSearchResultVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

typedef NS_ENUM(NSInteger,tag) {
    
    SearchGood_Store,//从商店中查询商品
    SearchGood_GoodList//从所有商品中查询商品
};

NS_ASSUME_NONNULL_BEGIN

@interface XZXSearchResultVC : XHBaseViewController

@property (nonatomic,assign)NSInteger VC_type;
@property (nonatomic,copy) NSString *sortId;

@end

NS_ASSUME_NONNULL_END
