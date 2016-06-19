//
//  YKBaseMenuViewController.m
//  BuDeJie
//
//  Created by yk on 16/5/2.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKBaseMenuViewController.h"
#import "YKShopView.h"


static NSString * const ID = @"cell";

@interface YKBaseMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView *contentView;
@property (weak, nonatomic) UIScrollView *titleView;
@property (weak, nonatomic) YKShopView *shopView;
@property (weak, nonatomic) UIButton *selButton;
@property (strong, nonatomic) NSMutableArray *titleButtons;
@property (weak, nonatomic) UIView *bottomLine;
@property (assign, nonatomic) BOOL isInitial;
@property (weak, nonatomic) id observer1;
@property (weak, nonatomic) id observer2;


@end

@implementation YKBaseMenuViewController
#pragma mark -------------------
#pragma mark lazy loading
- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

/*
 导航条显示的内容由当前栈顶控制器去决定
 左边/右边/title
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加一个UICollectionView
    [self setupContentView];
    
    //添加顶部的titleView(后添加的View 显示在最前面)
    [self setupTitleView];
    
    //添加底部购物栏
    [self setupShopView];
    
    //iOS7之后导航控制器下 UIscrollView的顶部有64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        //设置顶部标题
        [self setupAllTitle];
    }
}


#pragma mark -------------------
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

//只要有新的 cell 出现才会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_contentView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //在添加子控制器的 View 之前一定要把上一个控制器的 View 移除
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //取出对应的子控制器
    UIViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, YKScreenW, YKScreenH);
    vc.view.backgroundColor = YKMyCoffeeColor;
    //把对应控制器的 View 添加到 cell 上
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark -------------------
#pragma mark UICollectionViewDelegate
//CollectionView滚动完时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前页数
    NSInteger i = scrollView.contentOffset.x / YKScreenW;
    //选中对应的按钮(根据角标在scrollView取出对应的子控件不准确)
    [self selectButton:self.titleButtons[i]];
}

#pragma mark -------------------
#pragma mark EVents
//点击了标题按钮
- (void)titleClick:(UIButton *)button
{
    //1.设置按钮选中状态
    [self selectButton:button];
    
    //2.让 collectionView 滚动到对应位置,并不是马上滚动
    CGFloat offsetX = YKScreenW * button.tag;
    _contentView.contentOffset = CGPointMake(offsetX, 0);
    
}
//设置按钮选中状态
- (void)selectButton:(UIButton *)button
{
    _selButton.selected = NO;
    button.selected = YES;
    _selButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        _bottomLine.yk_width = _selButton.titleLabel.yk_width;
        _bottomLine.yk_centerX = _selButton.yk_centerX;
    }];
}
//添加下划线
- (void)addBottomLine
{
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor redColor];
    //1.中心点等于按钮的中心点 2.宽度等于标题的宽度 3.高度2  4.y=titleView 的高度-2
    bottomLine.yk_width = [_selButton.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:15]].width; //先确定宽度再确定中心点
    bottomLine.yk_centerX = _selButton.yk_centerX;
    bottomLine.yk_height = 2;
    bottomLine.yk_y = _titleView.yk_height - 2;
    [_titleView addSubview:bottomLine];
    _bottomLine = bottomLine;
}

#pragma mark -------------------
#pragma mark 设置所有子控制器的标题
- (void)setupAllTitle
{
    NSInteger count = self.childViewControllers.count;
    
    CGFloat BtnX = 0;
    for (int i = 0; i < count; i++) {
        BtnX = _titleView.yk_width / count * i;
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        //计算按钮尺寸
        titleButton.frame = CGRectMake(BtnX, 0, _titleView.yk_width / count, _titleView.yk_height);
        [titleButton setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithWhite:0.8 alpha:0.8] forState:UIControlStateNormal];
        [titleButton setTitleColor:YKRGB(239, 215, 137) forState:UIControlStateSelected];
        //设置字体
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        //监听点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:titleButton];
        
        [self.titleButtons addObject:titleButton];
        
        //默认选中第一个按钮
        if (i == 0) {
            [self titleClick:titleButton];
            
            //添加下划线
            [self addBottomLine];
        }
        
    }
}

-(void)addAllChildViewController{};

#pragma mark -------------------
#pragma mark 初始化设置
//添加底部购物栏
- (void)setupShopView
{
    YKShopView *shopView = [YKShopView shopView];
    CGFloat h = 40;
    CGFloat y = self.view.yk_height - h - 64;
    shopView.frame = CGRectMake(0, y, YKScreenW, h);
    [self.view addSubview:shopView];
    _shopView = shopView;
}

//添加顶部的titleView(后添加的View 显示在最前面)
- (void)setupTitleView
{
    //titleView有多少个标题有子控制器的数量决定,使用 scrollView 扩展性更好
//    CGFloat topY = self.navigationController.navigationBarHidden ? 20 : 64;
    UIScrollView *titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, YKScreenW, 35)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 34, YKScreenW, 1)];
    view.backgroundColor = YKBgColor;
    [titleView addSubview:view];
    titleView.backgroundColor = YKMyCoffeeColor; //[UIColor colorWithWhite:1 alpha:0.8];
    [self.view addSubview:titleView];
    titleView.scrollsToTop = NO;
    _titleView = titleView;
}
//添加一个UICollectionView
- (void)setupContentView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(YKScreenW, YKScreenH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    contentView.dataSource = self;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    [self.view addSubview:contentView];
    contentView.scrollsToTop = NO;
    _contentView = contentView;
    
    //注册 cell
    [contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}



@end
