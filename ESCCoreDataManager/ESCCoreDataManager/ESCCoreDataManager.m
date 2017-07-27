//
//  ESCCoreDataManager.m
//  ESCCoreDataManager
//
//  Created by xiang on 27/07/2017.
//  Copyright © 2017 xiang. All rights reserved.
//

#import "ESCCoreDataManager.h"
#import <CoreData/CoreData.h>

@interface ESCCoreDataManager ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation ESCCoreDataManager


#pragma mark - Private
- (void)checkFilePath {
    BOOL isExecutable = [[NSFileManager defaultManager] isExecutableFileAtPath:self.directoryPath];
    if (isExecutable == NO) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:self.directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"create directory error = %@",error);
        }
    }
}

#pragma mark - setter & getter
- (void)setDirectoryPath:(NSString *)directoryPath {
    _directoryPath = [directoryPath copy];
    [self checkFilePath];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext == nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:self.resourceName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self filePathUrl] options:nil error:nil];
        
    }
    return _persistentStoreCoordinator;
}

- (NSURL *)filePathUrl {
    NSString *filePath = [NSString stringWithFormat:@"file://%@/%@",self.directoryPath,self.fileName];
    NSURL *url = [NSURL URLWithString:filePath];
    return url;
}

@end
