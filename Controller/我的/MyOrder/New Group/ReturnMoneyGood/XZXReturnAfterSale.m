//
//  XZXReturnAfterSale.m
//  BigMarket
//
//  Created by RedSky on 2019/4/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXReturnAfterSale.h"
#import "XZXReturnMoneyTVC.h"
#import "XZXReturngoodsTVC.h"
@interface XZXReturnAfterSale ()
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodcontent;

@end

@implementation XZXReturnAfterSale

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择服务类型";
    self.goodName.text = self.goodmodel.goodsName;
    self.goodcontent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.goodmodel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",self.goodmodel.goodsScore]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"17.0",@"15.0"]];
    [self.goodImage sd_setImageWithURL:kImageUrl(self.goodmodel.storeId,self.goodmodel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 10;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 120;
    }else{
        
        if (indexPath.row == 0) {
            
            return 0;
        }else if (indexPath.row == 1){
            
            return 0;
        }else{
            
            return 70;
        }
    }
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            XZXReturnMoneyTVC *tvc = kStoryboradController(@"AfterSale", @"XZXReturnMoneyTVCID");
            tvc.hidesBottomBarWhenPushed = YES;
            tvc.goodmodel = self.goodmodel;
            tvc.DetailModel = self.DetailModel;
            tvc.tag =  ReturnMoney;
            
            [self.navigationController pushViewController:tvc animated:YES];
            
        }else if (indexPath.row == 1){
            XZXReturnMoneyTVC *tvc = kStoryboradController(@"AfterSale", @"XZXReturnMoneyTVCID");
            tvc.hidesBottomBarWhenPushed = YES;
             tvc.goodmodel = self.goodmodel;
            tvc.DetailModel = self.DetailModel;
              tvc.tag =  ReturnMoneyAndGood;
            [self.navigationController pushViewController:tvc animated:YES];
            
        }else if (indexPath.row == 2){
            XZXReturngoodsTVC *tvc = kStoryboradController(@"AfterSale", @"XZXReturngoodsTVCID");
            tvc.hidesBottomBarWhenPushed = YES;
             tvc.goodmodel = self.goodmodel;
            tvc.DetailModel = self.DetailModel;
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }
}


@end
