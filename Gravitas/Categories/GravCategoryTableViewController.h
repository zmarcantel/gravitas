//
//  GravCategoryTableViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Data/GravCategory.h"

@interface GravCategoryTableViewController : UITableViewController

@property NSArray *categories;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
