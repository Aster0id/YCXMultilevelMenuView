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

@property (nonatomic, weak) IBOutlet YCXMultilevelMenuView *multilevelMenu;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *menuTop;
@end

@implementation ViewController

#pragma mark - Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.multilevelMenu = [[YCXMultilevelMenuView alloc] initWithFrame:self.view.bounds];
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
    if (self.multilevelMenu.leftViewWidth != kLeftViewWidth) {
        self.multilevelMenu.leftViewWidth = kLeftViewWidth;
        self.multilevelMenu.rightViewBackgroudColor = kRightViewBackgroundColor;
        self.multilevelMenu.leftViewSeparatorColor = kLeftViewSeparatorColor;
        self.multilevelMenu.leftViewBackgroudColor = kLeftViewBackgroundColor;
        self.multilevelMenu.leftViewTitleFont = kLeftViewTitleFont;
        self.menuTop.constant = 0;
    } else {
        self.multilevelMenu.leftViewWidth = 60;
        self.multilevelMenu.rightViewBackgroudColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.85 alpha:1];
        self.multilevelMenu.leftViewSeparatorColor = [UIColor redColor];
        self.multilevelMenu.leftViewBackgroudColor = [UIColor colorWithRed:0.769 green:0.855 blue:0.686 alpha:1];
        self.multilevelMenu.leftViewTitleFont = [UIFont systemFontOfSize:11.0f];
        self.menuTop.constant = 80;
    }
}

-(IBAction)refresh:(id)sender {
    self.multilevelMenu.leftViewWidth = arc4random()%90 + 60;
    self.multilevelMenu.rightViewBackgroudColor = [self randomColor];
    self.multilevelMenu.leftViewSeparatorColor = [self randomColor];;
    self.multilevelMenu.leftViewBackgroudColor = [self randomColor];;

    [self.multilevelMenu reloadData];
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:(arc4random()%122 + 122)/255.0 green:(arc4random()%122 + 122)/255.0 blue:(arc4random()%122 + 122)/255.0 alpha:1.0];
}

#pragma mark - YCXMultilevelMenuViewDataSource
- (NSInteger)numberOfChildrenInMenuView:(YCXMultilevelMenuView *)menuView {
    return 20;
}

- (NSInteger)menuView:(YCXMultilevelMenuView *)menuView numberOfSectionsAtChildIndex:(NSInteger)index {
    return index == 0?2:1;
}

- (NSInteger)menuView:(YCXMultilevelMenuView *)menuView numberOfItemsAtChildIndex:(NSInteger)index section:(NSInteger)section {
    return arc4random()%5;
}
- (NSString *)menuView:(YCXMultilevelMenuView *)menuView leftViewTitleAtChildIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"子视图%zd",index];
}


- (CGSize)menuView:(YCXMultilevelMenuView *)menuView referenceSizeForRightViewHeaderAtChildIndex:(NSInteger)index section:(NSInteger)section {
    NSString *rightViewHeaderTitle = @"";
    if (index == 0 && section == 0) {
        rightViewHeaderTitle = @"收藏板块";
    }
    if (index == 0 && section == 1) {
        rightViewHeaderTitle = @"推荐板块";
    }
    
    return rightViewHeaderTitle.length>0?CGSizeMake(menuView.bounds.size.width - menuView.leftViewWidth,32):CGSizeZero;
}

- (UIView *)menuView:(YCXMultilevelMenuView *)menuView rightViewHeaderOnSuperView:(UICollectionReusableView *)superView atChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath {
    
    NSString *rightViewHeaderTitle = @"";
    if (index == 0 && indexPath.section == 0) {
        rightViewHeaderTitle = @"我收藏的";
    }
    if (index == 0 && indexPath.section == 1) {
        rightViewHeaderTitle = @"推荐版块";
    }
    
    UIView *view = [UIView new];
    view.frame = superView.bounds;
    
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame: CGRectMake(40, 0, view.frame.size.width, view.frame.size.height)];
    [headerTitle setFont:[UIFont systemFontOfSize:13.0]];
    [headerTitle setTextColor:YCXColorFromRGB(0x888888)];
    headerTitle.text = rightViewHeaderTitle;
    [view addSubview:headerTitle];
    
    
    UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(12, 6, 20, 20)];
    star.contentMode = UIViewContentModeScaleAspectFit;
    if (indexPath.section == 0) {
        star.image = [UIImage imageNamed:@"icon_star_yellow"];
    } else{
        star.image = [UIImage imageNamed:@"icon_star_green"];
        
    }
    [view addSubview:star];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(10, view.frame.size.height- 1, view.frame.size.width - 20, 1)];
    [bottomLine setBackgroundColor:YCXColorFromRGB(0xe5e5e5)];
    [view addSubview:bottomLine];
    
    return view;
}


- (UICollectionViewCell *)menuView:(YCXMultilevelMenuView *)menuView cellForRightViewAtChildIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath withCell:(YCXMultilevelMenuViewRightCell *)cell {
    
    NSString *coverPath = @"http://g.hiphotos.bdimg.com/wisegame/pic/item/9436afc379310a557dbd23e0b54543a98226100d.jpg";
    NSString *title = @"美女聊聊吧";
    NSString *topicCount = [NSString stringWithFormat:@"%d",arc4random()%1000*100];
    NSString *content = (arc4random()%2==0?@"测试一下啊":@"测试多行的情况下是什么样子的，册册册，够两行了吧？？？");
    BOOL isNew = arc4random()%2 == 0;
    
    [cell setCellWithCoverPath:coverPath andTitle:title andTopicCount:topicCount andContent:content andIsNew:isNew];
    cell.hiddenBottomLine = indexPath.row == 1;
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
