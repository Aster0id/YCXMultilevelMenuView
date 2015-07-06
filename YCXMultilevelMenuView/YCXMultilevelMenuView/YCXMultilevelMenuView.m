//
//  YCXMultilevelMenuView.m
//  YCXMultilevelMenuView
//
//  Created by 牛萌 on 15/7/2.
//  Copyright (c) 2015年 Aster0id.Team. All rights reserved.
//

#import "YCXMultilevelMenuView.h"

#import "YCXMultilevelMenuViewLeftCell.h"


#define kLeftCell           @"LeftCell"
#define kRightCell          @"RightCell"
#define kRightViewHeader    @"RightViewHeader"


@interface YCXMultilevelMenuView ()
<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UICollectionView *rightCollectionView;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation YCXMultilevelMenuView

#pragma mark - System Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    
    /// 初始化属性
    self.LeftViewWidth = kLeftViewWidth;
    self.leftViewBackgroudColor = kLeftViewBackgroundColor;
    self.leftViewSeparatorColor = kLeftViewSeparatorColor;
    
    self.rightViewBackgroudColor = kRightViewBackgroundColor;
    
    self.selectIndex = 0;
    
    /// 初始化左视图
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.LeftViewWidth, self.bounds.size.height) style:UITableViewStylePlain];
    [self.leftTableView setBackgroundColor:self.leftViewBackgroudColor];
    
    [self.leftTableView setSeparatorColor:self.leftViewSeparatorColor];
    [self.leftTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.leftTableView setTableFooterView:[UIView new]];
    
    [self.leftTableView registerNib:[UINib nibWithNibName:@"YCXMultilevelMenuViewLeftCell" bundle:nil] forCellReuseIdentifier:kLeftCell];
    
    [self.leftTableView setRowHeight:[YCXMultilevelMenuViewLeftCell cellHeight]];
    [self.leftTableView setBounces:NO];
    [self.leftTableView setShowsHorizontalScrollIndicator:NO];
    [self.leftTableView setShowsVerticalScrollIndicator:NO];
    
    [self.leftTableView setDelegate:self];
    
    [self addSubview:self.leftTableView];
    
    
    /// 初始化右视图
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    
    self.rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.LeftViewWidth, 0, self.bounds.size.width - self.LeftViewWidth, self.bounds.size.height) collectionViewLayout:flowLayout];
    [self.rightCollectionView setBackgroundColor:self.rightViewBackgroudColor];
    
    [self.rightCollectionView registerNib:[UINib nibWithNibName:@"YCXMultilevelMenuViewRightCell" bundle:nil] forCellWithReuseIdentifier:kRightCell];
    [self.rightCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRightViewHeader];
    
    self.rightCollectionView.delegate = self;
    
    [self addSubview:self.rightCollectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftTableView.frame = CGRectMake(0, 0, self.LeftViewWidth, self.bounds.size.height);
    self.rightCollectionView.frame = CGRectMake(self.LeftViewWidth, 0, self.bounds.size.width - self.LeftViewWidth, self.bounds.size.height);
}

#pragma mark - Private Methods
- (void)updateSubviews {
    
    self.leftTableView.backgroundColor = self.leftViewBackgroudColor;
    self.leftTableView.separatorColor = self.leftViewSeparatorColor;
    self.rightCollectionView.backgroundColor = self.rightViewBackgroudColor;
    
    [self.leftTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    [self.rightCollectionView reloadData];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfChildrenInMenuView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCXMultilevelMenuViewLeftCell * cell=[tableView dequeueReusableCellWithIdentifier:kLeftCell forIndexPath:indexPath];
    
    cell.separatorColor = self.leftViewSeparatorColor;
    cell.unselectedBackgroundColor = self.leftViewBackgroudColor;
    cell.selectedBackgroundColor = self.rightViewBackgroudColor;
    [cell setCellWithTitle:[self.dataSource menuView:self leftViewTitleAtChildIndex:indexPath.row]];
    
    [cell layoutSubviews];
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectIndex) return;
    
    // 更新选中索引
    self.selectIndex = indexPath.row;
    
    // 滚动左视图，是选中Cell移动到顶端
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self.rightCollectionView reloadData];

    if(self.delegate && [self.delegate respondsToSelector:@selector(menuView:didSelectChildAtIndex:)]) {
        [self.delegate menuView:self didSelectChildAtIndex:self.selectIndex];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self.dataSource menuView:self rightViewHeaderTitleAtChildIndex:self.selectIndex section:section].length>0?CGSizeMake(self.bounds.size.width - self.LeftViewWidth, 32):CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.bounds.size.width - self.LeftViewWidth, [YCXMultilevelMenuViewRightCell cellHeight]);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataSource menuView:self numberOfSectionsAtChildIndex:self.selectIndex];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YCXMultilevelMenuViewRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRightCell forIndexPath:indexPath];
    [cell layoutSubviews];
    return [self.dataSource menuView:self cellForRightViewAtChildIndex:self.selectIndex indexPath:indexPath withCell:cell];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:kRightViewHeader forIndexPath:indexPath];
        
        for (UIView *view in header.subviews) {[view removeFromSuperview];}
        [header setBackgroundColor:[UIColor clearColor]];
        
        
        UILabel *headerTitle = [[UILabel alloc] initWithFrame: CGRectMake(12, 0, header.frame.size.width, header.frame.size.height)];
        [headerTitle setFont:[UIFont systemFontOfSize:13.0]];
        [headerTitle setTextColor:YCXColorFromRGB(0x888888)];
        headerTitle.text = [self.dataSource menuView:self rightViewHeaderTitleAtChildIndex:self.selectIndex section:indexPath.section];
        [header addSubview:headerTitle];
        
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(10, header.frame.size.height- 0.5, header.frame.size.width - 20, 0.5)];
        [bottomLine setBackgroundColor:[UIColor lightGrayColor]];
        [header addSubview:bottomLine];
        return header;
    }
    
    return [UICollectionReusableView new];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if(self.delegate && [self.delegate respondsToSelector:@selector(menuView:didSelectCell:atChildIndex:indexPath:)]) {
        [self.delegate menuView:self didSelectCell:(YCXMultilevelMenuViewRightCell *)[collectionView cellForItemAtIndexPath:indexPath] atChildIndex:self.selectIndex indexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(menuView:didDeselectCell:atChildIndex:indexPath:)]) {
        [self.delegate menuView:self didDeselectCell:(YCXMultilevelMenuViewRightCell *)[collectionView cellForItemAtIndexPath:indexPath] atChildIndex:self.selectIndex indexPath:indexPath];
    }
    
}
#pragma mark - setter/getter

- (void)setDataSource:(id<YCXMultilevelMenuViewDataSource>)dataSource {
    _dataSource = dataSource;
    if (_dataSource) {
        self.leftTableView.dataSource = self;
        self.rightCollectionView.dataSource = self;
        [self updateSubviews];
    }
}

- (void)setLeftViewWidth:(CGFloat)LeftViewWidth {
    _LeftViewWidth = LeftViewWidth;
    [self layoutSubviews];
    [self updateSubviews];
}
- (void)setLeftViewBackgroudColor:(UIColor *)leftViewBackgroudColor {
    _leftViewBackgroudColor = leftViewBackgroudColor;
    [self updateSubviews];
}

- (void)setLeftViewSeparatorColor:(UIColor *)leftViewSeparatorColor {
    _leftViewSeparatorColor = leftViewSeparatorColor;
    [self updateSubviews];
}

- (void)setRightViewBackgroudColor:(UIColor *)rightViewBackgroudColor {
    _rightViewBackgroudColor = rightViewBackgroudColor;
    [self updateSubviews];
}

@end
