//
//  GravAddTaskViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravAddTaskViewController.h"

@interface GravAddTaskViewController ()

@property (weak, nonatomic) IBOutlet GravTextField *titleField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet GravTextField *dueDateTextField;
@property (weak, nonatomic) IBOutlet GravTextField *waitingField;
@property (weak, nonatomic) IBOutlet UITextView *additionalField;

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
    
    UIDatePicker *dueDatePicker = [[UIDatePicker alloc]init];
    [dueDatePicker setDate:[NSDate date]];
    [dueDatePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [dueDatePicker setMinimumDate:[NSDate date]];
    [self.dueDateTextField setInputView:dueDatePicker];
    [self.dueDateTextField setInputAccessoryView:[self datePickerToolbar]];
    
    
    // additional field border
    UIView *additionalBorder = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                     self.additionalField.frame.size.height-3,
                                                                     self.additionalField.frame.size.width,
                                                                     1)];
    additionalBorder.backgroundColor = [UIColor blackColor];
    [self.additionalField addSubview:additionalBorder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dueDateTextField.inputView;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy '@' hh:mm a"];
    self.dueDateTextField.text = [dateFormatter stringFromDate:picker.date];
}

- (void) donePicking
{
    [self.dueDateTextField endEditing:YES];
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
    if (sender != self.doneButton) return;
    
    [self addTask:sender];
}

- (void) addTask: (id)sender {
    // TODO: add popup/marking for required fields
    
    // title must be given
    if (self.titleField.text.length == 0) { return; }
    // date must be given
    if (self.dueDateTextField.text.length == 0) { return; }
    
    GravTask *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"GravTask"
                                                  inManagedObjectContext:self.managedObjectContext];
    
    newTask.name            = self.titleField.text;
    newTask.createDate      = [NSDate date];
    newTask.complete        = NO;
    newTask.peopleWaiting   = [[NSNumber alloc] initWithInt:[self.waitingField.text integerValue]];
    newTask.details         = self.additionalField.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy '@' hh:mm a"];
    newTask.targetDate      = [dateFormatter dateFromString:self.dueDateTextField.text];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save task object: %@", [error localizedDescription]);
    }
}

@end
