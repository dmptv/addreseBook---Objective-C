//
//  LoginController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "LoginController.h"
#import "Utils.h"

#import "PageCell.h"

@interface LoginController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) UIPageControl* pageControl;

@end

@implementation LoginController

NSString* cellId = @"cellId";
NSString* loginCellId = @"loginCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupViews];
    
    [self.collectionView registerClass:[PageCell class] forCellWithReuseIdentifier:cellId];
     [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:loginCellId];
}

- (void) setupViews {
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = LOGIN_COLOR;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.pageControl = [UIPageControl new];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPageIndicatorTintColor = RGBA(247, 154, 27, 255);
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    
    [self setupConstraint];
}

- (void) setupConstraint {
    [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0].active = YES;
    [self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
    [self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
    
    [self.pageControl.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [self.pageControl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
    [self.pageControl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
    [self.pageControl.heightAnchor constraintEqualToConstant:40].active = YES;
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        PageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        
        return cell;
    }
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:loginCellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
}



















































@end
