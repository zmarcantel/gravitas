//
//  GravAddTaskViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravAddTaskViewController.h"

@interface GravAddTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

//---------------------------------------
// Implementation
//---------------------------------------

@implementation GravAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	GravAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    
    [self addTask:sender];
}

- (void) addTask: (id)sender {
    Task *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
                                                  inManagedObjectContext:self.managedObjectContext];
    
    newTask.name            = self.titleField.text;
    newTask.category        = self.task.category;
    newTask.dueDate         = self.task.dueDate;
    newTask.completeDate    = self.task.completeDate;
    newTask.completed       = NO;
    //    newTask.subtasks        = nil; // = [[NSMutableArray alloc] init];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save task object: %@", [error localizedDescription]);
    }
}

@end
