//
//  GravCategory.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/8/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GravCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * createDate;

@end
