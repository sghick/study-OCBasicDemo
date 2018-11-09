//
//  CCRBlockCircularReferenceController.m
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "CCRBlockCircularReferenceController.h"

typedef void(^Animblock)(void);

@interface CCRBlockCircularReferenceController ()

@property (strong, nonatomic) UIView *runView;
@property (strong, nonatomic) UIView *runView2;
@property (copy , nonatomic) Animblock animBlock;

@end

@implementation CCRBlockCircularReferenceController

+ (void)load {
    [self loadOptionWithDemoPath:@"RetainCycle.Block循环引用1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.runView];
    [self.view addSubview:self.runView2];
    
    self.runView.frame = CGRectMake(100, 100, 100, 100);
    [UIView animateWithDuration:1.5 delay:0 options:0 animations:^{
        self.runView.frame = CGRectMake(100, 300, 100, 100);
    } completion:^(BOOL finished) {
        self.runView = nil;
    }];
    
    self.animBlock = ^{
        self.runView2.frame = CGRectMake(100, 500, 100, 100);
    };
    self.animBlock();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"self.runView:<%@,%p>", _runView, _runView);
    NSLog(@"self.runView2:<%@,%p>", _runView2, _runView2);
}

- (UIView *)runView {
    if (!_runView) {
        _runView = [[UIView alloc] init];
        _runView.backgroundColor = [UIColor blueColor];
    }
    return _runView;
}

- (UIView *)runView2 {
    if (!_runView2) {
        _runView2 = [[UIView alloc] init];
        _runView2.backgroundColor = [UIColor yellowColor];
    }
    return _runView2;
}

@end
