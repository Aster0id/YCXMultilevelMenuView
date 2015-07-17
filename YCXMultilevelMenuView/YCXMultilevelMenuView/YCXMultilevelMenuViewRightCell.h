//
//  YCXMultilevelMenuViewRightCell.h
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/3.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCXMultilevelMenuViewRightCell : UICollectionViewCell

@property (nonatomic, assign) BOOL hiddenBottomLine;

+ (CGFloat)cellHeight;

- (void)setCellWithCoverPath:(NSString *)coverPath andTitle:(NSString *)title andTopicCount:(NSString *)topicCount andContent:(NSString *)content andIsNew:(BOOL)isNew;

@end
