//
//  ViewController.m
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/2.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import "ViewController.h"
#import "YCXMultilevelMenuView.h"

@interface ViewController () <YCXMultilevelMenuViewDataSource, YCXMultilevelMenuViewDelegate>

@property (nonatomic,strong) YCXMultilevelMenuView *multilevelMenu;

@end

@implementation ViewController

#pragma mark - Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.multilevelMenu = [[YCXMultilevelMenuView alloc] initWithFrame:self.view.bounds];
    self.multilevelMenu.dataSource = self;
    self.multilevelMenu.delegate = self;
    
    [self.multilevelMenu setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.multilevelMenu];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.multilevelMenu.frame = self.view.bounds;
}

#pragma mark - Actions

- (IBAction)clickRightItem {
    if (self.multilevelMenu.LeftViewWidth != kLeftViewWidth) {
        self.multilevelMenu.LeftViewWidth = kLeftViewWidth;
        self.multilevelMenu.rightViewBackgroudColor = kRightViewBackgroundColor;
        self.multilevelMenu.leftViewSeparatorColor = kLeftViewSeparatorColor;
        self.multilevelMenu.leftViewBackgroudColor = kLeftViewBackgroundColor;
    } else {
        self.multilevelMenu.LeftViewWidth = 80;
        self.multilevelMenu.rightViewBackgroudColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.85 alpha:1];
        self.multilevelMenu.leftViewSeparatorColor = [UIColor redColor];
        self.multilevelMenu.leftViewBackgroudColor = [UIColor colorWithRed:0.769 green:0.855 blue:0.686 alpha:1];
    }
}


#pragma mark - YCXMultilevelMenuViewDataSource
- (NSInteger)numberOfChildrenInMenuView:(YCXMultilevelMenuView *)menuView {
    return 20;
}

- (NSInteger)menuView:(YCXMultilevelMenuView *)menuView numberOfSectionsAtChildIndex:(NSInteger)index {
    return index == 0?2:1;
}

- (NSString *)menuView:(YCXMultilevelMenuView *)menuView leftViewTitleAtChildIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"子视图%zd",index];
}

- (NSString *)menuView:(YCXMultilevelMenuView *)menuView rightViewHeaderTitleAtChildIndex:(NSInteger)index section:(NSInteger)section {
    NSString *rightViewHeaderTitle = @"";
    if (index == 0 && section == 0) {
        rightViewHeaderTitle = @"收藏板块";
    }
    if (index == 0 && section == 1) {
        rightViewHeaderTitle = @"推荐板块";
    }
    return rightViewHeaderTitle;
}

- (UICollectionViewCell *)menuView:(YCXMultilevelMenuView *)menuView cellForRightViewAtChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath withCell:(YCXMultilevelMenuViewRightCell *)cell {
    
    NSString *coverPath = @"http://g.hiphotos.bdimg.com/wisegame/pic/item/9436afc379310a557dbd23e0b54543a98226100d.jpg";
    NSString *title = @"美女聊聊吧";
    NSString *topicCount = [NSString stringWithFormat:@"%d",arc4random()%1000*100];
    NSString *content = (arc4random()%2==0?@"测试一下啊":@"测试多行的情况下是什么样子的，册册册，够两行了吧？？？");
    BOOL isNew = arc4random()%2 == 0;
    
    [cell setCellWithCoverPath:coverPath andTitle:title andTopicCount:topicCount andContent:content andIsNew:isNew];
    
    return cell;
}

#pragma mark - YCXMultilevelMenuViewDelegate

-(void)menuView:(YCXMultilevelMenuView *)menuView didSelectChildAtIndex:(NSInteger)index {
    NSLog(@"menuView:didSelectChildAtIndex:%zd",index);
}

- (void)menuView:(YCXMultilevelMenuView *)menuView didSelectCell:(YCXMultilevelMenuViewRightCell *)cell atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath {
    NSLog(@"menuView:didSelectCell:atChildIndex:%zd indexPath:%@", index, indexPath);
}

- (void)menuView:(YCXMultilevelMenuView *)menuView didDeselectCell:(YCXMultilevelMenuViewRightCell *)cell atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath {
    NSLog(@"menuView:didDeselectCell:atChildIndex:%zd indexPath:%@", index, indexPath);
}

@end
