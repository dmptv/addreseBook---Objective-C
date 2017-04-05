//
//  ViewController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "MainNavigationController.h"
#import "LoginController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showLoginController];
}

- (void) showLoginController {
    LoginController* lc = [LoginController new];
    [self presentViewController:lc animated:YES completion:nil];
}



@end
