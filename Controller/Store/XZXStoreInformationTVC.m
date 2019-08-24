//
//  XZXStoreInformationTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXStoreInformationTVC.h"
#import "GoodDetail_goodImage.h"

@interface XZXStoreInformationTVC ()

@property (nonatomic,strong)XZXStoreInformationDetailModel *MyModel;
@end

@implementation XZXStoreInformationDetailModel


@end

@implementation XZXStoreInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"店铺详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodDetail_goodImage" bundle:nil] forCellReuseIdentifier:@"GoodDetail_goodImageID"];

    [self GetInformation];
}


-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"store/getStoreDetails" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"storeId":self.storeId} success:^(XHResponse *responseObject) {
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            self.MyModel = [XZXStoreInformationDetailModel yy_modelWithJSON:responseObject.data];
            [self.tableView reloadData];
        }
    }];
}
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }else{
        
        return kScreenWidth*0.7;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
       
        NSString *storeName =   [NSString stringWithFormat:@"\n店铺名称：%@\n\n",self.MyModel.storeName];
        NSString *storeadress = [NSString stringWithFormat:@"店铺地址：%@\n\n",self.MyModel.storeAddress];
        NSString *contacter =   [NSString stringWithFormat:@"联 系 人 ：%@\n\n",self.MyModel.sellerName];
        NSString *phone =       [NSString stringWithFormat:@"联系电话：%@\n\n",self.MyModel.storePhone];
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@%@%@",storeName,storeadress,contacter,phone];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        return cell;
        
    }else{
        
        
        GoodDetail_goodImage *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_goodImageID" forIndexPath:indexPath];
        [cell.good_image sd_setImageWithURL:kImageUrl(@"",self.MyModel.storePictureBusinessLicense) placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }

}



@end
