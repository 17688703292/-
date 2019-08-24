//
//  XZXHomeJF2_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXHomeJF2Delegate <NSObject>

-(void)HomeJF2_DidSelectLeft:(BOOL )IsSelect;

@end

@interface XZXHomeJF2_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *left_topImage;
@property (weak, nonatomic) IBOutlet UILabel *left_lab;

@property (weak, nonatomic) IBOutlet UIView *right_view;
@property (weak, nonatomic) IBOutlet UILabel *right_lab;
@property (weak, nonatomic) IBOutlet UIImageView *right_image;

@property (nonatomic,weak)id<XZXHomeJF2Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
