//
//  XZXSearchHeadView.h
//  BigMarket
//
//  Created by RedSky on 2019/6/12.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXSearchHeadView : UICollectionReusableView
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UIButton *operationBtn;
@property (nonatomic,copy)void(^OperationBlcok)(void);
@end

NS_ASSUME_NONNULL_END
