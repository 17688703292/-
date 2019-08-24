//
//  OtherViewController.h
//  BigMarket
//
//  Created by RedSky on 2019/6/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OtherViewController : XHBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *BackImage;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic,copy) NSString *ImageStr;
@property (nonatomic,copy) NSString *contentStr;
@end

NS_ASSUME_NONNULL_END
