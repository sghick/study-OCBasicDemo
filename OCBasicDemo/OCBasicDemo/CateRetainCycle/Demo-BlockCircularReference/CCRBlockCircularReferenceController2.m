//
//  CCRBlockCircularReferenceController2.m
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "CCRBlockCircularReferenceController2.h"

@interface CCRBlockCircularReferenceController2 ()

@end

@implementation CCRBlockCircularReferenceController2

+ (void)load {
    [self loadOptionWithDemoPath:@"RetainCycle.Block循环引用2"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
