//
//  ApiService.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "ApiService.h"
#import "Utils.h"

#import "Employer.h"

@implementation ApiService

+ (ApiService*) shared {
    static ApiService* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ApiService alloc] init];
    });
    return manager;
}

- (void) fetchOffice:(NSString*) login
        withPassword:(NSString*) password
           onSuccess:(void(^)(Office* office)) success {
    
    NSString* baseString = @"https://contact.taxsee.com/Contacts.svc/";
    NSString* loginString = [NSString stringWithFormat:@"GetAll?login=%@", login];
    NSString* passwordString = [NSString stringWithFormat:@"&password=%@", password];
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@", baseString, loginString, passwordString];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                showAlertWithTitle(@"Connection problem", @"The Internet connection appears to be offline");
            });
            return;
        }
        
        NSError* jsonError;
        
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        if (jsonError) {
            NSLog(@"jsonis not valid %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                showAlertWithTitle(@"Connection", @"Server does not responce properly");
            });
            return;
        }
        
        Office* office = [Office new];
        office.Name = json[@"Name"];
        office.ID = json[@"ID"];
        office.Departments = json[@"Departments"];
        
        if (success) {
            success(office);
        }
        
    }];
    [task resume];
}

- (void) fetchAutorization:(NSString*) login
              withPassword:(NSString*) password
                 onSuccess:(void(^)(NSNumber* result)) success
                 onFailure:(void(^)(NSNumber* error)) failure {
    
    NSString* baseString = @"https://contact.taxsee.com/Contacts.svc/";
    NSString* loginString = [NSString stringWithFormat:@"Hello?login=%@", login];
    NSString* passwordString = [NSString stringWithFormat:@"&password=%@", password];
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@", baseString, loginString, passwordString];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                showAlertWithTitle(@"Connection problem", @"The Internet connection appears to be offline");
            });
            
            return;
        }
        
        NSError* jsonError;
        
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        if (jsonError) {
            NSLog(@"jsonis not valid %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                showAlertWithTitle(@"Connection", @"Server does not responce properly");
            });
            return;
        }
        
        NSNumber* jsonResult = [json objectForKey:@"Success"];
        if (jsonResult.boolValue) {
            success(jsonResult);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(jsonResult);
            });
        }
        
    }];
    [task resume];
}

@end
























