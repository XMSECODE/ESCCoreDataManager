//
//  Person+CoreDataProperties.m
//  ESCCoreDataManager
//
//  Created by xiang on 27/07/2017.
//  Copyright © 2017 xiang. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic name;
@dynamic age;

@end
