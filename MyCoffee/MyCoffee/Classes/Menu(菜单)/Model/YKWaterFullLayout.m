//
//  YKWaterFullLayout.m
//  瀑布流
//
//  Created by yk on 16/4/23.
//  Copyright © 2016年 yk. All rights reserved.
//
/*
 自定义瀑布流的思路
 1.确定宽高
 2.确定列数
 3.x 跟列有关
 4.y 需要判断,当前哪列最矮放哪列
 5.搞一个数组记录当前列的高度,只需要创建一次,懒加载
 6.判断完哪列最矮后记得跟新最新最矮的列数
 */

#import "YKWaterFullLayout.h"

@interface YKWaterFullLayout ()

@property (strong, nonatomic) NSMutableArray *columnsHeight;

@property (nonatomic, strong) NSMutableArray *cellLayouts;

@property (nonatomic, assign) CGFloat maxColumnHeight;

@end

@implementation YKWaterFullLayout


static CGFloat const margin = 5;
static CGFloat const cols = 2;

-(NSMutableArray *)cellLayouts
{
    if (_cellLayouts == nil) {
        _cellLayouts = [NSMutableArray array];
    }
    return _cellLayouts;
}

- (NSMutableArray *)columnsHeight
{
    if (_columnsHeight == nil) {
        _columnsHeight = [NSMutableArray array];
        
        for (int i = 0; i < cols; i++) {
            [_columnsHeight addObject:@(margin)];
        }
        
    }
    return _columnsHeight;
}

-(void)prepareLayout
{
    //清空所有行高
    self.columnsHeight = nil;
    
    //清空所有的布局信息
    [self.cellLayouts removeAllObjects];
    
    //创建布局信息
    [self setUpAllCellLayout];
}

-(void)setUpAllCellLayout
{
    // 获取cell总数
    NSUInteger count = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    CGFloat cellW = (collectionW - (cols + 1) * margin) / cols;
    CGFloat cellH = 0;
    CGFloat cellX = 0;
    CGFloat cellY = 0;
    
    // 计算所有cell布局
    for (int i = 0; i < count; i++) {
        
        cellH = 280 ;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // UICollectionViewLayoutAttributes:不能alloc,init创建
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 遍历列数高度数组，判断最矮的列数
        // 记录最小的列数
        NSInteger minCol = 0;
        
        // 获取第0列比较
        CGFloat minColumnH = [self.columnsHeight[0] floatValue];
        
        for (int i = 1; i < self.columnsHeight.count; i++) {
            CGFloat curColH = [self.columnsHeight[i] floatValue];
            if (curColH < minColumnH) {
                // 有最矮的
                minColumnH = curColH;
                minCol = i;
            }
        }
        
        cellX = margin + minCol * (margin + cellW);
        cellY = minColumnH + margin;
        
        // 更新最小列行高
        
        // 计算尺寸
        attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
        
        //假设添加 cell 后为最高列
        CGFloat newHeight = cellY + cellH;
        self.columnsHeight[minCol] = @(newHeight);
        
        if (newHeight > self.maxColumnHeight) {
            self.maxColumnHeight = newHeight;
        }
        
        [self.cellLayouts addObject:attrs];
    
    }
}

// 返回指定区域内容cell的布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.cellLayouts;
}

- (CGSize)collectionViewContentSize
{
    // collectionViewContentSize
    return CGSizeMake(self.collectionView.bounds.size.width, self.maxColumnHeight);
}

@end
