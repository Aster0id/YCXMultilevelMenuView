//
//  YCXMultilevelMenuViewRightCell.m
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/3.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import "YCXMultilevelMenuViewRightCell.h"
#import "YCXMultilevelMenuViewConsts.h"

#import "UIImageView+WebCache.h"


@interface YCXMultilevelMenuViewRightCell ()

@property (nonatomic, weak) IBOutlet UIImageView *cover;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *topicCount;
@property (nonatomic, weak) IBOutlet UILabel *content;
@property (nonatomic, weak) IBOutlet UILabel *isNewIcon;

@end


@implementation YCXMultilevelMenuViewRightCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.isNewIcon.layer.borderColor = YCXColorFromRGB(0x54bb0f).CGColor;
    self.isNewIcon.layer.borderWidth = 0.5;
    self.isNewIcon.layer.cornerRadius = 2.5;
    self.isNewIcon.layer.masksToBounds = YES;
    
}

+ (CGFloat)cellHeight {
    return 70;
}

- (void)setCellWithCoverPath:(NSString *)coverPath andTitle:(NSString *)title andTopicCount:(NSString *)topicCount andContent:(NSString *)content andIsNew:(BOOL)isNew {
    [self.cover sd_setImageWithURL:[NSURL URLWithString:coverPath]];
    [self.title setText:title];
    NSInteger count = [topicCount integerValue];
    if (count >= 10000) {
        topicCount = [NSString stringWithFormat:@"%.1fw+",count/10000.0];
    }
    
    [self.topicCount setText:[NSString stringWithFormat:@"今日:%@  ",topicCount]];
    if (isNew) {
        self.isNewIcon.hidden = NO;
        [self.content setText:[NSString stringWithFormat:@"         %@",content]];
    }
    else {
        self.isNewIcon.hidden = YES;
        [self.content setText:content];
    }
}

@end
