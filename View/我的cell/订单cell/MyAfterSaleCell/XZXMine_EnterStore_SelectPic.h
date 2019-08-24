//
//  XZXMine_EnterStore_SelectPic.h
//  Slumbers
//
//  Created by RedSky on 2019/2/18.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_EnterStore_SelectPic : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PicImage;
- (IBAction)DelectImage_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *DelectImageBtn;

@property (nonatomic,copy) void (^DelectPicBlock)(XZXMine_EnterStore_SelectPic *CellBlock);
@end

NS_ASSUME_NONNULL_END
