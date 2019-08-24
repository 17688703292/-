//
//  XHSearchBar.m
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHSearchBar.h"
#import "UIButton+XHImagePosition.h"

@interface XHSearchBar ()

@property (nonatomic, strong) UIButton *searchButton; ///< 搜索条

@end

@implementation XHSearchBar

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder delegate:(id <XHSearchBarDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 50);
        self.delegate = delegate;
        self.placeholder = placeholder ? placeholder : @"搜索";
        [self setupDefault];
        [self setupSubViews];
    }
    return self;
}

- (void)setupDefault {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.barBackgroudColor = [UIColor groupTableViewBackgroundColor];
    self.barTintColor = [UIColor blackColor];
}

- (void)setupSubViews {
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.frame = CGRectMake(10, (self.bounds.size.height-30)/2, self.frame.size.width-20, 30);
    self.searchButton.backgroundColor = [UIColor whiteColor];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.searchButton.adjustsImageWhenHighlighted = false;
    self.searchButton.layer.cornerRadius = 5;
    self.searchButton.clipsToBounds = true;
    [self.searchButton setTitle:self.placeholder forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.searchButton setImage:[UIImage imageNamed:@"xh_icon_search"] forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(clickedSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton];
    [self.searchButton xh_setImagePosition:XHButtonImagePositionLeft spacing:10];
}

- (void)clickedSearchButton {
    XHSearchController *searchController = [XHSearchController new];
    searchController.hidesBottomBarWhenPushed = true;
    searchController.barBackgroudColor = self.barBackgroudColor;
    searchController.barTintColor = self.barTintColor;
    searchController.hotKeywords = self.hotKeywords;
    searchController.tagStyle = self.tagStyle;
    searchController.searchStyle = self.searchStyle;
    if ([self.delegate respondsToSelector:@selector(searchBar:willTurnToSearchController:)]) {
        [self.delegate searchBar:self willTurnToSearchController:searchController];
    }
}

@end
