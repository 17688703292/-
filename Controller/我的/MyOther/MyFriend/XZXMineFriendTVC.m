//
//  XZXMineFriendTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineFriendTVC.h"
#import "XZXMineFriendTC.h"
#import "CSTools.h"

@implementation XZXMineFriendModel


@end


@interface XZXMineFriendTVC ()

@property (nonatomic,strong) UIImageView *ShareCodeImage;
@property (nonatomic,strong) UIView *BottomView;
@property (nonatomic,assign) NSInteger activeCount;//活跃人数

@end

@implementation XZXMineFriendTVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMineFriendTC" bundle:nil] forCellReuseIdentifier:@"XZXMineFriendTCID"];
    
    [self GetInformation];
  
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.BottomView removeFromSuperview];
}
-(UIView *)BottomView{
    
    if (!_BottomView) {
        _BottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-90, kScreenWidth, 90)];
        //[[UIApplication sharedApplication].keyWindow addSubview:_BottomView];
        
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        [_BottomView addSubview:topLine];
        topLine.backgroundColor = kBackgroundColor;
        
        UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 89)];
        [_BottomView addSubview:content];
        content.textAlignment = NSTextAlignmentCenter;
        content.attributedText = [NSString changestringArray:@[@"总人数：",[NSString stringWithFormat:@"%ld",self.total]] colorArray:@[[UIColor darkGrayColor],kThemeColor] fontArray:@[@"17.0",@"17.0"]];
    }
    _BottomView.backgroundColor = [UIColor redColor];
    return _BottomView;
}

-(void)GetInformation{
    
    
    [XHNetworking xh_postWithoutSuccess:@"yunshop/myInvitedMember" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"inviterId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
    
        if (responseObject.code == 200 && [responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            self.total = [[responseObject.data valueForKey:@"count"] integerValue];
            self.activeCount = [[responseObject.data valueForKey:@"activeCount"] integerValue];
            for (NSDictionary *dic in [responseObject.data valueForKey:@"list"]) {
                [self.dataArray addObject:[XZXMineFriendModel yy_modelWithJSON:dic]];
            }
            self.total = [self.dataArray count];
            self.BottomView.backgroundColor = [UIColor whiteColor];
            
            [self.tableView reloadData];
        }
    }];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
     
        return kScreenWidth *0.54;
    }
    return kScreenHeight/10.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4.0-10, 30)];
    [view addSubview:title];
    title.text = @"我的人缘";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - kScreenWidth/4.0-10, 5, kScreenWidth/4.0, 30)];
    [btn setTitle:@"邀请好友" forState:UIControlStateNormal];
    [btn setBackgroundColor:kThemeColor];
    btn.cornerRadius = 15.0;
    [btn addTarget:self action:@selector(Inviter_Action) forControlEvents:UIControlEventTouchDown];
    [view addSubview:btn];
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
 
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        XZXMineFriendTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMineFriendTCID" forIndexPath:indexPath];
       cell.total.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",self.total],@"\n总人数"] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"20.0",@"15.0"]];
        cell.user.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",self.activeCount],@"\n活跃用户"] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"20.0",@"15.0"]];
        return cell;
    }else{
        
     
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        }
        XZXMineFriendModel *Model = [self.dataArray objectAtIndex:indexPath.row];
        [cell.imageView sd_setImageWithURL:kImageUrl(@"", @"") placeholderImage:[UIImage imageNamed:@"guanyuwomen"]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.imageView.clipsToBounds = YES;
        cell.textLabel.attributedText = [NSString changestringArray:@[[Model.memberName length] > 0 ?Model.memberName :@"Customer",[NSString stringWithFormat:@"\n\n%@",Model.memberMobile]] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"16.0",@"14.0"]];
        cell.detailTextLabel.text = Model.invitedTime;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
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
    
    UIImageView *BackImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    BackImage.image = [UIImage imageNamed:@"fenxiangerweima"];
    UIImageView *CodeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*0.5-kScreenWidth*0.6, kScreenHeight*0.5-kScreenWidth*0.6, kScreenWidth*0.3, kScreenWidth*0.3)];
    CodeImage.image = [CSTools creatQRcodeWithInfo:[NSString stringWithFormat:@"%ld",kUser.member_id] withSize:CGSizeMake(kScreenWidth/3.0*2.0, kScreenWidth/3.0*2.0)];
    
    UIGraphicsBeginImageContext(BackImage.frame.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [BackImage.image drawInRect:CGRectMake(0, 0, BackImage.frame.size.width, BackImage.frame.size.height)];
    BackImage.contentMode = UIViewContentModeScaleToFill;
    //再把小图片画上去
    CGFloat sImageW = BackImage.frame.size.width*0.30;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = BackImage.frame.size.width * 0.5;
    CGFloat sImgaeY = BackImage.frame.size.height * 0.5;
    
    
    [CodeImage.image drawInRect:CGRectMake(sImageX-sImageW/2.0, sImgaeY-sImageW/2.0, sImageW, sImageH)];
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    
        WXImageObject *imageObject = [WXImageObject object];
        imageObject.imageData = UIImageJPEGRepresentation(finalyImage, 0.7);
    
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
