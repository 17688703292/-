//
//  XZXMineFeedBackVC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMineFeedBackVC : XHBaseViewController
@property (weak, nonatomic) IBOutlet UITextView *textField;
- (IBAction)upload_Action:(id)sender;

@end

NS_ASSUME_NONNULL_END
