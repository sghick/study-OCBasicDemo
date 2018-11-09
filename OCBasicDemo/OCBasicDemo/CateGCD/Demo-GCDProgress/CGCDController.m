//
//  CGCDController.m
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/9/26.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "CGCDController.h"

@interface CGCDController ()

@property (strong, nonatomic) NSMutableArray *array;
@property (strong, atomic) NSMutableArray *arrayAtomic;

@end

@implementation CGCDController

+ (void)load {
    [self loadOptionWithDemoPath:@"CGD.基本的多线程任务"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int idx = 0;
    NSArray<NSString *> *selectors = @[
                                       NSStringFromSelector(@selector(dispatchFunction001)),
                                       NSStringFromSelector(@selector(dispatchFunction002)),
                                       NSStringFromSelector(@selector(dispatchFunction003)),
                                       NSStringFromSelector(@selector(dispatchFunction004)),
                                       NSStringFromSelector(@selector(dispatchFunction005)),
                                       ];
//    for (NSString *selstr in selectors) {
//        NSLog(@"");
//        NSLog(@"============================================");
//        NSLog(@"=    执行方法,开始:%@    =", selstr);
//        SEL sel = NSSelectorFromString(selstr);
//        [self performSelector:sel];
//        NSLog(@"=    执行方法,结束:%@    =", selstr);
//        NSLog(@"============================================");
//        NSLog(@"");
//    }
    
//    NSString *selstr = selectors[idx];
//    NSLog(@"");
//    NSLog(@"============================================");
//    NSLog(@"=    执行方法,开始:%@    =", selstr);
//    SEL sel = NSSelectorFromString(selstr);
//    [self performSelector:sel];
//    idx = (idx + 1)%selectors.count;
    
//    [self dispatchFunction007];
}

- (void)dispatchFunction001 {
    dispatch_queue_t q = dispatch_queue_create("aaaaa", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        dispatch_sync(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread].isMainThread?@"main":@"sub", i);
        });
    }
    [NSThread sleepForTimeInterval:0.0001];
    NSLog(@"bbbbb");
}

- (void)dispatchFunction002 {
    dispatch_queue_t q = dispatch_queue_create("aaaaa", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread].isMainThread?@"main":@"sub", i);
        });
    }
    [NSThread sleepForTimeInterval:0.0001];
    NSLog(@"bbbbb");
}

/// 同步主队列中的任务会等 主线程任务完成之后再执行
- (void)dispatchFunction003 {
    dispatch_queue_t q = dispatch_get_main_queue();
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread].isMainThread?@"main":@"sub", i);
        });
    }
//    [NSThread sleepForTimeInterval:3];
    NSLog(@"bbbbb");
}

- (void)dispatchFunction004 {
    dispatch_semaphore_t sema = dispatch_semaphore_create(3);
    dispatch_queue_t q = dispatch_queue_create("aaaaa", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}


#pragma mark - 正常

- (void)dispatchFunction101 {
    NSLock *lock = [[NSLock alloc] init];
    dispatch_queue_t q = dispatch_queue_create("aaaaa", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<100000; i++) {
        dispatch_async(q, ^{
            [lock lock];
            self.array = [NSMutableArray array];
            NSLog(@"%@ %d", [NSThread currentThread].isMainThread?@"main":@"sub", i);
            [lock unlock];
        });
    }
    [NSThread sleepForTimeInterval:0.0001];
    NSLog(@"bbbbb");
}

- (void)dispatchFunction102 {
    dispatch_queue_t q = dispatch_queue_create("aaaaa", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<100000; i++) {
        dispatch_async(q, ^{
            self.arrayAtomic = [NSMutableArray array];
            NSLog(@"%@ %d", [NSThread currentThread].isMainThread?@"main":@"sub", i);
        });
    }
    [NSThread sleepForTimeInterval:0.0001];
    NSLog(@"bbbbb");
}

#pragma mark - 异常

/// 异常
- (void)dispatchFunction901 {
    dispatch_queue_t q = dispatch_queue_create("aaaaa", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<100000; i++) {
        dispatch_async(q, ^{
            self.array = [NSMutableArray array];
            NSLog(@"%@ %d", [NSThread currentThread].isMainThread?@"main":@"sub", i);
        });
    }
    [NSThread sleepForTimeInterval:0.0001];
    NSLog(@"bbbbb");
}

/// 锁死
- (void)dispatchFunction902 {
    dispatch_queue_t q = dispatch_get_main_queue();
    for (int i = 0; i<10; i++) {
        dispatch_sync(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread].isMainThread?@"main":@"sub", i);
        });
    }
    [NSThread sleepForTimeInterval:3];
    NSLog(@"bbbbb");
}

// 异常
- (void)dispatchFunction903 {
    dispatch_queue_t q = dispatch_queue_create("aaa", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(q, ^{
        NSLog(@"111");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"222");
        });
        NSLog(@"333");
    });
    NSLog(@"444");
}

/// 异常
- (void)dispatchFunction904 {
    dispatch_queue_t q = dispatch_queue_create("aaa", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q, ^{
        NSLog(@"111");
        dispatch_sync(q, ^{
            NSLog(@"222");
        });
        NSLog(@"333");
    });
    NSLog(@"444");
}

/// 异常
- (void)dispatchFunction905 {
    dispatch_queue_t queue = dispatch_queue_create("com.queue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            dispatch_async(queue, ^{
                        NSLog(@"任务0");
                    });
                dispatch_barrier_async(queue, ^{
                        NSLog(@"任务1");
                    });
                dispatch_async(queue, ^{
                        NSLog(@"任务2");
                    });
                NSLog(@"任务3");
            });
        dispatch_async(queue, ^{
                dispatch_barrier_sync(queue, ^{
                        NSLog(@"任务4");
                    });
                dispatch_async(queue, ^{
                        NSLog(@"任务5");
                    });
                NSLog(@"任务6");
            });
}


@end
