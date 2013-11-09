//
//  GravAddCategoryViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravAddCategoryViewController.h"

@interface GravAddCategoryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation GravAddCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GravAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // additional field border
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              self.titleField.frame.size.height-3,
                                                              self.titleField.frame.size.width,
                                                              1)];
    border.backgroundColor = [UIColor blackColor];
    [self.titleField addSubview:border];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    
    [self addCategory:sender];
}

- (void) addCategory: (id)sender {
    // TODO: add popup/marking for required fields
    
    // title must be given
    if (self.titleField.text.length == 0) { return; }
    
    GravCategory *newCat = [NSEntityDescription insertNewObjectForEntityForName:@"GravCategory"
                                                         inManagedObjectContext:self.managedObjectContext];
    
    newCat.name            = self.titleField.text;
    newCat.createDate      = [NSDate date];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save category object: %@", [error localizedDescription]);
    } else {
        NSLog(@"Saved category:\n%@\n", newCat);
    }
}

@end
