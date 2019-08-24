//
//  XZXAp_Store_TwoVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_TwoVC.h"
#import "XZXAp_Store_UploadMessageVC.h"
#import "XZXAp_Store_SelectStoreTypeVC.h"
#import "CSImagePickerManager.h"

#import "XZXAp_Store_InputTC.h"
#import "XZXAp_Store_SelectImageTC.h"

#import "XZXAp_Store_TextModel.h"
#import "XZXAp_Store_ImageModel.h"

@interface XZXAp_Store_TwoVC ()<UITableViewDelegate,UITableViewDataSource,XZXAp_Store_InputTCDelegate,XZXAp_Store_SelectImageTCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *CustomeTableView;
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;
- (IBAction)Next_Action:(id)sender;
@property (nonatomic,strong)NSMutableArray *dataSource_Text;//存储类型--输入文字
@property (nonatomic,strong)NSMutableArray *dataSource_Image;//存储类型--选择图片
@property (nonatomic,strong)XZXAp_Store_TwoModel *MyModel;//上传数据至服务器模型
@property (nonatomic, strong) CSImagePickerManager *imageManager;
@end

@implementation XZXAp_Store_TwoModel


@end

@implementation XZXAp_Store_TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"选择产品类型";
    self.CustomeTableView.dataSource = self;
    self.CustomeTableView.delegate  = self;
    [self.CustomeTableView registerNib:[UINib nibWithNibName:@"XZXAp_Store_InputTC" bundle:nil] forCellReuseIdentifier:@"XZXAp_Store_InputTCID"];
    [self.CustomeTableView registerNib:[UINib nibWithNibName:@"XZXAp_Store_SelectImageTC" bundle:nil] forCellReuseIdentifier:@"XZXAp_Store_SelectImageTCID"];
    self.CustomeTableView.backgroundColor = kBackgroundColor;
    self.CustomeTableView.tableFooterView = [UIView new];
     self.NextBtn.cornerRadius = 5.0;
    self.MyModel = [XZXAp_Store_TwoModel new];
   
//    self.MyModel.scId = @"";
//    self.MyModel.companyName = @"";
//    self.MyModel.companyBusinessLicense = @"4";
//    self.MyModel.companyRegistrationCertificate = @"5";
//    self.MyModel.companyInspectionReport = @"6";
//    self.MyModel.companyAccountPermit = @"7";
//    self.MyModel.companyProductionLicense = @"8";
//    self.MyModel.companyPriceTable = @"9";
//    self.MyModel.generationCompanyBusinessLicense = @"10";
//    self.MyModel.generationCompanyProductionLicense = @"11";
//    self.MyModel.mallAuthorization = @"12";
}

-(NSMutableArray *)dataSource_Text{
    if (!_dataSource_Text) {
        _dataSource_Text = [NSMutableArray array];
        
        NSMutableArray *tempArray  = [NSMutableArray arrayWithObjects:
                                      @{@"title":@"选择产品分类",@"message_id":@"",@"content":@"请选择",@"placehold":@""},
                                      @{@"title":@"*厂家/公司名称",@"message_id":@"",@"content":@"",@"placehold":@"请填写厂家/公司名称"},
                                      @{@"title":@"*产品名称",@"message_id":@"",@"content":@"",@"placehold":@"请填写产品名称"},
                                      @{@"title":@"*厂家联系人手机号码",@"message_id":@"",@"content":@"",@"placehold":@"请填厂家联系人手机号码"}
                                      ,nil];
        
        for (NSDictionary *dic in tempArray) {
            [_dataSource_Text addObject:[XZXAp_Store_TextModel yy_modelWithJSON:dic]];
        }
    }
    
    return _dataSource_Text;
}
-(NSMutableArray *)dataSource_Image{
    if (!_dataSource_Image) {
        _dataSource_Image = [NSMutableArray array];
        NSMutableArray *tempArray  = [NSMutableArray arrayWithObjects:
                                      @{@"title":@"*上传营业执照",@"message_id":@"1",@"manyPic":@"0",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传商标注册证",@"message_id":@"1",@"manyPic":@"0",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传检验报告",@"message_id":@"1",@"manyPic":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传开户许可证",@"message_id":@"1",@"manyPic":@"0",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传生产许可证",@"message_id":@"1",@"manyPic":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传云端商城授权书",@"message_id":@"1",@"manyPic":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传含税、含物流价格表",@"message_id":@"",@"manyPic":@"1",@"image":@"",@"imageStr":@"1"},
                                      @{@"title":@"上传代加工企业营业执照",@"message_id":@"",@"manyPic":@"0",@"image":@"",@"imageStr":@"0"},
                                      @{@"title":@"上传代加工企业生产许可证",@"message_id":@"",@"manyPic":@"0",@"image":@"",@"imageStr":@"0"}
                                      ,nil];
        for (NSDictionary *dic in tempArray) {
            [_dataSource_Image addObject:[XZXAp_Store_ImageModel yy_modelWithJSON:dic]];
        }
    }
    return _dataSource_Image;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 50;
    }else{
        
        return 100;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.dataSource_Text.count;
    }else{
        
        return self.dataSource_Image.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
            }
            XZXAp_Store_TextModel *model = [self.dataSource_Text objectAtIndex:indexPath.row];
            cell.textLabel.text = model.title;
            cell.detailTextLabel.text = model.content;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        XZXAp_Store_InputTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXAp_Store_InputTCID" forIndexPath:indexPath];
        cell.MyModel = [self.dataSource_Text objectAtIndex:indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.InputTCDelegate = self;
        return cell;
    }else{
        
        XZXAp_Store_SelectImageTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXAp_Store_SelectImageTCID" forIndexPath:indexPath];
        cell.MyModel = [self.dataSource_Image objectAtIndex:indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.SelectImageTCDelegate = self;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 &&
        indexPath.row == 0) {
        XZXAp_Store_SelectStoreTypeVC *VC = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_SelectStoreTypeVCID");
        VC.DidSeletType = ^(NSDictionary * _Nonnull dic) {
          
             XZXAp_Store_TextModel *model = [self.dataSource_Text objectAtIndex:indexPath.row];
            model.content = [dic valueForKey:@"name"];
            [self.CustomeTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            self.MyModel.scId = [dic valueForKey:@"id"];
        };
        [self.navigationController pushViewController:VC animated:YES];
    }
}

-(void)InputContent:(NSString *)content Cell:(XZXAp_Store_InputTC *)cell{
    
    NSIndexPath *indexPath = [self.CustomeTableView indexPathForCell:cell];
    
    if (indexPath.section == 0 &&
        indexPath.row == 1) {
        
        self.MyModel.companyName = content;
    }else if (indexPath.section == 0 &&
              indexPath.row == 2){
        
        self.MyModel.productName = content;
    }else if (indexPath.section == 0 &&
              indexPath.row == 3){
        
        self.MyModel.companyPhone = content;
    }
    
}

-(void)DidselectImage:(CGPoint)Point{
    
    NSInteger row = [self.CustomeTableView indexPathForRowAtPoint:Point].row;
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleDeterminate fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *data1 = [XHTools compressImage:photos[0] toByte:102400];
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"yyyyMMddhhmmssSSSS"];
            NSString *dateNow1 = [formatter1 stringFromDate:[NSDate date]];
            [formData appendPartWithFileData:data1 name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow1] mimeType:@"png/image"];
        } success:^(XHResponse *responseObject) {
            
            if(responseObject != nil){
                
                XZXAp_Store_ImageModel *model = [self.dataSource_Image objectAtIndex:row];
           
                model.image = photos[0];
                model.imageStr = [responseObject.data valueForKey:@"url"];
                
                [self.CustomeTableView reloadData];
            }
            
        }];
        
    }];
}

- (IBAction)Next_Action:(id)sender {


    
    

    if (self.MyModel.scId &&
        self.MyModel.companyName &&
        self.MyModel.productName &&
        self.MyModel.companyPhone) {
        
        
        BOOL IsCan = true;
        for (XZXAp_Store_ImageModel *model in self.dataSource_Image) {
            if ([model.imageStr length] ==0 && [model.message_id integerValue] ==1) {
                
                [MBProgressHUD xh_showHudWithMessage:@"请完善图片信息" toView:self.view completion:^{
                    
                }];
                IsCan = false;
                return;
            }
        }
        
        if (IsCan == YES) {
            
            NSDictionary *parameters = [NSDictionary dictionary];
            parameters = @{@"storeId":self.storeId,
                           @"scId":self.MyModel.scId,
                           @"companyName":self.MyModel.companyName,
                           @"productName":self.MyModel.productName,
                           @"companyPhone":self.MyModel.companyPhone,
                           @"companyBusinessLicense":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:0]).imageStr,
                           @"companyRegistrationCertificate":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:1]).imageStr,
                           @"companyInspectionReport":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:2]).imageStr,
                           @"companyAccountPermit":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:3]).imageStr,
                           @"companyProductionLicense":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:4]).imageStr,
                           @"companyPriceTable":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:5]).imageStr,
                           @"generationCompanyBusinessLicense":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:6]).imageStr,
                           @"generationCompanyProductionLicense":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:7]).imageStr,
                           @"mallAuthorization":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:8]).imageStr
                           };
            
            [XHNetworking xh_postWithSuccess:[NSString stringWithFormat:@"%@manufacturer/add",Store_ServiceIP] parameters:parameters success:^(XHResponse *responseObject) {
                
                
                if (responseObject.code == 200) {
                 
                    
                    XZXAp_Store_UploadMessageVC *VC = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_UploadMessageVCID");
                    VC.storeJoinin1Id = [NSString stringWithFormat:@"%@",responseObject.data];
                    VC.classId = self.MyModel.scId;
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }];
        }
        
    }else{
        
        
        [MBProgressHUD xh_showHudWithMessage:@"请完善信息" toView:self.view completion:^{
            
        }];
    }
}
@end
