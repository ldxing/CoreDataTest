//
//  CoreData.h
//  CoreDataTest
//
//  Created by dx l on 2017/10/30.
//  Copyright © 2017年 dx l. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDatacoreData : NSObject

+ (instancetype)sharedCoreDatacoreData ;

///上下文
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

///对象模型
@property (nonatomic, strong) NSManagedObjectModel *managedObject;

///调度器
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@end
