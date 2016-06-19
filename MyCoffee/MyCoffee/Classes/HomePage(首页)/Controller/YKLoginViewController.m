//
//  YKLoginViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/3.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKLoginViewController.h"
#import "YKMainViewController.h"
#import "YKAboutUsController.h"
#import "YKNavigationController.h"
#import "YKTopLoginView.h"
#import "YKFileManager.h"
#import "YKMyResumeViewController.h"

#define YKCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface YKLoginViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation YKLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
    
    YKTopLoginView *loginView = [YKTopLoginView topLoginView];
    loginView.frame = CGRectMake(0, (self.view.frame.size.height - 54 * 8) / 2.0f, 181, 58);
    [self.view addSubview:loginView];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(home) name:@"home" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self home];
            break;
        case 1:
            //跳转到关于我们控制器
            [self.sideMenuViewController setContentViewController:[[YKNavigationController alloc] initWithRootViewController:[[YKAboutUsController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            //清理缓存
            [YKFileManager removeItemOfDirectory:YKCachePath];
            [self.tableView reloadData];
            break;
        case 3:
            //跳转到个人详情控制器
            [self.sideMenuViewController setContentViewController:[[YKNavigationController alloc] initWithRootViewController:[[YKMyResumeViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

- (void)home{
    [self.sideMenuViewController setContentViewController:[[YKNavigationController alloc] initWithRootViewController:[[YKMainViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = YKMyCoffeeColor;
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"Home", @"关于我们", [self sizeString], @"开发团队", @"消费记录"];
    NSArray *images = @[@"IconHome", @"slider_1", @"slider_2", @"slider_3", @"slider_4"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.tintColor = YKMyCoffeeColor;
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (NSString *)sizeString
{
    //获取缓存文件夹的路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    //获取缓存尺寸
//        NSInteger size = 250;
    NSInteger size = [YKFileManager getSizeOfDirectory:cachePath];
    
    //拼接字符串
    NSString *sizeStr = @"清理缓存";
    //MB KB B
    if (size > 1000.0 * 1000.0 ) {
        CGFloat sizeMB = size / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeMB];
    }else if (size > 1000) { // kB
        CGFloat sizeKB = size / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeKB];
    } else if (size > 0) { // B
        sizeStr = [NSString stringWithFormat:@"%@(%ldB)",sizeStr,size];
    }
    
    return sizeStr;
}


@end
