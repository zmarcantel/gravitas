//
//  GravEditTaskViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/9/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravEditTaskViewController.h"

@interface GravEditTaskViewController ()
@property (weak, nonatomic) IBOutlet GravTextField *titleField;
@property (weak, nonatomic) IBOutlet GravTextField *dueDateField;
@property (weak, nonatomic) IBOutlet GravTextField *waitingField;
@property (weak, nonatomic) IBOutlet UITextView *additionalField;
@property (weak, nonatomic) IBOutlet UIButton *gotoAssignButton;

@end

@implementation GravEditTaskViewController

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
    
    UIDatePicker *dueDatePicker = [[UIDatePicker alloc]init];
    [dueDatePicker setDate:self.editingTask.targetDate];
    [dueDatePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [dueDatePicker setMinimumDate:[NSDate date]];
    [self.dueDateField setInputView:dueDatePicker];
    [self.dueDateField setInputAccessoryView:[self datePickerToolbar]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy '@' hh:mm a z"];
    
    self.titleField.text = self.editingTask.name;
    self.dueDateField.text = [dateFormatter stringFromDate:self.editingTask.targetDate];
    self.waitingField.text = [self.editingTask.peopleWaiting stringValue];
    self.additionalField.text = self.editingTask.details;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) unwindEditView:(UIStoryboardSegue *)segue
{
    // do something before segue
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dueDateField.inputView;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy '@' hh:mm a"];
    self.dueDateField.text = [dateFormatter stringFromDate:picker.date];
}

- (void) donePicking
{
    [self.dueDateField endEditing:YES];
}

- (UIToolbar *) datePickerToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    toolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *toolbarSpacer = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *toolbarDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleDone
                                                                         target:self
                                                                         action:@selector(donePicking)];
    [toolbar setItems:[[NSArray alloc] initWithObjects:toolbarSpacer, toolbarDoneButton, nil]];
    
    return toolbar;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender == self.gotoAssignButton) {
        GravAssignCategoriesViewController *assign = [segue destinationViewController];
        assign.currentTask = self.editingTask;
    } else {
        self.editingTask.name            = self.titleField.text;
        self.editingTask.peopleWaiting   = [[NSNumber alloc] initWithInt:[self.waitingField.text integerValue]];
        self.editingTask.details         = self.additionalField.text;
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy '@' hh:mm a"];
        self.editingTask.targetDate      = ((UIDatePicker *)self.dueDateField.inputView).date;
    
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Failed to save task object: %@", [error localizedDescription]);
        }
    }
}

@end
