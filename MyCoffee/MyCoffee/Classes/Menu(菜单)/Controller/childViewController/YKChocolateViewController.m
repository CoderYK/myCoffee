//
//  YKChocolateViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/14.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKChocolateViewController.h"
#import "YKShopCell.h"
#import "YKDrinkItem.h"
#import <MJExtension/MJExtension.h>

static NSString * const ID = @"cell";
@interface YKChocolateViewController ()

@property (strong, nonatomic) NSMutableArray *list;

@end

@implementation YKChocolateViewController

- (NSMutableArray *)list
{
    if (_list == nil) {
        _list = [NSMutableArray array];
        _list = [YKDrinkItem mj_objectArrayWithFilename:@"chocl.plist"];
    }
    return _list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -------------------
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YKShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.list[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
