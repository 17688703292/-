//
//  XHMenuCell.m
//  XHMenuDemo
//
//  Created by Carson on 2017/8/30.
//  Copyright © 2017年 Carson. All rights reserved.
//

#import "XHMenuCell.h"
@interface XHMenuCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuImageWidth;
@property (nonatomic, strong) UIView *selectedBgView;
@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation XHMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.selectedBgView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.selectedBackgroundView = self.selectedBgView;
}

- (void)setMenuModel:(XHMenuModel *)menuModel{
    _menuModel = menuModel;
    if (!menuModel.imageName.length) {
        self.menuImageWidth.constant = 0;
    }else{
        self.menuImageWidth.constant = 30;
    }
    if (menuModel.imageName.length) {
        self.menuImageView.image = [UIImage imageNamed:menuModel.imageName];
    }
    self.menuTitleLab.text = menuModel.title;
}

- (void)setMenuStyle:(XHMenuStyle)menuStyle {
    _menuStyle = menuStyle;
    switch (menuStyle) {
        case XHMenuDarkStyle:
        {
            self.selectedBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
            self.menuTitleLab.textColor = [UIColor whiteColor];
            self.contentView.backgroundColor = self.cellColor;
            if (!self.menuCellLineColor) {
                self.lineColor = [UIColor whiteColor];
            }
        }
            break;
        case XHMenuLightStyle:
        {
            self.selectedBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.menuTitleLab.textColor = [UIColor blackColor];
            self.contentView.backgroundColor = self.cellColor;
            if (!self.menuCellLineColor) {
                self.lineColor = [UIColor lightGrayColor];
            }
        }
            break;
        default:
            break;
    }
}

- (void)setIsFinalCell:(BOOL)isFinalCell{
    _isFinalCell = isFinalCell;
    if (!isFinalCell) {
        [self drawLineSep];
    }
}

- (void)drawLineSep {
    if (self.menuCellLineColor) {
        CAShapeLayer *lineLayer = [CAShapeLayer new];
        lineLayer.strokeColor = self.lineColor.CGColor;
        lineLayer.frame = self.bounds;
        lineLayer.lineWidth = 0.5;
        UIBezierPath *sepline = [UIBezierPath bezierPath];
        [sepline moveToPoint:CGPointMake(15, self.bounds.size.height-0.5)];
        [sepline addLineToPoint:CGPointMake(self.bounds.size.width-15, self.bounds.size.height-0.5)];
        lineLayer.path = sepline.CGPath;
        [self.layer addSublayer:lineLayer];
    }
}

- (void)setMenuCellLineColor:(UIColor *)menuCellLineColor {
    _menuCellLineColor = menuCellLineColor;
    if (menuCellLineColor) {
        self.lineColor = menuCellLineColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setMenuCellFont:(UIFont *)menuCellFont {
    _menuCellFont = menuCellFont;
    if (menuCellFont) {
        self.menuTitleLab.font = menuCellFont;
    }
}

@end
