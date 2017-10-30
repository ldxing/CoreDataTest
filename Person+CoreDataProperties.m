//
//  Person+CoreDataProperties.m
//  CoreDataTest
//
//  Created by dx l on 2017/10/30.
//  Copyright © 2017年 dx l. All rights reserved.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic name;

@end
