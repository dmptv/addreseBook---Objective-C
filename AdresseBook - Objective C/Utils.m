//
//  CollectionViewCell.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "Utils.h"

  // custom nslog
void AKLog(NSString* format, ...) {
#if LOGS_ENABLED
    va_list argumentList;
    va_start(argumentList, format);
    
    NSLogv(format, argumentList);
    va_end(argumentList);
#endif
}

  // NSDate
NSString* fancyDateStringFromDate(NSDate* date) {
    static NSDateFormatter* formatter = nil;
    
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"-- dd : MM : yy --"];
    }
    return [formatter stringFromDate:date];
}

  // Device
BOOL iPad() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

BOOL iPhone() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

  // NSUserDefaults
NSString * const kIsLoggedIn = @"kIsLoggedIn";
NSString * const kLogin = @"kLogin";
NSString * const kPassword = @"kPassword";

NSUserDefaults* userDefaults() {
   return [NSUserDefaults standardUserDefaults];
}

void setIsLoggedIn(BOOL flag) {
    [userDefaults() setBool:flag forKey:kIsLoggedIn];
}

BOOL isLoggedIn() {
    return [userDefaults() boolForKey:kIsLoggedIn];
}

void saveLoginPassword(NSString* login, NSString* password) {
    [userDefaults() setObject:login forKey:kLogin];
    [userDefaults() setObject:password forKey:kPassword];
}

LoginPassword* getLoginPassword() {
    LoginPassword* loginPassword = [[LoginPassword alloc] init];
    loginPassword.login = [userDefaults() stringForKey:kLogin];
    loginPassword.password = [userDefaults() stringForKey:kPassword];
    return loginPassword;
}

  // AlertController
void showAlertWithTitle(NSString* title, NSString* message) {
    UIAlertController* loginAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [loginAlert addAction:action];
    
    UIViewController* topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    [topVC presentViewController:loginAlert animated:YES completion:nil];
}

  // draw image as background
UIColor* getImageFromContex(CGRect frame, NSString* imageName) {
    UIGraphicsBeginImageContext(frame.size);
    UIImage* image = [UIImage imageNamed:imageName];
    [image drawInRect:frame];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:newImage];
}


















