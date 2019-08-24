//
//  XZXAp_Store_ImageModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXAp_Store_ImageModel : NSObject

@property (nonatomic,copy) NSString *message_id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,copy) NSString *manyPic;//1、多张图片 0单张图片

@end

NS_ASSUME_NONNULL_END
