//
//  GravAddCategoryViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../GravAppDelegate.h"
#import "../Data/GravCategory.h"

@interface GravAddCategoryViewController : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
