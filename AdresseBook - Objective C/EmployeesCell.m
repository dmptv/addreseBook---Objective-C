//
//  EmployeesCell.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 06/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "EmployeesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Utils.h"
#import "LoginPassword.h"

@interface EmployeesCell ()

@property (strong, nonatomic) UIImageView* profileImageView;
@property (strong, nonatomic) UILabel* nameLabel;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIView* dividerLineView;
@property (strong, nonatomic) NSURL* imageUrl;

@end

@implementation EmployeesCell

- (void) setEmployer:(Employer *)employer {
    _employer = employer;
    
    self.nameLabel.text = _employer.Name;
    
    self.titleLabel.text = _employer.Title;

    [self setupImage];
}

- (void) setupImage {
    LoginPassword* loginPassword = getLoginPassword();
    
    NSString* baseString = @"https://contact.taxsee.com/Contacts.svc/";
    NSString* loginString = [NSString stringWithFormat:@"GetWPhoto?login=%@", loginPassword.login];
    NSString* passwordString = [NSString stringWithFormat:@"&password=%@", loginPassword.password];
    NSString* emploerID = [NSString stringWithFormat:@"&id=%@", _employer.ID];
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@%@", baseString, loginString, passwordString, emploerID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    self.imageUrl = url;
    
    if ([self.imageUrl isEqual:url]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profileImageView.image = nil;
            [self.profileImageView sd_setImageWithURL:url];
        });
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
    }
    return self;
}

- (void) setupSubviews {
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.profileImageView.contentMode = UIViewContentModeScaleToFill;
    self.profileImageView.layer.cornerRadius = 5;
    self.profileImageView.clipsToBounds = YES;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16];
    self.nameLabel.text = @"test test";
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.allowsDefaultTighteningForTruncation = YES;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    
    self.dividerLineView = [[UIView alloc] initWithFrame:CGRectZero];
    self.dividerLineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [self addSubview:self.profileImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.dividerLineView];
    
    [self setConstraints];
}

- (void) setConstraints {
    self.profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dividerLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.profileImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:12].active = YES;
    [self.profileImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20].active = YES;
    [self.profileImageView.widthAnchor constraintEqualToConstant:50].active = YES;
    [self.profileImageView.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.profileImageView.topAnchor constant:-2].active = YES;
    [self.nameLabel.leftAnchor constraintEqualToAnchor:self.profileImageView.rightAnchor constant:12].active = YES;
    [self.nameLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-12].active = YES;
    [self.nameLabel.heightAnchor constraintEqualToConstant:20].active = YES;

    [self.titleLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:0].active = YES;
    [self.titleLabel.leftAnchor constraintEqualToAnchor:self.nameLabel.leftAnchor constant:0].active = YES;
    [self.titleLabel.rightAnchor constraintEqualToAnchor:self.nameLabel.rightAnchor constant:-12].active = YES;
    [self.titleLabel.heightAnchor constraintEqualToConstant:34].active = YES;
    
    [self.dividerLineView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
    [self.dividerLineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
    [self.dividerLineView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
    [self.dividerLineView.heightAnchor constraintEqualToConstant:1].active = YES;
}

@end














