//
//  CollectionViewCell.h
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoginPassword.h"

 // 0 - to switch off custom nslog
#define LOGS_ENABLED 0
void AKLog(NSString* format, ...);

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a/255.f]

#define LOGIN_COLOR [UIColor colorWithRed:122.f/255.f green:83.f/255.f blue:115.f/255.f alpha:255.f/255.f]

#define BROWN_COLOR [UIColor colorWithRed:91.f/255.f green:14.f/255.f blue:13.f/255.f alpha:255.f/255.f]

NSString* fancyDateStringFromDate(NSDate* date);

BOOL iPad();
BOOL iPhone();

NSUserDefaults* userDefaults();
void setIsLoggedIn(BOOL flag);
BOOL isLoggedIn();
void saveLoginPassword(NSString* login, NSString* password);

LoginPassword* getLoginPassword();

void showAlertWithTitle(NSString* title, NSString* message);

UIColor* getImageFromContex(CGRect frame, NSString* imageName);

















