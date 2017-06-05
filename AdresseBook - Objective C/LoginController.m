//
//  LoginController.m
//  AdresseBook - Objective C
//
//  Created by Kanat A on 04/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

#import "LoginController.h"
#import "MainNavigationController.h"
#import "HomeController.h"

#import "Utils.h"
#import "ApiService.h"

#import "PageCell.h"
#import "LoginCell.h"

#import "Page.h"

@interface LoginController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LoginControllerDelegate>

@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) UIPageControl* pageControl;
@property (strong, nonatomic) UIButton* skipButton;
@property (strong, nonatomic) NSLayoutConstraint* pageControlBottomAnchor;
@property (strong, nonatomic) NSLayoutConstraint* skipButtonTopAnchor;

@end

@implementation LoginController

static NSString* const cellId = @"cellId";
static NSString* const loginCellId = @"loginCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pages = [NSMutableArray array];
    
    [self observeKeyBoardNotifications];
    
    [self setupViews];
    [self registerCell];
}

- (void) setPages:(NSMutableArray *) pages {
    _pages = pages;
    
    Page* firstPage = [[Page alloc] init];
    firstPage.title = @"Тестовое задание на разработку мобильного приложения.";
    firstPage.message = @"\n\nТребуется разработать приложение «Адресная Книга» сотрудников компании.";
    firstPage.imageName = @"AB";
    [_pages addObject:firstPage];
}

- (void) setupViews {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.skipButton = [UIButton new];
    [self.skipButton setTitle:@"Skip" forState:UIControlStateNormal];
    self.skipButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.skipButton setTitleColor:LOGIN_COLOR forState:UIControlStateNormal];
    [self.skipButton addTarget:self action:@selector(handleSkip) forControlEvents:UIControlEventTouchUpInside];
    self.skipButton.translatesAutoresizingMaskIntoConstraints = NO;

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
    [self.view addSubview:self.skipButton];
    
    [self setupConstraint];
}

- (void) handleSkip {
    self.pageControl.currentPage = self.pages.count - 1;
    [self nextPage];
}
    
- (void) nextPage {
    if (self.pageControl.currentPage == self.pages.count) {
        return;
    }
    
    if (self.pageControl.currentPage == self.pages.count - 1) {
        [self moveControlConstraintsOffScreen];
        [self animateLayout];
    }
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:self.pageControl.currentPage + 1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    self.pageControl.currentPage += 1;
}

- (void) moveControlConstraintsOffScreen {
    self.pageControlBottomAnchor.constant = 40;
    self.skipButtonTopAnchor.constant = -40;
}

- (void) animateLayout {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

     // keyBoard

- (void) observeKeyBoardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyBoardShow {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGFloat y = UIDeviceOrientationIsLandscape(UIDeviceOrientationLandscapeLeft | UIDeviceOrientationLandscapeRight) ? -150 : -55;
        
        self.view.frame = CGRectMake(0, y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        
    } completion:nil];
}

- (void) keyBoardHide {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        
    } completion:nil];
}

- (void) setupConstraint {
    [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0].active = YES;
    [self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
    [self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
    
    [self.pageControl.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    self.pageControlBottomAnchor = [self.pageControl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0];
    self.pageControlBottomAnchor.active = YES;
    [self.pageControl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
    [self.pageControl.heightAnchor constraintEqualToConstant:40].active = YES;
    
    self.skipButtonTopAnchor = [self.skipButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:16];
    self.skipButtonTopAnchor.active = YES;
    [self.skipButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [self.skipButton.widthAnchor constraintEqualToConstant:60].active = YES;
    [self.skipButton.heightAnchor constraintEqualToConstant:50].active = YES;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pages.count + 1;
}

- (void) registerCell {
    [self.collectionView registerClass:[PageCell class] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerClass:[LoginCell class] forCellWithReuseIdentifier:loginCellId];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == self.pages.count) {
        LoginCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:loginCellId forIndexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    }
    
    PageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.page = self.pages[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    int pageNumber = (int)(targetContentOffset->x / self.view.frame.size.width);
    
    self.pageControl.currentPage = pageNumber;

    if (pageNumber == self.pages.count) {
        [self moveControlConstraintsOffScreen];
        
    } else {
        self.pageControlBottomAnchor.constant = 0;
        self.skipButtonTopAnchor.constant = 16;
    }

    [self animateLayout];
}

#pragma mark - <LoginControllerDelegate>

- (void) finishLoggingIn {
    if (isLoggedIn()) {
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        HomeController* hc = [[HomeController alloc] initWithCollectionViewLayout:layout];
        
        MainNavigationController* nav =
        (MainNavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        nav.viewControllers = @[hc];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:self.pageControl.currentPage inSection:0];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.collectionView reloadData];
    });
}



















@end












