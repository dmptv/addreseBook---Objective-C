//
//  PageCell.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "PageCell.h"
#import "Utils.h"

@interface PageCell ()

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UITextView* textView;
@property (strong, nonatomic) UIView* lineSeparatorView;

@end

@implementation PageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupViews];
    }
    return self;
}

- (void) setPage:(Page *) page {
    _page = page;
    
    self.imageView.image = [UIImage imageNamed:_page.imageName];
    
    // Attributed text
    NSString* text = _page.title;
    UIFont* font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    UIColor* color = [UIColor colorWithWhite:0.2 alpha:1];
   
    NSMutableDictionary *attributes =  [NSMutableDictionary dictionary];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:color forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString* attributedtext = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    UIFont* messageFont = [UIFont systemFontOfSize:14];
    
    NSMutableDictionary *attributes2 =  [NSMutableDictionary dictionary];
    [attributes setObject:messageFont forKey:NSFontAttributeName];
    [attributes setObject:color forKey:NSForegroundColorAttributeName];
    
    NSString* message = _page.message;
    NSMutableAttributedString* messageAttributedText = [[NSMutableAttributedString alloc] initWithString:message attributes:attributes2];
    
    [attributedtext appendAttributedString:messageAttributedText];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSRange range = NSMakeRange(0, attributedtext.length);
    [attributedtext addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:range];
    
    self.textView.attributedText = attributedtext;
}

- (void) setupViews {
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.image = [UIImage imageNamed: @"addresse"];
    self.imageView.backgroundColor = [UIColor whiteColor];
    
    self.textView = [UITextView new];
    self.textView.text = @"temporary content text";
    self.textView.contentInset = UIEdgeInsetsMake(24, 0, 0, 0);
    self.textView.selectable = NO;
    self.textView.editable = NO;
    self.textView.backgroundColor = RGBA(122, 83, 115, 255);
    
    self.lineSeparatorView = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineSeparatorView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self setupConstraints];
}

- (void) setupConstraints {
    [self addSubview:self.textView];
    [self addSubview:self.imageView];
    [self addSubview:self.lineSeparatorView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.textView.topAnchor constant:0].active = YES;
    [self.imageView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
    
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:16].active = YES;
    [self.textView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20].active = YES;
    [self.textView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-16].active = YES;
    [self.textView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.3].active = YES;
    
    self.lineSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.lineSeparatorView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
    [self.lineSeparatorView.bottomAnchor constraintEqualToAnchor:self.textView.topAnchor constant:0].active = YES;
    [self.lineSeparatorView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
    [self.lineSeparatorView.heightAnchor constraintEqualToConstant:1].active = YES;
}

@end


































