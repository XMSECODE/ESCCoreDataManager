//
//  Person+CoreDataProperties.h
//  ESCCoreDataManager
//
//  Created by xiang on 27/07/2017.
//  Copyright © 2017 xiang. All rights reserved.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t age;

@end

NS_ASSUME_NONNULL_END
