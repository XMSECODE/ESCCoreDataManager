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
    
    self.coreDataManager = [[ESCCoreDataManager alloc] init];
    
    self.coreDataManager.directoryPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    self.coreDataManager.fileName = @"person.sqlite";
    self.coreDataManager.resourceName = @"Person";

    
    for (int i = 0; i < 22222; i++) {
        Person *person1 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.coreDataManager.managedObjectContext];
        person1.name = [NSString stringWithFormat:@"person%zd",i];
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





@end
