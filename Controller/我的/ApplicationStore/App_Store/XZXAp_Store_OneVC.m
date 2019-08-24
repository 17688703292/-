//
//  XZXAp_Store_OneVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_OneVC.h"
#import "XZXAp_Store_TwoVC.h"
#import "CSImagePickerManager.h"
#import "XZXAp_Store_waitting.h"

#import "XZXAp_Store_InputTC.h"
#import "XZXAp_Store_SelectImageTC.h"

#import "XZXAp_Store_TextModel.h"
#import "XZXAp_Store_ImageModel.h"

@interface XZXAp_Store_OneVC ()<UITableViewDelegate,UITableViewDataSource,XZXAp_Store_InputTCDelegate,XZXAp_Store_SelectImageTCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;
- (IBAction)Next_Action:(id)sender;
@property (nonatomic,strong)NSMutableArray *dataSource_Text;//存储类型--输入文字
@property (nonatomic,strong)NSMutableArray *dataSource_Image;//存储类型--选择图片
@property (nonatomic,strong)  XZXAp_Store_OneModel *MyModel;//上传数据至服务器模型
@property (nonatomic, strong) CSImagePickerManager *imageManager;

@end

@implementation XZXAp_Store_OneModel


@end

@implementation XZXAp_Store_OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请";
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate  = self;
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXAp_Store_InputTC" bundle:nil] forCellReuseIdentifier:@"XZXAp_Store_InputTCID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXAp_Store_SelectImageTC" bundle:nil] forCellReuseIdentifier:@"XZXAp_Store_SelectImageTCID"];
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    self.CustomerTableView.tableFooterView = [UIView new];
    self.NextBtn.cornerRadius = 5.0;
    


}

-(XZXAp_Store_OneModel *)MyModel{
   
    if (!_MyModel) {
        _MyModel = [XZXAp_Store_OneModel new];
    }
    return _MyModel;
}

-(NSMutableArray *)dataSource_Text{
    if (!_dataSource_Text) {
        _dataSource_Text = [NSMutableArray array];
        
        NSMutableArray *tempArray  = [NSMutableArray arrayWithObjects:
                                      @{@"title":@"*商店名称",@"message_id":@"",@"content":@"",@"placehold":@"请输入姓名"},
                                      @{@"title":@"*手机号",@"message_id":@"",@"content":@"",@"placehold":@"请输入手机号"},
                                      @{@"title":@"*微信号",@"message_id":@"",@"content":@"",@"placehold":@"请输入微信号"},
                                      @{@"title":@"*地址",@"message_id":@"",@"content":@"",@"placehold":@"请输入地址"}
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
                                      @{@"title":@"*上传营业执照",@"message_id":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传手持开户许可证",@"message_id":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传身份证正面",@"message_id":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传身份证反面",@"message_id":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"*上传身份证手持",@"message_id":@"1",@"image":@"",@"imageStr":@""},
                                      @{@"title":@"上传经营许可证",@"message_id":@"0",@"image":@"",@"imageStr":@""}
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
        
        return 120;
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

-(void)InputContent:(NSString *)content Cell:(XZXAp_Store_InputTC *)cell{
    
    NSIndexPath *indexPath = [self.CustomerTableView indexPathForCell:cell];
    
    if (indexPath.section == 0 &&
        indexPath.row == 0) {
        
        self.MyModel.storeJoininName = content;
    }else if (indexPath.section == 0 &&
              indexPath.row == 1){
        
        self.MyModel.storeJoininMobile = content;
    }else if (indexPath.section == 0 &&
              indexPath.row == 2){
        
        self.MyModel.storeJoininWx = content;
    }else if (indexPath.section == 0 &&
              indexPath.row == 3){
        
        self.MyModel.storeJoininAddress = content;
    }
    
}

-(void)DidselectImage:(CGPoint)Point{
    
    NSInteger row = [self.CustomerTableView indexPathForRowAtPoint:Point].row;
    
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
                
                [self.CustomerTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        }];
        
    }];
}


- (IBAction)Next_Action:(id)sender {
 
    
    if (self.MyModel.storeJoininName &&
        self.MyModel.storeJoininMobile &&
        self.MyModel.storeJoininWx &&
        self.MyModel.storeJoininAddress) {
        
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
            parameters = @{@"storeName":self.MyModel.storeJoininName,
                           @"memberId":@(kUser.member_id),
                           @"storePhone":self.MyModel.storeJoininMobile,
                           @"storeQq":self.MyModel.storeJoininWx,
                           @"storeAddress":self.MyModel.storeJoininAddress,
                         
                           
                           @"storePictureBusinessLicense":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:0]).imageStr,
                           @"accountOpeningPermit":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:1]).imageStr,
                           @"idCard":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:2]).imageStr,
                           @"reverseIdCard":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:3]).imageStr,
                           @"handIdCard":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:4]).imageStr,
                           @"foodTradeLicense":((XZXAp_Store_ImageModel *)[self.dataSource_Image objectAtIndex:5]).imageStr
                           };
            
            
            [XHNetworking xh_postWithSuccess:[NSString stringWithFormat:@"%@store/addStore",Store_ServiceIP] parameters:parameters success:^(XHResponse *responseObject) {
                
                if (responseObject.code == 200) {
                
                    XZXAp_Store_waitting *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_waittingID");
                    one.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:one animated:YES];
                }
            }];
        }
        
    }else{
        
        
        [MBProgressHUD xh_showHudWithMessage:@"请完善信息" toView:self.view completion:^{
            
        }];
    }
  
}
@end
