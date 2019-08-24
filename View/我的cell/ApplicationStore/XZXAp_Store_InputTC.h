//
//  XZXAp_Store_InputTC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXTextField.h"
#import "XZXAp_Store_TextModel.h"

@class XZXAp_Store_InputTC;

@protocol XZXAp_Store_InputTCDelegate <NSObject>

-(void)InputContent:(NSString *)content Cell:(XZXAp_Store_InputTC *)cell;

@end

@interface XZXAp_Store_InputTC : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet XZXTextField *InputText;
@property (nonatomic,strong) XZXAp_Store_TextModel *MyModel;
@property (nonatomic,weak) id<XZXAp_Store_InputTCDelegate>InputTCDelegate;

@end


