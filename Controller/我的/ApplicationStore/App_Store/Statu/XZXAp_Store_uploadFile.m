//
//  XZXAp_Store_uploadFile.m
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_uploadFile.h"
#import "XZXAp_Product_Success.h"
#import "XZXAp_Product_Fair.h"
#import "CSImagePickerManager.h"
#import "XZXMineTVC.h"
#import "XZXAp_StoreShow.h"

@interface XZXAp_Store_uploadFile ()

@property (nonatomic, strong) CSImagePickerManager *imageManager;
@property (nonatomic, copy) NSString *contract;
@property (nonatomic, copy) NSString *contract2;
@property (nonatomic, copy) NSString *contract3;
@end

@implementation XZXAp_Store_uploadFile

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"上传合同";
    self.uploadBtn.cornerRadius = 22.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectFile)];
    self.uploadFile.userInteractionEnabled = YES;
    [self.uploadFile addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectFile2)];
    self.uploadFile2.userInteractionEnabled = YES;
    [self.uploadFile2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectFile3)];
    self.uploadFile3.userInteractionEnabled = YES;
    [self.uploadFile3 addGestureRecognizer:tap3];
}

#pragma mark - Table view data source

-(void)selectFile{
    
   
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        for (UIImage *image in photos) {
            self.uploadFile.image = image;
           
        }
        
        [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleDeterminate fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *data1 = [XHTools compressImage:photos[0] toByte:102400];
       
            NSLog(@"图片大小--%ld",[data1 length]);
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"yyyyMMddhhmmssSSSS"];
            NSString *dateNow1 = [formatter1 stringFromDate:[NSDate date]];
            [formData appendPartWithFileData:data1 name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow1] mimeType:@"png/image"];
        } success:^(XHResponse *responseObject) {
            
            if(responseObject != nil){
                
                self.contract = [responseObject.data valueForKey:@"url"];
               
                self.uploadFile.image  = photos[0];
                
            }
            
        }];
    }];
}

-(void)selectFile2{
    
    
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        for (UIImage *image in photos) {
            self.uploadFile2.image = image;
            
        }
        
        [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleDeterminate fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *data1 = [XHTools compressImage:photos[0] toByte:102400];
            
            NSLog(@"图片大小--%ld",[data1 length]);
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"yyyyMMddhhmmssSSSS"];
            NSString *dateNow1 = [formatter1 stringFromDate:[NSDate date]];
            [formData appendPartWithFileData:data1 name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow1] mimeType:@"png/image"];
        } success:^(XHResponse *responseObject) {
            
            if(responseObject != nil){
                
                self.contract2 = [responseObject.data valueForKey:@"url"];
                
                self.uploadFile2.image  = photos[0];
                
            }
            
        }];
    }];
}


-(void)selectFile3{
    
    
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        for (UIImage *image in photos) {
            self.uploadFile3.image = image;
            
        }
        
        [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleDeterminate fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *data1 = [XHTools compressImage:photos[0] toByte:102400];
            
            NSLog(@"图片大小--%ld",[data1 length]);
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"yyyyMMddhhmmssSSSS"];
            NSString *dateNow1 = [formatter1 stringFromDate:[NSDate date]];
            [formData appendPartWithFileData:data1 name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow1] mimeType:@"png/image"];
        } success:^(XHResponse *responseObject) {
            
            if(responseObject != nil){
                
                self.contract3 = [responseObject.data valueForKey:@"url"];
                
                self.uploadFile3.image  = photos[0];
                
            }
            
        }];
    }];
}


- (IBAction)upload_Action:(id)sender {

    
    if ([self.contract length] != 0) {
     
        [XHNetworking xh_postWithoutSuccess:[NSString stringWithFormat:@"%@content/add",Store_ServiceIP] parameters:@{@"contract":self.contract,@"contract1":self.contract2,@"contract2":self.contract3,@"memberId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
            
            if (responseObject.code == 200) {
                
                
                for (UIViewController *VC in self.navigationController.viewControllers) {
                    if ([VC isKindOfClass:[XZXMineTVC class]]) {
                        
                        [self.navigationController popToViewController:VC animated:YES];
                    }
                }
                
#if 0
                XZXAp_StoreShow *show =kStoryboradController(@"ApplicationStore", @"XZXAp_StoreShowID");
                show.VC_type = Finally;
                show.storeNameStr =@"";
                //show.storeNameStr = [responseObject.data valueForKey:@"storeName"];
                show.hidesBottomBarWhenPushed = YES;
               [self.navigationController pushViewController:show animated:YES];
#endif
                
            }
        }];
    }else{
        
        [MBProgressHUD xh_showHudWithMessage:@"请选择图片" toView:self.view completion:^{
            
        }];
    }
}

-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[XZXMineTVC class]]) {
            
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}

- (IBAction)DownLoad_Action:(id)sender {
    
    
}
@end
