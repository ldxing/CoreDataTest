//
//  Person+CoreDataProperties.h
//  CoreDataTest
//
//  Created by dx l on 2017/10/30.
//  Copyright © 2017年 dx l. All rights reserved.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
