//
//  CMCopyDeepController.m
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/11/9.
//  Copyright © 2018 tinswin. All rights reserved.
//

#import "CMCopyDeepController.h"

@interface CMCopyDeepController ()

@property (copy  , nonatomic) NSString *str1;
@property (strong, nonatomic) NSString *str2;

@property (strong, nonatomic) NSArray *arr1;
@property (strong, nonatomic) NSArray *arr2;
@property (strong, nonatomic) NSArray *arr3;

@end

@implementation CMCopyDeepController

+ (void)load {
    [self loadOptionWithDemoPath:@"Memery.copy/deepcopy"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testString];
}

- (void)testString {
    NSMutableString *string = [NSMutableString stringWithFormat:@"123"];
    self.str1 = string;
    self.str2 = string;
    [string appendString:@"456"];
    NSLog(@"str1:%@", self.str1);
    NSLog(@"str2:%@", self.str2);
    
    NSLog(@"str1:%@", self.str1);
    NSLog(@"str2:%@", self.str2);
}

- (void)testArray {
    CAAnimation *obj1 = [[CAAnimation alloc] init];
    CAAnimation *obj2 = [[CAAnimation alloc] init];
    NSArray *arr = @[obj1, obj2];
    self.arr1 = [arr copy];
    self.arr2 = [[NSArray alloc] initWithArray:arr copyItems:YES];
    self.arr3 = [arr mutableCopy];
    NSLog(@"arr1:%@", self.arr1);
    NSLog(@"arr2:%@", self.arr2);
    NSLog(@"arr3:%@", self.arr3);
}

@end
