//
//  XZXHomeJF3_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XZXHomeJF3_Delegate <NSObject>

-(void)DidSelectLeftBtn:(BOOL )IsSelectLeft;

@end

@interface XZXHomeJF3_TC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
- (IBAction)left_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *leftBottomView;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)right_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *rightBottomView;

@property (nonatomic,weak)id<XZXHomeJF3_Delegate>delegate;

@end

NS_ASSUME_NONNULL_END
