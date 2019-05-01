//
//  ESCCoreDataManager.h
//  ESCCoreDataManager
//
//  Created by xiang on 27/07/2017.
//  Copyright © 2017 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface ESCCoreDataManager : NSObject

@property(nonatomic,strong,readonly)NSManagedObjectContext* managedObjectContext;

@property (nonatomic, copy) NSString *directoryPath;

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, copy) NSString *resourceName;

@end
