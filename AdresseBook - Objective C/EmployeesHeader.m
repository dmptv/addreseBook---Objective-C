//
//  EmployeesHeader.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 06/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "EmployeesHeader.h"
#import "Utils.h"

@implementation EmployeesHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
        
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    
    self.dividerLineView = [[UIView alloc] initWithFrame:CGRectZero];
    self.dividerLineView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    
    [self addSubview:self.nameLabel];
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.nameLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:12].active = YES;
    [self.nameLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
    [self.nameLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
    
    [self addSubview:self.dividerLineView];
    
    self.dividerLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dividerLineView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;;
    [self.dividerLineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
    [self.dividerLineView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
    [self.dividerLineView.heightAnchor constraintEqualToConstant:1].active = YES;
}

@end





