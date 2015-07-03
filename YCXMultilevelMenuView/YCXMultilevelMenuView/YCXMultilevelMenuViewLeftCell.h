//
//  YCXMultilevelViewLeftCell.h
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/2.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCXMultilevelMenuViewLeftCell : UITableViewCell

/** 标题字体 */
@property (nonatomic, strong) UIFont *titleFont;

/** 未选中情况下，背景色 */
@property (nonatomic, strong) UIColor *unselectedBackgroundColor;
/** 未选中情况下，标题颜色 */
@property (nonatomic, strong) UIColor *unselectedTitleColor;

/** 选中情况下，背景色 */
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
/** 选中情况下，标题颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** 选中情况下，右边框颜色 */
@property (nonatomic, strong) UIColor *separatorColor;


+ (CGFloat)cellHeight;

- (void)setCellWithTitle:(NSString *)title;


@end
