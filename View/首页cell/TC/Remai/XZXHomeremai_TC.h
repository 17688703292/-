//
//  XZXHomeremai_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/8/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol XZXHomeremai_TCDelegate <NSObject>

-(void)DidSelect_XZXHomeremai_TC:(NSString *)goodsId;

@end

@interface XZXHomeremai_TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,weak) id<XZXHomeremai_TCDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
