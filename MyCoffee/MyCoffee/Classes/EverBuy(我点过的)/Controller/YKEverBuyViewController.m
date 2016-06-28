//
//  YKEverBuyViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/3.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKEverBuyViewController.h"
#import "YKShopItem.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "YKEverBuyCell.h"
#import "YKDataManager.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"

static NSString * const ID = @"cell";
@interface YKEverBuyViewController ()<UMSocialUIDelegate>

@property (strong, nonatomic) NSMutableArray *itemArr;

@end

@implementation YKEverBuyViewController

- (NSMutableArray *)itemArr
{
    if (_itemArr == nil) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tableView.backgroundColor = YKMyCoffeeColor;
    self.title = @"消费记录";
    
    //注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:@"YKEverBuyCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.itemArr = [YKShopItem mj_objectArrayWithKeyValuesArray:[[YKDataManager shareYKDataManager] queryAll]];
    
    
    if (self.itemArr.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"暂无消费记录哦☺\n 赶紧去下单吧！"];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itemArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKEverBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = YKBgColor;
    
    YKShopItem *item = self.itemArr[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


#pragma mark - Table view delegate
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    typeof(self)weakSelf = self;
    UITableViewRowAction *share = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"分享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        YKShopItem *item = self.itemArr[indexPath.row];
        
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:item.logo_pic];
        [UMSocialData defaultData].extConfig.title = @"你的好友远坤请你一起来喝咖啡!";
        
        UIImage *shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"xingxing" ofType:@"png"]];
    
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"576fedcbe0f55a0de000572a"
                                          shareText:@"来自 coderYK 的 myCoffee 分享.http://www.umeng.com/social"
                                         shareImage:shareImage
                                    shareToSnsNames:nil
                                           delegate:weakSelf];
        
    }];
    
    share.backgroundColor = [UIColor orangeColor];
    
    UITableViewRowAction *delect = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        YKShopItem *item = self.itemArr[indexPath.row];
        
        [[YKDataManager shareYKDataManager] delectData:item.buyTime];
        
        [self.itemArr removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
    }];
    
    
    return @[delect, share];
}


@end
