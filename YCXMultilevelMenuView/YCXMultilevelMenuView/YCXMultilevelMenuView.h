//
//  YCXMultilevelMenuView.h
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/2.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCXMultilevelMenuViewConsts.h"

#import "YCXMultilevelMenuViewRightCell.h"


@class YCXMultilevelMenuView;


@protocol YCXMultilevelMenuViewDataSource<NSObject>

@required

- (NSInteger)numberOfChildrenInMenuView:(YCXMultilevelMenuView *)menuView;
- (NSInteger)menuView:(YCXMultilevelMenuView *)menuView numberOfSectionsAtChildIndex:(NSInteger)index;
- (NSInteger)menuView:(YCXMultilevelMenuView *)menuView numberOfItemsAtChildIndex:(NSInteger)index section:(NSInteger)section;;

- (NSString *)menuView:(YCXMultilevelMenuView *)menuView rightViewHeaderTitleAtChildIndex:(NSInteger)index section:(NSInteger)section;
- (NSString *)menuView:(YCXMultilevelMenuView *)menuView leftViewTitleAtChildIndex:(NSInteger)index;
- (UICollectionViewCell *)menuView:(YCXMultilevelMenuView *)menuView cellForRightViewAtChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath withCell:(YCXMultilevelMenuViewRightCell *)cell;

@end


@protocol YCXMultilevelMenuViewDelegate <NSObject>

@optional

/// 选中子视图的索引
- (void)menuView:(YCXMultilevelMenuView *)menuView didSelectChildAtIndex:(NSInteger)index;

/// 选中子视图中的Cell及其索引
- (void)menuView:(YCXMultilevelMenuView *)menuView didSelectCell:(YCXMultilevelMenuViewRightCell *)cell atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

/// 选中子视图中的Cell及其索引
- (void)menuView:(YCXMultilevelMenuView *)menuView didDeselectCell:(YCXMultilevelMenuViewRightCell *)cell atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

@end


@interface YCXMultilevelMenuView : UIView

@property (nonatomic, weak) id<YCXMultilevelMenuViewDataSource> dataSource;
@property (nonatomic, weak) id<YCXMultilevelMenuViewDelegate> delegate;

/** 左视图的宽度 */
@property (nonatomic, assign) CGFloat LeftViewWidth;
/** 左视图的背景色 */
@property (nonatomic, strong) UIColor *leftViewBackgroudColor;
/**  左视图的分割线颜色 */
@property (nonatomic, strong) UIColor * leftViewSeparatorColor;


/** 右视图背景色*/
@property (nonatomic, strong) UIColor *rightViewBackgroudColor;

@end

