//
//  InfoCell.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 08/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "InfoCell.h"
#import "Utils.h"
#import <MessageUI/MessageUI.h>

@interface InfoCell () <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UILabel* nameLabel;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* emailLabel;
@property (strong, nonatomic) UILabel* phoneLabel;
@property (strong, nonatomic) UIButton* emailButton;
@property (strong, nonatomic) UIButton* phoneButton;

@end

@implementation InfoCell

- (void) setEmployer:(Employer *)employer {
    _employer = employer;
    
    if (_employer.Name != nil) {
        self.nameLabel.frame = CGRectMake(12, 8, CGRectGetWidth(self.frame) - 8, CGRectGetHeight(self.frame) - 16);
        self.nameLabel.text = _employer.Name;
        [self addSubview:self.nameLabel];

    } else if (_employer.Title != nil) {
        self.titleLabel.frame = CGRectMake(12, 0, CGRectGetWidth(self.frame) - 8, CGRectGetHeight(self.frame));
        self.titleLabel.text = _employer.Title;
        [self addSubview:self.titleLabel];
        
    } else if (_employer.Email != nil) {
        self.emailLabel.frame = CGRectMake(12, 8, CGRectGetWidth(self.frame) / 4, CGRectGetHeight(self.frame) - 16);
        [self addSubview:self.emailLabel];
        
        self.emailButton.frame = CGRectMake(CGRectGetWidth(self.emailLabel.frame), 8, CGRectGetWidth(self.frame) - CGRectGetWidth(self.emailLabel.frame) - 8, CGRectGetHeight(self.frame) - 8);
        [self.emailButton setTitle:_employer.Email forState:UIControlStateNormal];
        [self addSubview:self.emailButton];
        
    } else if (_employer.Phone != nil) {
        self.phoneLabel.frame = CGRectMake(12, 8, CGRectGetWidth(self.frame) / 4, CGRectGetHeight(self.frame) - 16);
        [self addSubview:self.phoneLabel];
        
        self.phoneButton.frame = CGRectMake(CGRectGetWidth(self.phoneLabel.frame), 8, CGRectGetWidth(self.frame) - CGRectGetWidth(self.phoneLabel.frame) - 8, CGRectGetHeight(self.frame) - 8);
        [self.phoneButton setTitle:_employer.Phone forState:UIControlStateNormal];
        [self addSubview:self.phoneButton];
    }
    
    [self setNeedsDisplayInRect:self.frame];
    
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
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.allowsDefaultTighteningForTruncation = YES;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.emailLabel = [UILabel new];
    self.emailLabel.font = [UIFont systemFontOfSize:14];
    self.emailLabel.numberOfLines = 2;
    self.emailLabel.text = @"Email:";
 
    self.phoneLabel = [UILabel new];
    self.phoneLabel.font = [UIFont systemFontOfSize:14];
    self.phoneLabel.numberOfLines = 2;
    self.phoneLabel.text = @"Phone:";
    
    self.emailButton = [UIButton new];
    [self.emailButton setTitleColor:RGBA(61, 167, 244, 255) forState:UIControlStateNormal];
    self.emailButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.emailButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.emailButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    self.emailButton.layer.cornerRadius = 5;
    self.emailButton.layer.borderColor = RGBA(61, 167, 244, 255).CGColor;
    self.emailButton.layer.borderWidth = 1;
    [self.emailButton setImage:[UIImage imageNamed:@"mail"] forState:UIControlStateNormal];
    self.emailButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.emailButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [self.emailButton addTarget:self action:@selector(handleSentEmail) forControlEvents:UIControlEventTouchUpInside];

    self.phoneButton = [UIButton new];
    [self.phoneButton setTitleColor:RGBA(61, 167, 244, 255) forState:UIControlStateNormal];
    self.phoneButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.phoneButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.phoneButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    self.phoneButton.layer.cornerRadius = 5;
    self.phoneButton.layer.borderColor = RGBA(61, 167, 244, 255).CGColor;
    self.phoneButton.layer.borderWidth = 1;
    [self.phoneButton setImage:[UIImage imageNamed:@"123"] forState:UIControlStateNormal];
    self.phoneButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.phoneButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [self.phoneButton addTarget:self action:@selector(handlePhoneCall) forControlEvents:UIControlEventTouchUpInside];

}

- (void) handlePhoneCall {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.phoneButton.titleLabel.text]];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        showAlertWithTitle(@"Phone Alert", @"can't call phone");
    }
}

- (void) handleSentEmail {
    MFMailComposeViewController* mailCompose = [[MFMailComposeViewController alloc] init];
    mailCompose.mailComposeDelegate = self;
    
    [mailCompose setToRecipients:@[self.emailButton.titleLabel.text]];
    [mailCompose setSubject:@"Test"];
    [mailCompose setMessageBody:@"Hi" isHTML: NO];
    
    UIViewController* activeVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([MFMailComposeViewController canSendMail]) {
        mailCompose.navigationBar.tintColor = BROWN_COLOR;
       
        [activeVC presentViewController:mailCompose animated:YES completion:^{
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.alpha = 0;
                
            } completion:nil];
        }];
    } else {
        showAlertWithTitle(@"Email Alert", @"can't send email");
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result) {
        case MFMailComposeResultCancelled:
            showAlertWithTitle(@"mail alert", @"cancel mail");
            break;
        case MFMailComposeResultSaved:
            showAlertWithTitle(@"mail alert", @"saved mail");
            break;
        case MFMailComposeResultFailed:
            showAlertWithTitle(@"mail alert", @"failed sent");
            break;
        case MFMailComposeResultSent:
            showAlertWithTitle(@"mail alert", @"mail sent");
            break;
        default:
            break;
    }
    
    UIViewController* activeVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [activeVC dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 1;
            [self layoutIfNeeded];
            
        } completion:nil];
    }];
}


@end


















