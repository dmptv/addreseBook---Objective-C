//
//  HomeController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 05/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "HomeController.h"
#import "LoginController.h"
#import "EmployeesController.h"
#import "BureauController.h"
#import "AviaController.h"

#import "Utils.h"
#import "ApiService.h"
#import "Office.h"

#import "DepartmentCell.h"

#import "LoginPassword.h"

@interface HomeController () <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIRefreshControl* refreshControl;
@property (strong, nonatomic) NSMutableArray* dataSource;
@property (strong, nonatomic) Office* office;

@end

@implementation HomeController

static NSString * const cellId = @"Cell";

- (void) setOffice:(Office* ) office {
    _office = office;
    
    [self.dataSource removeAllObjects];
    for (NSDictionary* dic in _office.Departments) {
        Office* office = [Office new];
        office.Name = dic[@"Name"];
        office.ID = dic[@"ID"];
        office.Employees = dic[@"Employees"];
        office.Departments = dic[@"Departments"];
        [self.dataSource addObject:office];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    
    self.navigationItem.title = @"Все";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(handleLogout)];
    self.navigationItem.leftBarButtonItem.tintColor = BROWN_COLOR;
    
    [self setupCollectionView];
    
    [self fetchData];
}

- (void) fetchData {
    LoginPassword* loginPassword = getLoginPassword();
    
    __weak HomeController* weakSelf = self;
    
    [[ApiService shared] fetchOffice:loginPassword.login withPassword:loginPassword.password onSuccess:^(Office* office) {
        
        weakSelf.office = office;
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void) setupCollectionView {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor redColor];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    
    self.view.backgroundColor = getImageFromContex(self.view.frame, @"sculpt");
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerClass:[DepartmentCell class] forCellWithReuseIdentifier:cellId];
}

#pragma mark - Habdles

- (void) handleLogout {
    BOOL flag = NO;
    setIsLoggedIn(flag);
    LoginController* lc = [[LoginController alloc] init];
    [self presentViewController:lc animated:YES completion:nil];
}

- (void) loadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    [self.refreshControl endRefreshing];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DepartmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.nameLabel.text = ((Office*)self.dataSource[indexPath.item]).Name;
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.frame), 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
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




















