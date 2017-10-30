//
//  CoreData.m
//  CoreDataTest
//
//  Created by dx l on 2017/10/30.
//  Copyright © 2017年 dx l. All rights reserved.
//

#import "CoreDatacoreData.h"

@implementation CoreDatacoreData

+ (instancetype)sharedCoreDatacoreData {
    static CoreDatacoreData *coreData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreData = [[CoreDatacoreData alloc] init];
    });
    return coreData;
}

/*
 表结构：NSEntityDescription
 表记录：NSManagedObject
 数据库存放方式：NSPersistentStoreCoordinator(持久化存储协调者)
 数据库操作：NSManagedObjectContext(被管理的对象上下文)
 */

- (void)saveContext {
    
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        //实例化
        //ConcurrencyType:并发(性)
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:(NSMainQueueConcurrencyType)];
        
        //指定上下文所属的 存储调度器
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObject
{
    if (!_managedObject) {
        //获取模型描述文件URL, .xcdatamodeld文件编译后在bundle里生成.momd文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _managedObject = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    return _managedObject;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
        //实例化 - 指定管理对象模型
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObject];
        //添加存储器
        //Type:存储类型, 数据库/XML/二进制/内存
        //configuration:不需要额外配置,可以为nil
        //URL:数据保存的文件的URL 这里我们放到documents里
        //options:可以为空
        NSURL *fileUrl = [[self documentDirectoryURL] URLByAppendingPathComponent:@"CoreDataDemo.sqlite"];
        
        NSError *error = nil;
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileUrl options:nil error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        
    }
    return _persistentStoreCoordinator;
}

// 用来获取 document 目录
- (nullable NSURL *)documentDirectoryURL {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}


@end
