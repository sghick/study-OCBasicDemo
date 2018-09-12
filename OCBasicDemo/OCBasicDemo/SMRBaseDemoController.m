//
//  SMRBaseDemoController.m
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/8/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "SMRBaseDemoController.h"
#import "SMRCateManager.h"

@interface SMRBaseDemoController ()

@end

@implementation SMRBaseDemoController

+ (void)loadOptionWithDemoPath:(NSString *)demoPath {
    [[SMRCateManager shareInstance] addDemoPathName:demoPath vClass:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
