//
//  AviaController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 07/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "AviaController.h"
#import "BureauController.h"
#import "EmployeesController.h"

#import "EmployeesHeader.h"
#import "EmployeesCell.h"
#import "DepartmentCell.h"

@interface AviaController ()

@property (strong , nonatomic) UIRefreshControl* refresher;
@property (strong, nonatomic) NSMutableArray* dataSource;

@end

@implementation AviaController

static NSString * const employeesId = @"employeesId";

- (void) setOffice:(Office* ) office {
    _office = office;
    
    if (self.dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    } else {
        [self.dataSource removeAllObjects];
    }

    for (NSDictionary* dic in _office.Departments) {
        Office* office = [Office new];
        [office setValuesForKeysWithDictionary:dic];
        [self.dataSource addObject:office];
    }

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
    self.collectionView.alwaysBounceVertical = YES;
    
    self.view.backgroundColor = getImageFromContex(self.view.frame, @"sculpt");
    self.collectionView.backgroundColor = [UIColor clearColor];

    [self.collectionView registerClass:[DepartmentCell class] forCellWithReuseIdentifier:employeesId];
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
    
    DepartmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:employeesId forIndexPath:indexPath];
    
    Office* office = self.dataSource[indexPath.item];
    cell.nameLabel.text = office.Name;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CGRectGetWidth(self.view.frame), 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    
    Office* office = self.dataSource[indexPath.item];
    
    if (office.Employees != nil) {
        EmployeesController* vc = [[EmployeesController alloc] initWithCollectionViewLayout:layout];
        
        vc.office = office;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ((office.Employees == nil) && (office.Departments == nil)) {
        BureauController* vc = [[BureauController alloc] initWithCollectionViewLayout:layout];
        vc.office = office;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        AviaController* vc = [[AviaController alloc] initWithCollectionViewLayout:layout];
        vc.office = office;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

@end

















