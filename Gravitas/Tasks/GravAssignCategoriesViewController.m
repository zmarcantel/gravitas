//
//  GravAssignCategoriesViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/9/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravAssignCategoriesViewController.h"

#import "../GravAppDelegate.h"

@interface GravAssignCategoriesViewController ()

@end

@implementation GravAssignCategoriesViewController

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
    
    self.categories = [appDelegate getAllCategories];
    self.activeCategories = [self getCategoriesForTask];
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
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AssignCategoryCell";
    GravAssignCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    GravCategory *category = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = category.name;
    
    [cell.toggleActivity addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = cell.toggleActivity;
    
    id isEnabled = [self.activeCategories objectForKey:category.name];
    if (isEnabled != NULL) {
        [cell.toggleActivity setOn:YES];
    } else {
        [cell.toggleActivity setOn:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AssignCategoryCell";
    GravAssignCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.toggleActivity setOn:!cell.toggleActivity.on animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
     
- (void)switchValueChanged:(id)sender
{
    GravAssignCategoryCell *cell = (GravAssignCategoryCell *)[[((UISwitch *)sender) superview] superview];
    if ([self.activeCategories objectForKey:cell.textLabel.text] != nil) {
        [self.activeCategories removeObjectForKey:cell.textLabel.text];
    } else {
        [self.activeCategories setValue:[NSNumber numberWithInt:1] forKey:cell.textLabel.text];
    }
    
    [self setCategoriesForTask:self.activeCategories];
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


-(void)setCategoriesForTask:(NSDictionary *)list
{
    self.currentTask.categories = [NSKeyedArchiver archivedDataWithRootObject:list];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save task object: %@", [error localizedDescription]);
    }
}

-(NSMutableDictionary *) getCategoriesForTask
{
    if (self.currentTask.categories == NULL) {
        return [[NSMutableDictionary alloc] init];
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:self.currentTask.categories];
}

@end
