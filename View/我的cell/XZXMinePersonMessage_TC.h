//
//  XZXMinePersonMessage_TC.h
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXMinePersonMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XZXMinePersonMessageDelegate <NSObject>

-(void)ViewInformation_Action;
-(void)ViewCode_Action;
-(void)ViewSign_Action;
-(void)ViewScore_Action;
-(void)ViewMessage_Action;

@end

@interface XZXMinePersonMessage_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (weak, nonatomic) IBOutlet UIButton *MessageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *MessageFlag_img;
- (IBAction)Sign_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;
- (IBAction)Message_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *codeImage;

@property (nonatomic,weak)id<XZXMinePersonMessageDelegate>delegate;
@property (nonatomic,strong)XZXMinePersonMessageModel *MyModel;
@end

NS_ASSUME_NONNULL_END
