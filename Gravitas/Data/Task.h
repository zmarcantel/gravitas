//
//  Task.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSDate * completeDate;
@property (nonatomic, retain) NSNumber * peopleWaiting;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * createDate;

@end
