//
//  XZXMineSignTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineSignTVC.h"
#import "XZXMineSignCell1.h"
#import "XZXMineSignCell2.h"

@interface XZXMineSignTVC ()<XZXMineSignCell2Delegate,XZXMineSignCell1Delegate>

@property (nonatomic,strong)XZXMineSignModel *MyModel;

@end

@implementation XZXMineSign_GoodListModel


@end


@implementation XZXMineSignModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"day": [XZXMineSign_dayModel class],
             @"scoreGetDetail":[XZXMineSign_GoodListModel class]
             };
}

@end

@implementation XZXMineSignTVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"签到";
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMineSignCell1" bundle:nil] forCellReuseIdentifier:@"XZXMineSignCell1ID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMineSignCell2" bundle:nil] forCellReuseIdentifier:@"XZXMineSignCell2ID"];
    [self GetInformation];
}

-(void)GetInformation{
    
    
    [XHNetworking xh_postWithoutSuccess:@"signIn/getSignPage" parameters:@{@"slMemberid":@(kUser.member_id),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
       
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            self.MyModel = [XZXMineSignModel yy_modelWithJSON:responseObject.data];
    
            for (XZXMineSign_dayModel *dayModel in self.MyModel.day) {
                NSArray *array = [dayModel.dayTime componentsSeparatedByString:@"-"];
                if (array.count >= 3) {
                    dayModel.dayTime = [NSString stringWithFormat:@"%@.%@",array[1],array[2]];
                }
            }
            
            [self.tableView reloadData];
        }
        
    }];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       
        return kScreenWidth*0.4;
    }else if (indexPath.section == 1){
       
        return 75;
    }else if (indexPath.section == 2){
        
        return 50;
    }else{
        
        return 80;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 3) {
        
        return self.MyModel.scoreGetDetail.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {

        XZXMineSignCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMineSignCell1ID" forIndexPath:indexPath];
        if (self.IsSign == 0) {
            
               cell.Sign_content.attributedText = [NSString changestringArray:@[@"点击签到"] colorArray:@[[UIColor whiteColor]] fontArray:@[@"15.0"]];
        }else{
     
               cell.Sign_content.attributedText = [NSString changestringArray:@[@"可用积分\n",[self.MyModel.score isKindOfClass:[NSString class]] ? self.MyModel.score : @"0"] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"11.0",@"15.0"]];
        }
     
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){

        XZXMineSignCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMineSignCell2ID" forIndexPath:indexPath];
        cell.content.attributedText = [NSString changestringArray:@[@"已连续签到\n",[NSString stringWithFormat:@"%@",self.MyModel.signLastDay],@"天"] colorArray:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"11.0",@"13",@"11.0"]];
        cell.delegate = self;
        cell.GoodModel_dataSource = self.MyModel.day;
        [cell.CustomerCollectionView reloadData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.textLabel.text = @"积分详情";
        return cell;
    }else{

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
        }
        XZXMineSign_GoodListModel *goodModel = [self.MyModel.scoreGetDetail objectAtIndex:indexPath.row];
        //[cell.imageView sd_setImageWithURL:kImageUrl(@"", @"") placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.textLabel.numberOfLines = 0;
        switch ([goodModel.scoreType integerValue]) {
            case 1:
                {
                    cell.textLabel.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n\n",goodModel.scoreDesc],goodModel.createDateStr] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"16",@"14.0"]];
                }
                break;
            case 2:
            {
                cell.textLabel.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n\n",goodModel.scoreDesc],[NSString stringWithFormat:@"¥ %@",[NSString reviseString:goodModel.price]]] colorArray:@[[UIColor blackColor],kThemeColor] fontArray:@[@"16.0",@"17.0"]];
             
            }
                break;
            case 3:
            {
                cell.textLabel.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n\n",goodModel.scoreDesc],goodModel.createDateStr] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"16",@"14.0"]];
            }
                break;
            default:
            {
              cell.textLabel.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n\n",goodModel.scoreDesc],goodModel.createDateStr] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"16",@"14.0"]];
            }
                break;
        }
     
        cell.detailTextLabel.text = [NSString stringWithFormat:@"积分：%@",goodModel.score];
        cell.detailTextLabel.textColor = kThemeColor;
        return cell;
    }
}
//签到

-(void)DidSelectSign{
    
    [XHNetworking xh_postWithSuccess:@"signIn/sign" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"slMemberid":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            self.IsSign = 1;
            [self GetInformation];
        }
    }];
}

@end
