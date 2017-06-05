//
//  DepartmentCell.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "DepartmentCell.h"

@interface DepartmentCell ()

@property (strong, nonatomic) UIView* dividerLineView;

@end

@implementation DepartmentCell

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
    self.nameLabel.text = @"IT Office";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16];
    self.nameLabel.textColor = [UIColor whiteColor];
    
    self.dividerLineView = [[UIView alloc]  initWithFrame:CGRectZero];
    self.dividerLineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    [self setupConstraint];
}

- (void) setupConstraint {
    [self addSubview:self.nameLabel];
    [self addSubview:self.dividerLineView];
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.nameLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
    [self.nameLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
    [self.nameLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
    
    self.dividerLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dividerLineView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:15].active = YES;
    [self.dividerLineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
    [self.dividerLineView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-15].active = YES;
    [self.dividerLineView.heightAnchor constraintEqualToConstant:1].active = YES;
}


@end











