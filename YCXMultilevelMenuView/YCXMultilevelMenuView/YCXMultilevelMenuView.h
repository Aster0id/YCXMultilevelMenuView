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

/**
 *  @brief 左部子视图的个数
 */
- (NSInteger)numberOfChildrenInMenuView:(YCXMultilevelMenuView *)menuView;

/**
 *  @brief 右部Section的个数
 */
- (NSInteger)menuView:(YCXMultilevelMenuView *)menuView numberOfSectionsAtChildIndex:(NSInteger)index;

/**
 *  @brief 右部Section下Item的个数
 */
- (NSInteger)menuView:(YCXMultilevelMenuView *)menuView numberOfItemsAtChildIndex:(NSInteger)index section:(NSInteger)section;

/**
 *  @brief 左部子视图的标题名称
 */
- (NSString *)menuView:(YCXMultilevelMenuView *)menuView leftViewTitleAtChildIndex:(NSInteger)index;

/**
 *  @brief 右部Cell
 */
- (UICollectionViewCell *)menuView:(YCXMultilevelMenuView *)menuView cellForRightViewAtChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath withCell:(YCXMultilevelMenuViewRightCell *)cell;

@optional
/**
 *  @brief 右部Section的尺寸
 */
- (CGSize)menuView:(YCXMultilevelMenuView *)menuView referenceSizeForRightViewHeaderAtChildIndex:(NSInteger)index section:(NSInteger)section;

/**
 *  @brief 右部Section的子视图
 */
- (UIView *)menuView:(YCXMultilevelMenuView *)menuView rightViewHeaderOnSuperView:(UICollectionReusableView *)superView atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

@end



@protocol YCXMultilevelMenuViewDelegate <NSObject>

@optional

/**
 *  @brief 选中子视图的索引
 */
- (void)menuView:(YCXMultilevelMenuView *)menuView didSelectChildAtIndex:(NSInteger)index;

/**
 *  @brief 选中子视图中的Cell及其索引
 */
- (void)menuView:(YCXMultilevelMenuView *)menuView didSelectCell:(YCXMultilevelMenuViewRightCell *)cell atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

/**
 *  @brief 选中子视图中的Cell及其索引
 */
- (void)menuView:(YCXMultilevelMenuView *)menuView didDeselectCell:(YCXMultilevelMenuViewRightCell *)cell atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

@end


@interface YCXMultilevelMenuView : UIView

@property (nonatomic, weak) id<YCXMultilevelMenuViewDataSource> dataSource;
@property (nonatomic, weak) id<YCXMultilevelMenuViewDelegate> delegate;

/** 左视图的宽度 */
@property (nonatomic, assign) CGFloat  leftViewWidth;
/** 左视图的背景色 */
@property (nonatomic, strong) UIColor *leftViewBackgroudColor;
/**  左视图的分割线颜色 */
@property (nonatomic, strong) UIColor *leftViewSeparatorColor;

/** 右视图背景色*/
@property (nonatomic, strong) UIColor *rightViewBackgroudColor;


/**
 *  @brief  刷新数据
 */
- (void)reloadData;

@end

