//
//  XZXAp_Store_Success.h
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"
#import "mLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXAp_Store_Success : XHBaseViewController
@property (weak, nonatomic) IBOutlet mLabel *urlStr;
- (IBAction)DownLoad_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UILabel *productNum;
- (IBAction)DownLoad_Action:(id)sender;
- (IBAction)upload_Action:(id)sender;


@property (nonatomic,copy)NSString *productNumStr;
@end

NS_ASSUME_NONNULL_END
