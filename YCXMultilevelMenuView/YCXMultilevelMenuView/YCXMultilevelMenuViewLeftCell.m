//
//  YCXMultilevelViewLeftCell.m
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/2.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import "YCXMultilevelMenuViewLeftCell.h"
#import "YCXMultilevelMenuViewConsts.h"


@interface YCXMultilevelMenuViewLeftCell ()


@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIView *rightBorderView;
@property (nonatomic, weak) IBOutlet UIView *bottomBorderView;

@end

@implementation YCXMultilevelMenuViewLeftCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self reloadView];
}

#pragma mark - Publice Methods
+ (CGFloat)cellHeight {
    return 44;
}

- (void)setCellWithTitle:(NSString *)title {
    [self.title setText:title];
}

#pragma mark - Private Methods
- (void)reloadView {
    [self.title setTextColor:self.isSelected?self.selectedTitleColor:self.unselectedTitleColor];
    [self.title setFont:self.titleFont];
    
    [self.contentView setBackgroundColor:self.isSelected?self.selectedBackgroundColor:self.unselectedBackgroundColor];
    
    [self.rightBorderView setBackgroundColor:self.isSelected?[UIColor clearColor]:self.separatorColor];
    [self.bottomBorderView setBackgroundColor:self.separatorColor];
}

#pragma mark - setter/getter

- (UIColor *)unselectedBackgroundColor {
    if (!_unselectedBackgroundColor) {
        _unselectedBackgroundColor = kLeftViewBackgroundColor;
    }
    return _unselectedBackgroundColor;
}


- (UIColor *)_selectedBackgroundColor {
    if (!_selectedBackgroundColor) {
        _selectedBackgroundColor = kRightViewBackgroundColor;
    }
    return _selectedBackgroundColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = kLeftViewSeparatorColor;
    }
    return _separatorColor;
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = kLeftViewTitleFont;
    }
    return _titleFont;
}

- (UIColor *)unselectedTitleColor {
    if (!_unselectedTitleColor) {
        _unselectedTitleColor = [UIColor blackColor];
    }
    return _unselectedTitleColor;
}

- (UIColor *)selectedTitleColor {
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor blackColor];
    }
    return _selectedTitleColor;
}

@end
