//
//  XHTagsView.m
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHTagsView.h"
#import "UIColor+XHHexColor.h"
#import "NSString+XHSize.h"

@interface XHTagsView ()

@property (nonatomic, strong) NSArray *tagTitles;
@property (nonatomic, assign) CGFloat lastX;
@property (nonatomic, assign) CGFloat lastY;
@property (nonatomic, assign) CGFloat tagHeight;
@property (nonatomic, strong) NSArray *colorPol;

@end

static CGFloat const tagMargin = 10.0f;
static CGFloat const tagPaddingW = 10.0f;
static CGFloat const tagPaddingH = 5.0f;
static CGFloat viewWidth = 0;

@implementation XHTagsView

- (instancetype)initWithFrame:(CGRect)frame withTags:(NSArray *)tags {
    if (self = [super initWithFrame:frame]) {
        self.tagTitles = tags;
        viewWidth = frame.size.width;
        [self setup];
        [self setupSubViews];
    }
    return self;
}

- (void)setup {
    self.lastY = tagMargin;
    self.backgroundColor = [UIColor whiteColor];
    self.tagsFont = [UIFont systemFontOfSize:14];
}

- (void)setupSubViews {
    for (int i = 0; i < self.tagTitles.count; i ++) {
        NSString *title = self.tagTitles[i];
        
        UILabel *tagLabel = [UILabel new];
        tagLabel.font = self.tagsFont;
        tagLabel.layer.cornerRadius = 4;
        tagLabel.clipsToBounds = true;
        tagLabel.text = title;
        tagLabel.textColor = [UIColor darkGrayColor];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [tagLabel addGestureRecognizer:tap];
        [self addSubview:tagLabel];
        
        CGFloat width = [title xh_widthWithFont:self.tagsFont constrainedToHeight:MAXFLOAT];
        self.tagHeight = [title xh_heightWithFont:self.tagsFont constrainedToWidth:MAXFLOAT];
        
        if (width+tagMargin*2+tagPaddingW*2+self.lastX > viewWidth) {
            self.lastX = 0;
            self.lastY += tagMargin + self.tagHeight + tagPaddingH * 2;
        }
        tagLabel.x = self.lastX + tagMargin;
        tagLabel.y = self.lastY;
        tagLabel.width = width+tagPaddingW*2;
        tagLabel.height = self.tagHeight + tagPaddingH * 2;
        
        // 设置样式
        switch (self.tagStyle) {
            case XHTagStyleNormal: {
                tagLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
                break;
            case XHTagStyleARC: {
                tagLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
                tagLabel.layer.cornerRadius = (self.tagHeight + tagPaddingH * 2)/2;
            }
                break;
            case XHTagStyleColorful: {
                tagLabel.backgroundColor = self.colorPol[arc4random_uniform((uint32_t)self.colorPol.count)];
            }
                break;
            case XHTagStyleBorder: {
                tagLabel.backgroundColor = [UIColor whiteColor];
                tagLabel.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                tagLabel.layer.borderWidth = 1;
            }
                break;
            case XHTagStyleARCBorder: {
                tagLabel.layer.cornerRadius = (self.tagHeight + tagPaddingH * 2)/2;
                tagLabel.backgroundColor = [UIColor whiteColor];
                tagLabel.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                tagLabel.layer.borderWidth = 1;
            }
                break;
            default:
                break;
        }
        
        self.lastX = self.lastX + [title xh_widthWithFont:self.tagsFont constrainedToHeight:MAXFLOAT] + tagPaddingW*2 + tagMargin;
    }
    
    self.height = self.lastY + self.tagHeight + tagPaddingH * 2 + tagMargin;
}

- (void)setRankSubViews {
    CGFloat halfWidth = viewWidth/2;
    for (int i = 0; i < self.tagTitles.count; i ++) {
        NSString *title = self.tagTitles[i];
        
        UIView *tapView = [UIView new];
        tapView.backgroundColor = [UIColor clearColor];
        tapView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [tapView addGestureRecognizer:tap];
        [self addSubview:tapView];
        
        UILabel *rankLabel = [UILabel new];
        rankLabel.text = [NSString stringWithFormat:@"%d", i+1];
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.font = [UIFont systemFontOfSize:10];
        rankLabel.layer.cornerRadius = 3;
        rankLabel.clipsToBounds = true;
        [tapView addSubview:rankLabel];
        
        switch (i) {
            case 0: // NO.1
                rankLabel.backgroundColor = [UIColor colorWithHexString:@"f14230"];
                rankLabel.textColor = [UIColor whiteColor];
                break;
            case 1: // NO.2
                rankLabel.backgroundColor = [UIColor colorWithHexString:@"ff8000"];
                rankLabel.textColor = [UIColor whiteColor];
                break;
            case 2: // NO.3
                rankLabel.backgroundColor = [UIColor colorWithHexString:@"ffcc01"];
                rankLabel.textColor = [UIColor whiteColor];
                break;
            default: // Other
                rankLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
                rankLabel.textColor = [UIColor darkGrayColor];
                break;
        }
        
        UILabel *tagLabel = [UILabel new];
        tagLabel.font = self.tagsFont;
        tagLabel.text = title;
        tagLabel.textColor = [UIColor darkGrayColor];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.userInteractionEnabled = YES;
        [tapView addSubview:tagLabel];
        
        
        CGFloat width = [title xh_widthWithFont:self.tagsFont constrainedToHeight:MAXFLOAT];
        self.tagHeight = [title xh_heightWithFont:self.tagsFont constrainedToWidth:MAXFLOAT];
        
        if (i == 0) {
            self.lastX = 0;
            self.lastY = tagMargin;
        }
        else if (i % 2 == 0) {
            self.lastX = 0;
            self.lastY += tagMargin + self.tagHeight + tagPaddingH * 2;
        } else {
            self.lastX = halfWidth;
        }
        
        tapView.x = self.lastX + tagMargin;
        tapView.y = self.lastY;
        tapView.width = halfWidth-tagMargin*2;
        tapView.height = self.tagHeight + tagPaddingH * 2;
        
        rankLabel.x = 0;
        rankLabel.y = tagPaddingH;
        rankLabel.width = self.tagHeight;
        rankLabel.height = self.tagHeight;
        
        self.lastX = rankLabel.x + self.tagHeight;
        
        tagLabel.x = self.tagHeight + tagMargin;
        tagLabel.y = 0;
        tagLabel.width = width;
        tagLabel.height = self.tagHeight + tagPaddingH * 2;
    }
    
    self.height = self.lastY + self.tagHeight + tagPaddingH * 2 + tagMargin;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    UILabel *label;
    if (self.tagStyle == XHTagStyleRank) {
        label = (UILabel *)tap.view.subviews[1];
    } else {
        label = (UILabel *)tap.view;
    }
    if ([self.delegate respondsToSelector:@selector(tagView:didClickedTag:atIndex:)]) {
        [self.delegate tagView:self didClickedTag:label.text atIndex:[self.tagTitles indexOfObject:label.text]];
    }
}

#pragma mark - Setter & Getter

- (void)setTagStyle:(XHTagStyle)tagStyle {
    _tagStyle = tagStyle;
    [self removeAllSubviews];
    self.lastX = 0;
    self.lastY = tagMargin;
    if (tagStyle == XHTagStyleRank) {
        [self setRankSubViews];
    } else {
        [self setupSubViews];
    }
}

- (NSArray *)colorPol {
    if (!_colorPol) {
        NSArray *colorStrPol = @[@"009999", @"0099cc", @"0099ff", @"00cc99", @"00cccc", @"336699", @"3366cc", @"3366ff", @"339966", @"666666", @"666699", @"6666cc", @"6666ff", @"996666", @"996699", @"999900", @"999933", @"99cc00", @"99cc33", @"660066", @"669933", @"990066", @"cc9900", @"cc6600" , @"cc3300", @"cc3366", @"cc6666", @"cc6699", @"cc0066", @"cc0033", @"ffcc00", @"ffcc33", @"ff9900", @"ff9933", @"ff6600", @"ff6633", @"ff6666", @"ff6699", @"ff3366", @"ff3333"];
        NSMutableArray *colorPolM = [NSMutableArray array];
        for (NSString *colorStr in colorStrPol) {
            UIColor *color = [UIColor colorWithHexString:colorStr];
            [colorPolM addObject:color];
        }
        _colorPol = colorPolM;
    }
    return _colorPol;
}

@end
