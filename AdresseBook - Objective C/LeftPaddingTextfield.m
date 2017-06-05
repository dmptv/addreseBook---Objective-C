//
//  LeftPaddingTextfield.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "LeftPaddingTextfield.h"

@implementation LeftPaddingTextfield


- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
    return rect;
}


@end
