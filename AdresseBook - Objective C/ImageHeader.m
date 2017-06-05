//
//  ImageHeader.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 08/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "ImageHeader.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Utils.h"
#import "LoginPassword.h"
#import "CustomImageView.h"



@interface ImageHeader ()

@property (strong, nonatomic) CustomImageView* profileImageView;
@property (strong, nonatomic) NSURL* imageUrl;

@end

@implementation ImageHeader

- (void) setEmployer:(Employer *)employer {
    _employer = employer;

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
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    self.profileImageView = [[CustomImageView alloc] initWithFrame:CGRectZero];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.layer.cornerRadius = 5;
    self.profileImageView.layer.masksToBounds = YES;
    
    self.profileImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    self.profileImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;


    [self addSubview:self.profileImageView];
    
};


@end










