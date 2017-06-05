//
//  LoginCell.h
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginControllerDelegate;

@interface LoginCell : UICollectionViewCell

@property (weak, nonatomic) id <LoginControllerDelegate> delegate;

@end

@protocol LoginControllerDelegate

@required

- (void) finishLoggingIn;

@end
