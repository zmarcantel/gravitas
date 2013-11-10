//
//  GravTaskTableViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravTaskTableViewController.h"
#import "../GravAppDelegate.h"
#import "GravTableViewCell.h"
#import "GravEditTaskViewController.h"

@interface GravTaskTableViewController ()

@property (nonatomic,strong)NSArray *savedTasks;

@property NSNumber *TASK_COMPLETE;
@property NSNumber *TASK_INCOMPLETE;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation GravTaskTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    self.TASK_COMPLETE = [[NSNumber alloc] initWithInt: 1];
    self.TASK_INCOMPLETE = [[NSNumber alloc] initWithInt: 0];

    [self updateTaskList];
    
//    [self setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    GravTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    GravTask *task = [self.tasks objectAtIndex:indexPath.row];
    cell.titleField.text = task.name;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy '@' hh:mm a z"];
    if (task.completeDate != nil) {
        cell.dueDateField.text = [@"Completed: " stringByAppendingString:[dateFormatter stringFromDate:task.completeDate]];
    } else {
        cell.dueDateField.text = [dateFormatter stringFromDate:task.targetDate];
    }
    
    if (task.complete == self.TASK_COMPLETE) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteTask:indexPath.row];
        [self updateTaskList];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTask = [self.tasks objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath {
    GravTask *tappedItem = [self.tasks objectAtIndex:indexPath.row];
    
    if (tappedItem.complete == self.TASK_COMPLETE) {
        tappedItem.complete = self.TASK_INCOMPLETE;
        tappedItem.completeDate = nil;
    } else {
        tappedItem.complete = self.TASK_COMPLETE;
        tappedItem.completeDate = [NSDate date];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save task object: %@", [error localizedDescription]);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Complete";
}

- (UIColor *)tableView:(UITableView *)tableView backgroundColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f];
}
 
- (IBAction) unwindToList:(UIStoryboardSegue *)segue
{
    [self updateTaskList];
}

- (IBAction) updateTaskList
{
    GravAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.tasks = [delegate getAllTasks];
    
    [self.tableView reloadData];
}

- (IBAction) deleteTask:(int)index
{
    [self.managedObjectContext deleteObject:[self.tasks objectAtIndex:index]];
    [self updateTaskList];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.addButton) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        GravEditTaskViewController *dest = [segue destinationViewController];
        dest.editingTask = [self.tasks objectAtIndex:indexPath.row];
    }
}


@end
