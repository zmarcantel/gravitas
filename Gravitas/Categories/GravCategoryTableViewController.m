//
//  GravCategoryTableViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravCategoryTableViewController.h"
#import "../GravAppDelegate.h"
#import "GravCategoryViewCell.h"
#import "GravEditCatgoryViewController.h"

@interface GravCategoryTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation GravCategoryTableViewController

//--------------------------------------------------------------
//
// View Initialization
//
//--------------------------------------------------------------

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
    
    [self updateCategoryList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------
//
// Table View Functions
//
//--------------------------------------------------------------
#pragma mark - Table view data source

//
// Number of sections
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//
// Number of rows in section
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.categories count];
}

//
// Style for cell at row
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    GravCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    GravCategory *category = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = category.name;
    
    return cell;
}

//
// Editing style for row
//
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteCategory:indexPath.row];
        [self updateCategoryList];
    }
}

//
// Set editing style for row
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

//
// Tapped row at index
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//
// Additional edit button pressed
//
- (void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath {
    GravCategory *tappedItem = [self.categories objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"editCategorySegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save category object: %@", [error localizedDescription]);
    }
}

//
// Title for additonal editing button
//
- (NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Rename";
}

//
// BAckground color for additional editing button
- (UIColor *)tableView:(UITableView *)tableView backgroundColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];
}

//--------------------------------------------------------------
//
// View Transition Functions
//
//--------------------------------------------------------------
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender class] == [GravCategoryViewCell class]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        GravEditCatgoryViewController *dest = [segue destinationViewController];
        dest.editingCategory = [self.categories objectAtIndex:indexPath.row];
    }
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    [self updateCategoryList];
}

//--------------------------------------------------------------
//
// Category Database Functions
//
//--------------------------------------------------------------

- (IBAction) deleteCategory:(int)index
{
    [self.managedObjectContext deleteObject:[self.categories objectAtIndex:index]];
    [self updateCategoryList];
}

- (IBAction) updateCategoryList
{
    GravAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.categories = [delegate getAllCategories];
    
    [self.tableView reloadData];
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



@end
