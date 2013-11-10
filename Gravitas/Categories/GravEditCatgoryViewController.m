//
//  GravEditCatgoryViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/9/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravEditCatgoryViewController.h"

@interface GravEditCatgoryViewController ()

@property (weak, nonatomic) IBOutlet GravTextField *titleField;

@end

@implementation GravEditCatgoryViewController

//--------------------------------------------------------------
//
// View Initialization
//
//--------------------------------------------------------------

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

    self.titleField.text = self.editingCategory.name;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.titleField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------
//
// View Transition Functions
//
//--------------------------------------------------------------


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.editingCategory.name            = self.titleField.text;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save task object: %@", [error localizedDescription]);
    }
}

@end
