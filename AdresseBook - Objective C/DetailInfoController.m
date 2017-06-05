//
//  DetailInfoController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 07/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "DetailInfoController.h"
#import "Employer.h"

#import "Utils.h"
#import "InfoCell.h"
#import "ImageHeader.h"


@interface DetailInfoController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) NSURL* imageUrl;
@property (strong, nonatomic) NSMutableArray* dataSource;
@property (strong, nonatomic) NSArray* cellIdentifiers;

@end

@implementation DetailInfoController

static NSString* const headerId = @"headerId";

- (void) setEmployer:(Employer *)employer {
    _employer = employer;
    
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i <= 3; i++) {
        
        Employer* empl = [Employer new];
        switch (i) {
            case 0:
                empl.Name = _employer.Name;
                break;
            case 1:
                empl.Title = _employer.Title;
                break;
            case 2:
                empl.Email = _employer.Email;
                break;
            case 3:
                empl.Phone = _employer.Phone;
                break;
            default:
                break;
        }
        [self.dataSource addObject:empl];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void) setupViews {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat height = CGRectGetHeight(self.navigationController.navigationBar.frame);
    CGRect frame = CGRectMake(0, height, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - height);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.collectionView];
    
    self.cellIdentifiers = @[@"nameCellId", @"titleCellId", @"emailCellId", @"phoneCellId", @"lastCellId"];
    
    for (int i = 0; i <= 4; i++) {
       [self.collectionView registerClass:[InfoCell class] forCellWithReuseIdentifier:self.cellIdentifiers[i]];
    }
    
    [self.collectionView registerClass:[ImageHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    InfoCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifiers[indexPath.item] forIndexPath:indexPath];
    
  
    if (indexPath.item == self.dataSource.count) {
        return cell;
    }
    
    cell.employer = self.dataSource[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CGRectGetWidth(self.view.frame), 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat height = (CGRectGetWidth(self.view.frame) - 12 - 12) * 9 / 16;
    
    return CGSizeMake(CGRectGetWidth(self.view.frame), height + 20);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ImageHeader* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
    header.employer = self.employer;
    
    return header;
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

@end








