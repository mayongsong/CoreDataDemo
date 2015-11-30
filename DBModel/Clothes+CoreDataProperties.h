//
//  Clothes+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by mys on 15/11/23.
//  Copyright © 2015年 mys. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Clothes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Clothes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
