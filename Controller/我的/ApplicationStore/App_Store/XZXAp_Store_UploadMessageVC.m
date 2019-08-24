//
//  XZXAp_Store_UploadMessageVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_UploadMessageVC.h"
#import "CSImagePickerManager.h"
#import "XZXAp_Store_waitting.h"


#import "XZXAp_Store_InputTC.h"
#import "XZXAp_Store_SelectImageTC.h"

#import "XZXAp_Store_TextModel.h"
#import "XZXAp_Store_ImageModel.h"


@interface XZXAp_Store_UploadMessageVC ()<UITableViewDataSource,UITableViewDelegate,XZXAp_Store_SelectImageTCDelegate>

@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;
- (IBAction)Next_Action:(id)sender;


@property (nonatomic,strong)NSMutableArray *dataSource_Image;//存储类型--选择图
@property (nonatomic,strong)XZXAp_Store_UploadMessageModel *MyModel;//上传数据至服务器模型
@property (nonatomic, strong) CSImagePickerManager *imageManager;
@end

@implementation XZXAp_Store_UploadMessageModel


@end

@implementation XZXAp_Store_UploadMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"必须提供厂家的资质";
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate  = self;
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXAp_Store_InputTC" bundle:nil] forCellReuseIdentifier:@"XZXAp_Store_InputTCID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXAp_Store_SelectImageTC" bundle:nil] forCellReuseIdentifier:@"XZXAp_Store_SelectImageTCID"];
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    self.CustomerTableView.tableFooterView = [UIView new];
     self.NextBtn.cornerRadius = 5.0;
    
    [self GetInformation];
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithSuccess:[NSString stringWithFormat:@"%@weiitClass/select",Store_ServiceIP] parameters:@{@"classId":self.classId} success:^(XHResponse *responseObject) {
        
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dci in responseObject.data) {
                [self.dataSource_Image addObject:[XZXAp_Store_UploadMessageModel yy_modelWithJSON:dci]];
            }
            [self.CustomerTableView reloadData];
        }
    }];
}

-(NSMutableArray *)dataSource_Image{
    if (!_dataSource_Image) {
        _dataSource_Image = [NSMutableArray array];
 
    }
    return _dataSource_Image;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    return 120;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
    return self.dataSource_Image.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        XZXAp_Store_SelectImageTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXAp_Store_SelectImageTCID" forIndexPath:indexPath];
    XZXAp_Store_UploadMessageModel *model = [self.dataSource_Image objectAtIndex:indexPath.row];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:model.remark];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:kThemeColor range:[model.remark rangeOfString:@"*"]];
    cell.title.attributedText = attrStr;
    if ([model.image isKindOfClass:[UIImage class]]) {
        cell.SelectImage.image = model.image;
    }else{
        cell.SelectImage.image = [UIImage imageNamed:@"tianjiatupian"];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.SelectImageTCDelegate = self;
    return cell;
}


-(void)DidselectImage:(CGPoint)Point{
    
    NSInteger row = [self.CustomerTableView indexPathForRowAtPoint:Point].row;
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleDeterminate fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *data1 = [XHTools compressImage:photos[0] toByte:102400];
            NSLog(@"图片大小--%ld",[data1 length]);
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"yyyyMMddhhmmssSSSS"];
            NSString *dateNow1 = [formatter1 stringFromDate:[NSDate date]];
            [formData appendPartWithFileData:data1 name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow1] mimeType:@"png/image"];
        } success:^(XHResponse *responseObject) {
            
            if(responseObject != nil){
                
                XZXAp_Store_UploadMessageModel *model = [self.dataSource_Image objectAtIndex:row];
                model.image = photos[0];
                model.url = [responseObject.data valueForKey:@"url"];
                
                [self.CustomerTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        }];
        
    }];
}
- (IBAction)Next_Action:(id)sender {

    
    BOOL IsCan = true;
    for (XZXAp_Store_UploadMessageModel *model in self.dataSource_Image) {
        if ([model.url length] ==0) {
            
            [MBProgressHUD xh_showHudWithMessage:@"请完善图片信息" toView:self.view completion:^{
                
            }];
            IsCan = false;
            return;
        }
    }
    
    if (IsCan == YES) {
     
        NSMutableArray *array = [NSMutableArray array];
        for (XZXAp_Store_UploadMessageModel *model in self.dataSource_Image) {
            [array addObject:model.url];
            
        }
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:nil];
        NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        [parameters setObject:json forKey:@"str"];
        [parameters setObject:self.classId forKey:@"scId"];
        [parameters setObject:self.storeJoinin1Id forKey:@"manufacturerId"];
        
        [XHNetworking xh_postWithSuccess:[NSString stringWithFormat:@"%@manufacturerQualification/add1",Store_ServiceIP] parameters:parameters success:^(XHResponse *responseObject) {
            
            
            if (responseObject.code == 200) {
                XZXAp_Store_waitting *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_waittingID");
                one.hidesBottomBarWhenPushed = YES;
                one.contentStr = @"厂家资质审核";
                [self.navigationController pushViewController:one animated:YES];
            }
        }];

    }
    
}

@end
