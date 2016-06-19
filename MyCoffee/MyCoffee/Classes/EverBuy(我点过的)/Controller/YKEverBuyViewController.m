//
//  YKEverBuyViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/3.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKEverBuyViewController.h"
#import "YKDrinkItem.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "YKEverBuyCell.h"

static NSString * const ID = @"cell";
@interface YKEverBuyViewController ()

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
    
    //字典转模型
    if ([self getData]) {
        
        self.itemArr = [YKDrinkItem mj_objectArrayWithKeyValuesArray:[self getData]];
    } else
    {
        [SVProgressHUD showInfoWithStatus:@"暂无消费记录哦☺\n 赶紧去下单吧！"];
    }
}

//提取数据
- (NSArray *)getData
{
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = [homePath stringByAppendingPathComponent:@"everBuy.JSON"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        return dict[@"everBuy"];
    }
    return nil;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itemArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKEverBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = YKBgColor;
    
    YKDrinkItem *item = self.itemArr[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

@end
