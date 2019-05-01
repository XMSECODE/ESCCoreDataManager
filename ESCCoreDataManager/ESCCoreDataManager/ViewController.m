//
//  ViewController.m
//  ESCCoreDataManager
//
//  Created by xiang on 27/07/2017.
//  Copyright © 2017 xiang. All rights reserved.
//

#import "ViewController.h"
#import "ESCCoreDataManager.h"
#import "Person+CoreDataClass.h"

@interface ViewController ()

@property (nonatomic, strong) ESCCoreDataManager *coreDataManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());

    [self createDataTable];
    
    [self insertData];
    
    [self fetchData];
    
    [self modifyData];
   
    [self deleteData];
    

}

- (void)createDataTable {
    
    self.coreDataManager = [[ESCCoreDataManager alloc] init];
    
    self.coreDataManager.directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.coreDataManager.fileName = @"user.sqlite";
    self.coreDataManager.resourceName = @"Person";

}

- (void)insertData {
    for (int i = 0; i < 100; i++) {
        Person *person1 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.coreDataManager.managedObjectContext];
        person1.name = [NSString stringWithFormat:@"person%d",i];
        person1.age = i;
    }
    
    NSError *error;
    [self.coreDataManager.managedObjectContext save:&error];
    if (error) {
        NSLog(@"save error = %@",error);
    }else {
        NSLog(@"success");
    }
}


- (void)fetchData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSSortDescriptor *sortDescripto = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescripto]];
    NSString *string = [NSString stringWithFormat:@"age = 3"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:string];
    NSError *error = nil;
    NSArray *resultArray = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (Person *person in resultArray) {
        NSLog(@"person name:%@ age:%lld",person.name,person.age);
    }
}

- (void)deleteData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSSortDescriptor *sortDescripto = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescripto]];
    
    NSError *error = nil;
    NSArray *resultArray = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (Person *person in resultArray) {
        [self.coreDataManager.managedObjectContext deleteObject:person];
    }
    [self.coreDataManager.managedObjectContext save:&error];
    if (error) {
        NSLog(@"save error = %@",error);
    }else {
        NSLog(@"success");
    }
}

- (void)modifyData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSSortDescriptor *sortDescripto = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescripto]];
    
    NSError *error = nil;
    NSArray *resultArray = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (Person *person in resultArray) {
        person.age = 222;
    }
    [self.coreDataManager.managedObjectContext save:&error];
    if (error) {
        NSLog(@"save error = %@",error);
    }else {
        NSLog(@"success");
    }
}


@end
