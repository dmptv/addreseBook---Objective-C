//
//  OfficeCell.h
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Office : NSObject

@property (strong, nonatomic) NSString* ID;
@property (strong, nonatomic) NSString* Name;
@property (strong, nonatomic) NSMutableArray* Employees;
@property (strong, nonatomic) NSMutableArray* Departments;

@end
