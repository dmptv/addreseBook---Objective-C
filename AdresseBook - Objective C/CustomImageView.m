//
//  CustomImageView.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 09/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "CustomImageView.h"

@interface CustomImageView ()

@property (assign, nonatomic) NSInteger imageTag;
@property (strong, nonatomic) UIImageView* fullscreenImageView;
@property (strong, nonatomic) UILabel* closeLabel;

@end

@implementation CustomImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.imageTag = 35012;
    
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullscreen)];
    [self addGestureRecognizer:gesture];
}

- (void) showFullscreen {
    UIWindow* window = [[[UIApplication sharedApplication] windows] firstObject];
    
    if ([window viewWithTag:self.imageTag] == nil) {
        
        self.fullscreenImageView = [self createFullscreenPhoto];
        self.closeLabel = [self createLabel];
        
        CGFloat labelWidth =  CGRectGetWidth(window.frame);
        CGFloat labelHeight = CGRectGetHeight(self.closeLabel.frame) + 16;
        
        self.closeLabel.frame = CGRectMake(0, CGRectGetHeight(window.frame) - labelHeight, labelWidth, labelHeight);
        
        [self.fullscreenImageView addSubview:self.closeLabel];
        
        [window addSubview:self.fullscreenImageView];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.fullscreenImageView.frame = window.frame;
            self.fullscreenImageView.alpha = 1;
            [self.fullscreenImageView layoutSubviews];
            
            self.closeLabel.alpha = 1;
            
        } completion:^(BOOL finished) {}];
    }
}

- (UIImageView*) createFullscreenPhoto {
    UIImageView* tmpImageView = [[UIImageView alloc] initWithFrame:self.frame];
    tmpImageView.contentMode = UIViewContentModeScaleAspectFill;
    tmpImageView.image = self.image;
    tmpImageView.backgroundColor = [UIColor blackColor];
    tmpImageView.tag = self.imageTag;
    tmpImageView.alpha = 0.0;
    tmpImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideFullscreen)];
    [tmpImageView addGestureRecognizer:tap];
    
    return tmpImageView;
}

- (UILabel*) createLabel {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"Touch to hide";
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.alpha = 0.0;
    
    return label;
}

- (void) hideFullscreen {
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.fullscreenImageView.frame = self.frame;
        self.fullscreenImageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.fullscreenImageView removeFromSuperview];
        self.fullscreenImageView = nil;
    }];
}



@end
















