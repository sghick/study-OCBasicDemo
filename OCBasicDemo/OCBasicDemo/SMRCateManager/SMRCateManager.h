//
//  SMRCateManager.h
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/8/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMRCateItem : NSObject

@property (strong, nonatomic) NSString *groupName;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) id vClass;

@end

@interface SMRCateManager : NSObject<
UITableViewDataSource>

+ (SMRCateManager *)shareInstance;

- (void)addDemoPathName:(NSString *)demoPathName vClass:(Class)vClass;

- (SMRCateItem *)itemWithIndexPath:(NSIndexPath *)indexPath;
- (NSArray<SMRCateItem *> *)itemsWithIndexPathSection:(NSInteger)indexPathSection;

@end
