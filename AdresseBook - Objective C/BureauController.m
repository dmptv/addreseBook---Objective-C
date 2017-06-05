//
//  BureauController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 07/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "BureauController.h"
#import "EmployeesHeader.h"
#import "EmployeesCell.h"
#import "DetailInfoController.h"

@interface BureauController ()

@property (strong , nonatomic) UIRefreshControl* refresher;
@property (strong, nonatomic) NSMutableArray* dataSource;

@end

@implementation BureauController

static NSString * const employeesId = @"employeesId";
static NSString * const headerId = @"headerId";

- (void) setOffice:(Office* ) office {
    _office = office;
    
    if (self.dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    } else {
         [self.dataSource removeAllObjects];
    }
   
    Employer* employer = [Employer new];
    employer.Name = office.Name;
    employer.ID = office.ID;
    
    [self.dataSource addObject:employer];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
}

- (void) viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void) setupCollectionView {
    self.refresher = [UIRefreshControl new];
    self.refresher.tintColor = [UIColor redColor];
    [self.refresher addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    
    [self.collectionView addSubview:self.refresher];
    self.collectionView.backgroundColor = RGBA(232, 236, 200, 255);
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerClass:[EmployeesCell class] forCellWithReuseIdentifier:employeesId];
    [self.collectionView registerClass:[EmployeesHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
}

- (void) loadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    [self.refresher endRefreshing];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmployeesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:employeesId forIndexPath:indexPath];
    cell.employer = self.dataSource[indexPath.item];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CGRectGetWidth(self.view.frame), 70);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(CGRectGetWidth(self.view.frame), 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    EmployeesHeader* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
    
    return header;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailInfoController* vc = [[DetailInfoController alloc] init];
    vc.employer = self.dataSource[indexPath.item];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

@end









