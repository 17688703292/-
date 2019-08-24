//
//  XZXMineInvitivyCode.m
//  BigMarket
//
//  Created by RedSky on 2019/6/3.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineInvitivyCode.h"
#import "CSTools.h"

@interface XZXMineInvitivyCode ()

@end

@implementation XZXMineInvitivyCode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的邀请码";
    [self addRightItemWithTitle:@"分享" titleColor:[UIColor whiteColor]];
    self.CodeImage.image = [CSTools creatQRcodeWithInfo:[NSString stringWithFormat:@"%ld",kUser.member_id] withSize:CGSizeMake(kScreenWidth/3.0*2.0, kScreenWidth/3.0*2.0)];
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    [self Inviter_Action];
}

-(void)Inviter_Action{
    
    
    __weak typeof(self) weakSelf = self;
    ZYShareItem *item0 = [ZYShareItem itemWithTitle:@"发送给好友"
                                               icon:@"Action_Share"
                                            handler:^{ [weakSelf itemAction:0]; }];
    
    ZYShareItem *item1 = [ZYShareItem itemWithTitle:@"分享到朋友圈"
                                               icon:@"Action_Moments"
                                            handler:^{ [weakSelf itemAction:1]; }];
    
    ZYShareItem *item2 = [ZYShareItem itemWithTitle:@"收藏"
                                               icon:@"Action_MyFavAdd"
                                            handler:^{ [weakSelf itemAction:2]; }];
    
    // 创建shareView
    ZYShareView *shareView = [ZYShareView shareViewWithShareItems:@[item0, item1, item2]
                                                    functionItems:@[]];
    // 弹出shareView
    [shareView show];
    
    
    
}
- (void)itemAction:(NSInteger )title
{
    
    UIGraphicsBeginImageContext(self.BackImage.frame.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [self.BackImage.image drawInRect:CGRectMake(0, 0, self.BackImage.frame.size.width, self.BackImage.frame.size.height)];
    self.BackImage.contentMode = UIViewContentModeScaleToFill;
    //再把小图片画上去
    CGFloat sImageW = self.BackImage.frame.size.width*0.30;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = self.BackImage.frame.size.width * 0.5;
    CGFloat sImgaeY = self.BackImage.frame.size.height * 0.5;
    
    
    [self.CodeImage.image drawInRect:CGRectMake(sImageX-sImageW/2.0, sImgaeY-sImageW/2.0, sImageW, sImageH)];
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    //UIImageView *backimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //backimageview.image = finalyImage;
    //backimageview.contentMode = UIViewContentModeScaleToFill;
    //[self.view addSubview:backimageview];
    
    //关闭图形上下文
    UIGraphicsEndImageContext();

    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(finalyImage , 1);
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    switch (title) {
        case 0:
        {
            req.scene = WXSceneSession;
        }
            break;
        case 1:
        {
            req.scene = WXSceneTimeline;
        }
            break;
        case 2:
        {
            req.scene = WXSceneFavorite;
        }
            break;
        default:
            break;
    }
    
    [WXApi sendReq:req];
    
}

@end
