//
//  XZXPayResultHeadCC.h
//  BigMarket
//
//  Created by RedSky on 2019/6/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XZXPayResultHeadDelegate <NSObject>

-(void)ViewOrder_delegate;
-(void)Back_delegate;

@end

@interface XZXPayResultHeadCC : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderContent_lab;
@property (weak, nonatomic) IBOutlet UIButton *ViewOrder_Btn;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
- (IBAction)ViewOrder_Action:(id)sender;
- (IBAction)Back_Action:(id)sender;

@property (nonatomic,weak)id <XZXPayResultHeadDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
