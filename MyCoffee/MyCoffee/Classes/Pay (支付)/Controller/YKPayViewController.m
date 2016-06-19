//
//  YKPayViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/18.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKPayViewController.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import "YKScanQRCodeController.h"
#import "YKTouchIDAuthodManager.h"
#import "YKSuccessViewController.h"
#import "NSString+Hash.h"
#import "YKDataManager.h"

@interface YKPayViewController ()
@property (strong, nonatomic) QRCodeReaderViewController *reader;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@end

@implementation YKPayViewController
#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加导航条内容按钮
    [self addBarButtonItem];
    
    self.tableView.sectionHeaderHeight = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    
    //设置价格显示
    [self setuoPriceLabel];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -------------------
#pragma mark 初始化
//设置价格显示
- (void)setuoPriceLabel
{
    NSDate *date = [NSDate date];
    NSString *price = [_totalPrice stringByAppendingString:date.description];
    NSString *hushStr = [price md5String];
    NSString *hushStr2 = [hushStr substringFromIndex:15];
    self.orderCode.text = [NSString stringWithFormat:@"myCoffee订单：%@",hushStr2];
    self.totalPriceLabel1.text = [NSString stringWithFormat:@"￥%@",_totalPrice];
    self.totalPriceLabel2.text = [NSString stringWithFormat:@"￥%@",_totalPrice];
}

#pragma mark -------------------
#pragma mark Events
//添加左边按钮
- (void)addBarButtonItem
{
    //左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"X"] style:UIBarButtonItemStylePlain target:self action: @selector(dismiss)];
    
    //右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bar_2"] style:UIBarButtonItemStylePlain target:self action: @selector(scanQRCode)];
    
    self.navigationItem.title = @"在线支付";
    
}

//点击扫描二维码
- (void)scanQRCode
{
    NSArray *types = @[AVMetadataObjectTypeQRCode];
    _reader        = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
    
    typeof(self) weakSelf = self;
    [_reader setCompletionWithBlock:^(NSString *resultAsString) {
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            if (resultAsString) {
                YKScanQRCodeController *showMessageVc = [[YKScanQRCodeController alloc] init];
                showMessageVc.message = resultAsString;
                [weakSelf.navigationController pushViewController:showMessageVc animated:YES];
            }
            
        }];
    }];
    
    [self presentViewController:_reader animated:YES completion:NULL];
}

#pragma mark -------------------
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    typeof(self)weakSelf = self;
    //弹出指纹认证
    [YKTouchIDAuthodManager authodYourTouchIDCompleted:^{
        [YKDataManager writefile:_data fileName:@"everBuy.JSON"];
        [weakSelf.navigationController pushViewController:[[YKSuccessViewController alloc] init] animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
