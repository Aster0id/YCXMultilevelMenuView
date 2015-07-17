//
//  YCXMultilevelMenuViewConsts.h
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/2.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import <Foundation/Foundation.h>


#define YCXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define kLeftViewWidth 80
#define kLeftViewBackgroundColor YCXColorFromRGB(0xf0f0f0)
#define kLeftViewSeparatorColor  YCXColorFromRGB(0xd5d5d5)
#define kLeftViewTitleFont  [UIFont systemFontOfSize:13.0]

#define kRightViewBackgroundColor YCXColorFromRGB(0xfafafa)

@interface YCXMultilevelMenuViewConsts : NSObject

@end
