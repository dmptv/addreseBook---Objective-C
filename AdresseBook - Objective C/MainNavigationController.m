//
//  ViewController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "MainNavigationController.h"
#import "LoginController.h"
#import "HomeController.h"

#import "Utils.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self isLoggedIn]) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        HomeController* hc = [[HomeController alloc] initWithCollectionViewLayout:layout];
        // поставимм на стэк
        self.viewControllers = @[hc];
    } else {
        [self showLoginController];
    }
}


- (BOOL) isLoggedIn {
    return isLoggedIn();
}

- (void) showLoginController {
    LoginController* lc = [LoginController new];
    [self presentViewController:lc animated:YES completion:nil];
}



@end






