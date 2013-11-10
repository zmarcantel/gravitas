//
//  GravAssignCategoriesViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/9/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../Data/GravTask.h"
#import "../Data/GravCategory.h"

#import "GravAssignCategoryCell.h"

@interface GravAssignCategoriesViewController : UITableViewController

@property NSArray *categories;
@property GravTask *currentTask;
@property NSMutableDictionary *activeCategories;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
