//
//  SMRCateManager.m
//  OCBasicDemo
//
//  Created by 丁治文 on 2018/8/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "SMRCateManager.h"

@implementation SMRCateItem

- (NSString *)description {
    return [NSString stringWithFormat:@"%@.%@.%@", _groupName, _itemName, NSStringFromClass(_vClass)];
}

@end

@interface SMRCateManager ()

@property (strong, nonatomic) NSMutableDictionary<NSString *, NSMutableArray *> *cateList;

@end

@implementation SMRCateManager

+ (SMRCateManager *)shareInstance {
    static SMRCateManager *_smrCateManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _smrCateManagerInstance = [[SMRCateManager alloc] init];
    });
    return _smrCateManagerInstance;
}

- (void)addDemoPathName:(NSString *)demoPathName vClass:(__unsafe_unretained Class)vClass {
    NSArray *sr = [demoPathName componentsSeparatedByString:@"."];
    SMRCateItem *item = [[SMRCateItem alloc] init];
    item.groupName = sr.firstObject;
    item.itemName = sr.lastObject;
    item.vClass = vClass;
    
    NSMutableArray *arr = self.cateList[item.groupName];
    if (!arr) {
        arr = [NSMutableArray array];
        [arr addObject:item];
        self.cateList[item.groupName] = arr;
    } else {
        [arr addObject:item];
    }
}

- (NSMutableDictionary *)cateList {
    if (_cateList == nil) {
        _cateList = [NSMutableDictionary dictionary];
    }
    return _cateList;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cateList.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<SMRCateItem *> *rows = [self itemsWithIndexPathSection:section];
    return rows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.cateList.allKeys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifierOfContentCateItem"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifierOfContentCateItem"];
    }
    SMRCateItem *item = [self itemWithIndexPath:indexPath];
    cell.textLabel.text = item.itemName;
    cell.detailTextLabel.text = NSStringFromClass(item.vClass);
    return cell;
}

#pragma mark - Publics

- (SMRCateItem *)itemWithIndexPath:(NSIndexPath *)indexPath {
    return self.cateList.allValues[indexPath.section][indexPath.row];
}

- (NSArray<SMRCateItem *> *)itemsWithIndexPathSection:(NSInteger)indexPathSection {
    return [self.cateList.allValues[indexPathSection] copy];
}

@end
