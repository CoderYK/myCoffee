//
//  YKRecordView.m
//  MyCoffee
//
//  Created by yk on 16/5/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKRecordView.h"
#import "YKHeaderView.h"
#import "YKLocationCell.h"
static NSString * const ID = @"cell";
@interface YKRecordView ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YKRecordView

- (void)awakeFromNib
{
    self.tableView.tableHeaderView = [YKHeaderView headerView];
    self.tableView.separatorColor = YKMyCoffeeColor;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YKLocationCell" bundle:nil] forCellReuseIdentifier:ID];
}

+ (instancetype)recordView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

#pragma mark -------------------
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
