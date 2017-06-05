//
//  ApiService.h
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Office.h"

@interface ApiService : NSObject

+ (ApiService*) shared;

- (void) fetchAutorization:(NSString*) login
              withPassword:(NSString*) password
                 onSuccess:(void(^)(NSNumber* result)) success
                 onFailure:(void(^)(NSNumber* error)) failure;

- (void) fetchOffice:(NSString*) login
        withPassword:(NSString*) password
           onSuccess:(void(^)(Office* office)) success;

@end

