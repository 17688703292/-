//
//  XZXTextField.m
//  Slumbers
//
//  Created by zhu on 2018/11/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XZXTextField.h"

@interface XZXTextField ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation XZXTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.font = kFont_Medium;
    self.tintColor = kThemeColor;
    //    self.borderStyle = UITextBorderStyleNone;
    //    self.layer.cornerRadius = 35./2.0f;
    //    self.layer.masksToBounds = true;
    //    self.layer.borderColor = kGraywhite.CGColor;
    //    self.layer.borderWidth = 1;
    self.leftView = [self createLeftView:@""];

    self.leftViewMode = UITextFieldViewModeAlways;
    self.borderStyle = UITextBorderStyleNone;
}

- (UIView *)createLeftView:(NSString *)iconName {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 7.5, 50, 20)];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftView addSubview:self.imageView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(39, 0, 1, 20)];
    line.backgroundColor = [UIColor whiteColor];
    [leftView addSubview:line];
    return leftView;
}

- (void)setIconName:(NSString *)iconName {
    
    _iconName = iconName;
    self.imageView.image = kImageName(iconName);
}


- (void )creatLeftTitle:(NSString *)lefttitle {
    CGSize siez = [lefttitle xh_sizeWithFont:kFont_Large constrainedToHeight:40.0];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 7.5, 30+siez.width, 20)];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, siez.width, 20)];
    self.label.textAlignment = NSTextAlignmentRight;
    self.label.font = kFont_Large;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:lefttitle];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kThemeColor range:[lefttitle rangeOfString:@"*"]];
    self.label.attributedText = attrStr;
   // self.label.textColor = [UIColor darkGrayColor];
    [leftView addSubview:self.label];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(19+siez.width, 0, 1, 20)];
    line.backgroundColor = [UIColor whiteColor];
    [leftView addSubview:line];
    self.leftView  = leftView;
}

@end
