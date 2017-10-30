//
//  ViewController.m
//  CoreDataTest
//
//  Created by dx l on 2017/10/27.
//  Copyright © 2017年 dx l. All rights reserved.
//

#import "ViewController.h"
#import "CoreDatacoreData.h"
#import "Person+CoreDataClass.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTf;

@property (weak, nonatomic) IBOutlet UITextField *agetf;

@property (nonatomic, strong) NSMutableArray *mutableArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)add:(id)sender {
    if (![_nameTf.text isEqualToString:@""] && ![_agetf.text isEqualToString:@""]) {
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:[CoreDatacoreData sharedCoreDatacoreData].managedObjectContext];
        person.name = _nameTf.text;
        person.age = _agetf.text.integerValue;
        
        
        NSError *error;
        [[CoreDatacoreData sharedCoreDatacoreData].managedObjectContext  save:&error];
        if (!error) {
            NSLog(@"save:name--%@,age---%@",_nameTf.text,_agetf.text);
        } else {
            NSLog(@"%@",error);
        }
    }
}

- (IBAction)delete:(id)sender {
    
    [self search:nil];
    
    for (Person *per in _mutableArr) {
        if (per.age == _agetf.text.integerValue) {
            [[CoreDatacoreData sharedCoreDatacoreData].managedObjectContext deleteObject:per];
        }
    }
    //更新提交 改变
    [[CoreDatacoreData sharedCoreDatacoreData].managedObjectContext save:nil];
    
}

- (IBAction)search:(id)sender {

    
    NSLog(@"====search====\n");
    
    NSFetchRequest *fetchRequest = [Person fetchRequest];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"age > %@",@0]];
    
    NSArray<NSSortDescriptor *> *sortDescriptor = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    fetchRequest.sortDescriptors = sortDescriptor;
    
    NSArray<Person *> *persons = [[CoreDatacoreData sharedCoreDatacoreData].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    for (Person *per in persons) {
        NSLog(@"%@----%hd",per.name,per.age);
    }
    
    [self.mutableArr removeAllObjects];
    [_mutableArr addObjectsFromArray:persons];
    
    NSLog(@"====search====");
}

- (IBAction)update:(id)sender {
    
}


- (NSMutableArray *)mutableArr {
    if (!_mutableArr) {
        _mutableArr = [NSMutableArray array];
    }
    return _mutableArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
