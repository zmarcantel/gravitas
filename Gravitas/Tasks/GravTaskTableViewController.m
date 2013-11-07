//
//  GravTaskTableViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravTaskTableViewController.h"
#import "../GravAppDelegate.h"

@interface GravTaskTableViewController ()

@property (nonatomic,strong)NSArray *savedTasks;

@property NSNumber *TASK_COMPLETE;
@property NSNumber *TASK_INCOMPLETE;

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

    [self updateTaskList:nil];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Task *task = [self.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.name;
    
    if (task.completed == self.TASK_COMPLETE) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *tappedItem = [self.tasks objectAtIndex:indexPath.row];
    
    if (tappedItem.completed == self.TASK_COMPLETE) { tappedItem.completed = self.TASK_INCOMPLETE; }
    else { tappedItem.completed = self.TASK_COMPLETE; }
 
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save task object: %@", [error localizedDescription]);
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleNone) {
        //add code here for when you hit delete
    }
}

- (IBAction) unwindToList:(UIStoryboardSegue *)segue
{
    [self updateTaskList:nil];
}

- (IBAction) updateTaskList:(id)sender
{
    GravAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.tasks = [delegate getAllTasks];
    
    [self.tableView reloadData];
}

- (IBAction) deleteTask:(int)index
{
    [self.managedObjectContext deleteObject:[self.tasks objectAtIndex:index]];
    [self updateTaskList:nil];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
