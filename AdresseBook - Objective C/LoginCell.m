//
//  LoginCell.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "LoginCell.h"
#import "Utils.h"
#import "LeftPaddingTextfield.h"
#import "ApiService.h"

@interface LoginCell () <UITextFieldDelegate>

@property (strong, nonatomic) UIImageView* logoImageView;
@property (strong, nonatomic) UITextField* loginTextfield;
@property (strong, nonatomic) UITextField* passwordTextfield;
@property (strong, nonatomic) UIButton* loginButton;

@end

@implementation LoginCell

- (void) layoutSubviews {
    [super layoutSubviews];
    
    NSString* imageName = @"iconlogo";
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        
        imageName = @"";
    }
    
    self.logoImageView.image = [UIImage imageNamed:imageName];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self layoutSubviews];
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    NSString* imageName = @"iconlogo";

    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        
        imageName = @"";
    }
    
    self.logoImageView.image = [UIImage imageNamed:imageName];
    
    self.loginTextfield = [[LeftPaddingTextfield alloc] initWithFrame:CGRectZero];
    self.loginTextfield.placeholder = @"test_user";
    self.loginTextfield.textColor = [UIColor whiteColor];
    self.loginTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loginTextfield.layer.borderWidth = 1;
    self.loginTextfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.loginTextfield.delegate = self;
    
    self.passwordTextfield = [[LeftPaddingTextfield alloc] initWithFrame:CGRectZero];
    self.passwordTextfield.placeholder = @"test_pass";
    self.passwordTextfield.secureTextEntry = YES;
    self.passwordTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passwordTextfield.layer.borderWidth = 1;
    self.passwordTextfield.delegate = self;
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.loginButton.backgroundColor = RGBA(122, 83, 206, 255);
    [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    [self.loginButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(handleLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupConstraints];
}

- (void) handleLogin {
    NSString* loginString = self.loginTextfield.text;
    NSString* passwordString = self.passwordTextfield.text;
    // хард-код логин и пароль
    loginString = @"test_user";
    passwordString = @"test_pass";
    
    __weak LoginCell* wealSelf = self;
    
    [[ApiService shared] fetchAutorization:loginString withPassword:passwordString onSuccess:^(NSNumber* result) {
        
        setIsLoggedIn(result.boolValue);
        saveLoginPassword(loginString, passwordString);
        
        [wealSelf.delegate finishLoggingIn];
        
    } onFailure:^(NSNumber *error) {
        showAlertWithTitle(@"Login error", @"Login or password not valid");
    }];
}

- (void) setupConstraints {
    [self addSubview:self.logoImageView];
    [self addSubview:self.loginTextfield];
    [self addSubview:self.passwordTextfield];
    [self addSubview:self.loginButton];
    
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.logoImageView.topAnchor constraintEqualToAnchor:self.centerYAnchor constant:-230].active = YES;
    [self.logoImageView.widthAnchor constraintEqualToConstant:160].active = YES;
    [self.logoImageView.heightAnchor constraintEqualToConstant:160].active = YES;
    [self.logoImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0].active = YES;
    
    self.loginTextfield.translatesAutoresizingMaskIntoConstraints = NO;
    [self.loginTextfield.topAnchor constraintEqualToAnchor:self.logoImageView.bottomAnchor constant:16].active = YES;
    [self.loginTextfield.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:32].active = YES;
    [self.loginTextfield.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-32].active = YES;
    [self.loginTextfield.heightAnchor constraintEqualToConstant:50].active = YES;
    
    
    self.passwordTextfield.translatesAutoresizingMaskIntoConstraints = NO;
    [self.passwordTextfield.topAnchor constraintEqualToAnchor:self.loginTextfield.bottomAnchor constant:16].active = YES;
    [self.passwordTextfield.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:32].active = YES;
    [self.passwordTextfield.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-32].active = YES;
    [self.passwordTextfield.heightAnchor constraintEqualToConstant:50].active = YES;
    
    
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.loginButton.topAnchor constraintEqualToAnchor:self.passwordTextfield.bottomAnchor constant:16].active = YES;
    [self.loginButton.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:32].active = YES;
    [self.loginButton.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-32].active = YES;
    [self.loginButton.heightAnchor constraintEqualToConstant:50].active = YES;
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.loginTextfield isFirstResponder]) {
        [self.passwordTextfield becomeFirstResponder];
    } else {
        [self.passwordTextfield resignFirstResponder];
        [self handleLogin];
    }
    return YES;
}

@end

















