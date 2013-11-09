//
//  GravTask.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/8/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GravTask : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * targetDate;
@property (nonatomic, retain) NSNumber * complete;
@property (nonatomic, retain) NSDate * completeDate;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) id categories;
@property (nonatomic, retain) NSNumber * peopleWaiting;

@end
