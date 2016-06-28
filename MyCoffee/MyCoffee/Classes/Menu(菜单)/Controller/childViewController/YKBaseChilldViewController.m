//
//  YKBaseChilldViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/14.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKBaseChilldViewController.h"
#import "YKWaterFullLayout.h"
#import "YKShopCell.h"

static NSString * const ID = @"cell";

@interface YKBaseChilldViewController ()<UICollectionViewDataSource>

@end

@implementation YKBaseChilldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加 collectionView
    [self setupCollectionView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark -------------------
#pragma mark 初始化设置
//添加 collectionView
- (void)setupCollectionView
{
    //创建瀑布流布局方式
    YKWaterFullLayout *layout = [[YKWaterFullLayout alloc] init];
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: self.view.bounds collectionViewLayout:layout];
    
    collectionView.backgroundColor = YKMyCoffeeColor;
    
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.contentInset = UIEdgeInsetsMake(20, 0, 95, 0);
    
    [self.view addSubview:collectionView];
    
    //注册 cell
    [collectionView registerNib:[UINib nibWithNibName:@"YKShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark -------------------
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YKShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    return cell;
}





@end
