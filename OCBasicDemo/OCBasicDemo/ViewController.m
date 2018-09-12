//
//  ViewController.m
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/8/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "ViewController.h"
#import "SMRCateManager.h"

@interface ViewController () <
UITableViewDelegate >

@property (strong, nonatomic) UIView *curView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
}

- (void)showErrorAlert:(NSString *)message {
    UIAlertController *alert = [[UIAlertController alloc] init];
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionSure];
    [self.navigationController pushViewController:alert animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.curView) {
        [self.curView removeFromSuperview];
    }
}

#pragma mark - UITableViewDataSource


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMRCateItem *item = [[SMRCateManager shareInstance] itemWithIndexPath:indexPath];
    UIViewController *obj = [[[item.vClass class] alloc] init];
    if (!obj) {
        [self showErrorAlert:@"加载错误"];
        return;
    }
    
    if ([obj isKindOfClass:[UIViewController class]]) {
        obj.navigationItem.title = item.itemName;
        [self.navigationController pushViewController:obj animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    if ([obj isKindOfClass:[UIView class]]) {
        self.curView = (UIView *)obj;
        [self.view addSubview:(UIView *)obj];
        return;
    }
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                   [UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = [SMRCateManager shareInstance];
    }
    return _tableView;
}


@end
