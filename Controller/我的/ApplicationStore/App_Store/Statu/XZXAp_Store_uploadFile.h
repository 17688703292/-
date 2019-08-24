//
//  XZXAp_Store_uploadFile.h
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXAp_Store_uploadFile : XHBaseTableViewController
@property (weak, nonatomic) IBOutlet UIImageView *uploadFile;
@property (weak, nonatomic) IBOutlet UIImageView *uploadFile2;
@property (weak, nonatomic) IBOutlet UIImageView *uploadFile3;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
- (IBAction)upload_Action:(id)sender;



@end

NS_ASSUME_NONNULL_END
