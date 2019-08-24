//
//  XZXBindPhoneVC.h
//  BigMarket
//
//  Created by RedSky on 2019/6/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"
#import "XZXTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXBindPhoneVC : XHBaseViewController

@property (weak, nonatomic) IBOutlet XZXTextField *telephone;
- (IBAction)Sure_Action:(id)sender;
@property (weak, nonatomic) IBOutlet XZXTextField *code;
@end

NS_ASSUME_NONNULL_END
